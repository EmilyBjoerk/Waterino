#ifndef GUARD_WATERINO_WATERINO_HPP
#define GUARD_WATERINO_WATERINO_HPP

#include "ierrorreporter.hpp"
#include "xtd_uc/avr.hpp"
#include "xtd_uc/chrono.hpp"

using namespace xtd::chrono_literals;

// This class implements the main loop and control logic of the Waterino project.
//
// It is implemented as a template taking the main components as template type
// parameters which are then stored by value inside of the Waterino object.
// The reason for doing this is to allow the implementation types to be replaced
// with test doubles for unit testing purposes without incurring the cost of storing
// pointers to each of the components (8 bytes SRAM per Waterino object, we will support up to 8
// waterino objects per main board so 64 bytes) and avoid using virtual functions which would
// necessitate VTables on each of the components which would be another 60 or so bytes of precious
// SRAM. All in all, I belive that this strategy saves around 10% of the SRAM available in lower end
// MCUs (1K SRAM) used for the Waterino.
template <class Pump, class Controller, class Probe, class CmdInterface, class ErrorReporter>
class Waterino {
public:
  using duration = xtd::chrono::steady_clock::duration;
  using time_point = xtd::chrono::steady_clock::time_point;

public:
  Waterino(const Pump& pump_, const Controller& controller_, const Probe& probe_,
           const CmdInterface& cmdif_, const ErrorReporter& errors_)
      : m_pump(pump_),
        m_controller(controller_),
        m_probe(probe_),
        m_cmdif(cmdif_),
        m_error_reporter(errors_) {}

  bool check_overflow() {
    return !m_pump.has_overflowed();
    // It is possible that the target watering period simply isn't possible due to
    // too small pot or other physical effects. This is indicated by an overflow.
    // from the previous pumping.
    // Advise the controller.
    // g_controller.report_overflow(); //TODO: FIXME
  }

  bool check_pump_activated(const time_point& now) {
    // Check that the probe is not dry again a short time after watering.
    // If it is this could indicate one of the following failure modes:
    //
    // * The pump is dead and no water was added.
    // * The amount of water added was so small it dried out too quick.
    // * The temperature is so high that water evaporates instantly.
    //
    // We should not check immediately after watering as the pump outlet
    // may not be (or should not be) positioned immediately next to the probe
    // and it may take a while for the moisture to spread in the soil.

    // We have pumped at least once since restart.
    if (m_last_pump.time_since_epoch() > 0_s) {
      auto time_since_last_pump = now - m_last_pump;

      // We expect the moisture to take at most 1 hour to spread enough to
      // bring the measured moisture level above the threshold.
      // However if it has been 4 hours since we watered, then it is feasible
      // that the water has dried out naturally (small amount of water or
      // hot weather).
      if (1_h < time_since_last_pump && time_since_last_pump < 4_h) {
        return !m_probe.is_dry();
      }
    }
    return true;
  }

  bool run(const time_point& now) {
    if (m_pump.is_pumping()){
      m_pump.reset_pumping();
      m_error_reporter.report(error_type::fuse_blown);
      return false;
    }
    
    if (!check_overflow()) {
      m_controller.report_overflow(m_last_pump_duration);
      m_error_reporter.report(error_type::overflow);
      // TODO: Should we do something more here?
    }

    if (!check_pump_activated(now)) {
      m_error_reporter.report(error_type::pump_failure);
      return false;
    }

    if (!m_probe.is_dry()) {
      return true;
    }

    m_last_pump_duration = m_controller.compute(now);
    m_last_pump = now;
    m_controller.report_activation(now);

    m_error_reporter.log() << xtd::pstr(PSTR("Activating pump for: "))
                           << xtd::chrono::milliseconds(m_last_pump_duration).count()
                           << xtd::pstr(PSTR("ms\n"));

    return m_pump.activate(m_last_pump_duration, m_error_reporter);
  }

private:
  Pump m_pump;
  Controller m_controller;
  Probe m_probe;
  CmdInterface m_cmdif;
  ErrorReporter m_error_reporter;

  time_point m_last_pump;
  duration m_last_pump_duration;
};

#endif
