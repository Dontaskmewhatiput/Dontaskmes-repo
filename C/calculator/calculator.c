#include <stdio.h>


void calculate(float num1, float num2, char op, float *result) {
  switch (op) {
   case '+':
     *result = num1 + num2;
     break;
   case '-':
     *result = num1 - num2;
     break;
   case '*':
     *result = num1 * num2;
     break;
   case '/':
     *result = num1 / num2;
     break;
   default:
     printf("Invalid operator\n");
     break;
  }
}

int main() {
  float num1, num2;
  char op;
  float result;

  printf("Enter your first number: ");
  scanf("%f", &num1);
  
  printf("Enter your operator: ");
  scanf(" %c", &op);

  printf("Enter your second number: ");
  scanf("%f", &num2);

  calculate(num1, num2, op, &result);

  printf("Your answer is: %.2f\n", result);
  return 0;
}

