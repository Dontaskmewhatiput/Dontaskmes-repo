#include <iostream>

bool calculate (float n1, float n2, char op, float &result)
{
    if (op == '+') {
        result = n1 + n2;
    } else if (op == '-') {
        result = n1 - n2;
    } else if (op == '*') {
        result = n1 * n2;
    } else if (op == '/') {
        if (n2 == 0) {
            std::cout << "Error, cannot divide by zero\n";
            return false;
        } else {
            result = n1 / n2;
        }
    } else {
        std::cout << "Error, invalid operator\n";
        return false;
    }

    return true;

}


int main () 
{
    float n1, n2;
    char op;
    float result;

    std::cout << "Select your first number: ";
    std::cin >> n1;

    std::cout << "Pick your operator (+, -, *, /) ";
    std::cin >> op;

    std::cout << "Select your second number: ";
    std::cin >> n2;

    calculate(n1, n2, op, result);

    std::cout << "Answer: " << result << std::endl;


}

