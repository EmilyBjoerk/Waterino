#include <iostream>

void foo(char x) {
    std::cout<<x<<std::endl;
}

int main() {
  static_assert(sizeof(char) != sizeof(int), "");
  double y = 3242.0;
  foo(y);  // Narrowing conversion
}
