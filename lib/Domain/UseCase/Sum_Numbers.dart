class SumNumbersUseCase {
  int sumNumbers(int n) {
    int sum = 0;
    for (int i = 1; i <= n; i++) {
      sum += i;
    }
    return sum;
  }

  int fibonacciNumbers(int currentValue) {
    int a = 0, b = 1;
    while (b <= currentValue) {
      int temp = a + b;
      a = b;
      b = temp;
    }
    return b;
  }
}

int sumNumbersIsolate(int n) {
  return SumNumbersUseCase().sumNumbers(n);
}

int nextFibonacciIsolate(int n) {
  return SumNumbersUseCase().fibonacciNumbers(n);
}