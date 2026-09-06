#include <stdio.h>

void calculate(float num1, float num2, char op, float *result) {
    if (op == '+') {
        *result = num1 + num2;
    } else if (op == '-') {
        *result = num1 - num2;
    } else if (op == '*') {
        *result = num1 * num2;
    } else if (op == '/') {
        if (num2 ==0) {
            printf("Error, cannot divide by zero\n");
        } else {
            *result = num1 / num2;
        }
    } 
    

}

int main () {
    float num1, num2;
    char op;
    float result;

    printf("Enter your first number: ");
    scanf("%f", &num1);

    printf("Pick an operator(+, -, *, /): ");
    scanf(" %c", &op);

    printf("Enter your second number: ");
    scanf("%f", &num2);

    calculate(num1, num2, op, &result); // Invokes the calculate function

    printf("Answer: %g\n", result);

}