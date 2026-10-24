// Stage 1: Dart Basics
// Learning variables, data types, and basic Dart syntax.
void main() {
  // 1. Largest of two numbers
  int a = 25;
  int b = 40;

  if (a > b) {
    print("Largest number: $a");
  } else {
    print("Largest number: $b");
  }

  // 2. Area of rectangle
  double length = 10;
  double width = 5;
  double area = length * width;

  print("Area of rectangle: $area");

  // 3. Even or Odd
  int number = 12;

  if (number % 2 == 0) {
    print("$number is Even");
  } else {
    print("$number is Odd");
  }

  // 4. Factorial
  int n = 5;
  int factorial = 1;

  for (int i = 1; i <= n; i++) {
    factorial *= i;
  }

  print("Factorial of $n: $factorial");

  // 5. Fibonacci Series
  int first = 0;
  int second = 1;

  print("Fibonacci Series:");

  for (int i = 0; i < 10; i++) {
    print(first);

    int next = first + second;
    first = second;
    second = next;
  }
}
