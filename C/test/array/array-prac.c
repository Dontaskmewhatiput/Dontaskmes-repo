#include <stdio.h>
// int main(void)
// {
//   int ages[] = {12, 15, 22, 28, 32, 58, 6, 80};
//   
//   int i;
//   int lowestAge = ages[0];
//   
//   int length = sizeof(ages) / sizeof(ages[0]);
// 
//   for (i = 0; i < length; i++) {
//     if (lowestAge > ages[i]) {
//       lowestAge = ages[i];
//     }
//   }
//   printf("The lowest age in the array is %d\n", lowestAge);
// }
// 
// 

int main(void) {
  int array[] = {3, -1, 7, 0, 9};
  int length = sizeof(array) / sizeof(array[0]);
  int i;

  for (i = 0; i < length; i++) {
    if (array[i] < 0) {
      continue;
    }
    if (array[i] == 0) {
      break;
    }
  }
  printf("%d\n", array[i]);
  return 0;
}