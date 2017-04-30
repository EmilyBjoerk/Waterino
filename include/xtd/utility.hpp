#ifndef GUARD_XTD_UTILITY_HPP
#define GUARD_XTD_UTILITY_HPP

namespace xtd{

    template<typename T>
    constexpr void swap(T& a, T&b){
        T c{a};
        a = b;
        b = c;        
    }

}

#endif
