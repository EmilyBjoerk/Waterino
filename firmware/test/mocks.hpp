#ifndef GUARD_WATERINO_TEST_MOCKS_HPP
#define GUARD_WATERINO_TEST_MOCKS_HPP

#include <gmock/gmock.h>
#include <memory>

#include "../src/icmdinterface.hpp"
#include "../src/icontroller.hpp"
#include "../src/ierrorreporter.hpp"
#include "../src/iprobe.hpp"
#include "../src/ipump.hpp"

using ::testing::NiceMock;

// Because Waterino class takes objects by reference and copies them to it's internal state
// to save memory we cannot direcly use the Mock.* classes as they are not copyable. Instead
// we wrap them in shared_ptrs held internally by test Test.* classes.

class MockPump : public IPump {
public:
  MOCK_METHOD0(reset_pumping, void());
  MOCK_METHOD0(overflow, void());
  MOCK_METHOD2(activate, bool(duration, IErrorReporter&));
  MOCK_METHOD1(set_max_pump, void(duration));

  MOCK_CONST_METHOD0(has_overflowed, bool());
  MOCK_CONST_METHOD0(is_pumping, bool());
  MOCK_CONST_METHOD0(print_stat, void());
};

class TestPump : public IPump {
public:
  void reset_pumping() override { m_mock->reset_pumping(); }
  void overflow() override { m_mock->overflow(); }
  bool activate(duration d, IErrorReporter& e) override { return m_mock->activate(d, e); }
  void set_max_pump(duration d) override { return m_mock->set_max_pump(d); }
  bool has_overflowed() const override { return m_mock->has_overflowed(); }
  bool is_pumping() const override { return m_mock->is_pumping(); }
  void print_stat() const override { return m_mock->print_stat(); }

  NiceMock<MockPump>& mock() { return *m_mock; }

private:
  std::shared_ptr<NiceMock<MockPump>> m_mock = std::make_shared<NiceMock<MockPump>>();
};

class MockController : public IController {
public:
  MOCK_METHOD1(report_activation, void(const time_point&));
  MOCK_METHOD1(report_overflow, void(const duration&));

  MOCK_CONST_METHOD1(compute, duration(const time_point&));
  MOCK_CONST_METHOD1(print_stat, void(const time_point&));
};

class TestController : public IController {
public:
  void report_activation(const time_point& tp) override { m_mock->report_activation(tp); }

  void report_overflow(const duration& d) override { m_mock->report_overflow(d); }

  duration compute(const time_point& tp) const override { return m_mock->compute(tp); }
  void print_stat(const time_point& tp) const override { m_mock->print_stat(tp); }

  NiceMock<MockController>& mock() { return *m_mock; }

private:
  std::shared_ptr<NiceMock<MockController>> m_mock = std::make_shared<NiceMock<MockController>>();
};

class MockProbe : public IProbe {
public:
  MOCK_CONST_METHOD0(is_dry, bool());
  MOCK_CONST_METHOD0(read, adc_value_type());
  MOCK_CONST_METHOD0(print_stat, void());
};

class TestProbe : public IProbe {
public:
  bool is_dry() const override { return m_mock->is_dry(); }
  adc_value_type read() const override { return m_mock->read(); }
  void print_stat() const override { m_mock->print_stat(); }

  NiceMock<MockProbe>& mock() { return *m_mock; }

private:
  std::shared_ptr<NiceMock<MockProbe>> m_mock = std::make_shared<NiceMock<MockProbe>>();
};

class MockCmdInterface : public ICmdInterface {
public:
};

class TestCmdInterface : public ICmdInterface {
public:
  NiceMock<MockCmdInterface>& mock() { return *m_mock; }

private:
  std::shared_ptr<NiceMock<MockCmdInterface>> m_mock =
      std::make_shared<NiceMock<MockCmdInterface>>();
};

class MockErrorReporter : public IErrorReporter {
public:
  MOCK_METHOD1(report, void(error_type));
  MOCK_METHOD0(log, std::ostream&());
};

class TestErrorReporter : public IErrorReporter {
public:
  void report(error_type t) override { mock().report(t); }
  std::ostream& log() override { return mock().log(); }

  NiceMock<MockErrorReporter>& mock() { return *m_mock; }

private:
  std::shared_ptr<NiceMock<MockErrorReporter>> m_mock =
      std::make_shared<NiceMock<MockErrorReporter>>();
};

#endif
