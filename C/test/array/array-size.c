#include <stdio.h>

int main() {
  int i;
  int array[] = {25, 50, 75, 100, 101, 102, 103, 104, 105};

  int length = sizeof(array) / sizeof(array[0]);

  for (i = 0; i < length; i++) {
    printf("%d\n", array[i]);
  }
  // This will print the arrays no matter what because of the length
  // integer

  return 0;
}