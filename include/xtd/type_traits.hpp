#ifndef GUARD_XTD_TYPE_TRAITS_HPP
#define GUARD_XTD_TYPE_TRAITS_HPP
namespace xtd {

  template <bool B, class T = void>
  struct enable_if {};

  template <class T>
  struct enable_if<true, T> {
    typedef T type;
  };

  template <bool B, class T = void>
  using enable_if_t = typename enable_if<B, T>::type;

  template <class T, T v>
  struct integral_constant {
    static constexpr T value = v;
    using value_type = T;
    using type = integral_constant;  // using injected-class-name
    constexpr operator value_type() const noexcept { return value; }
    constexpr value_type operator()() const noexcept { return value; }  // since c++14
  };

  template <bool B>
  using bool_constant = integral_constant<bool, B>;
}
#endif
