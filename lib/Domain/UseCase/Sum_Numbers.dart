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

  int factorialTail(int n, int acc) {
    if(n==0) return acc;
    return factorialTail(n-1, acc * n);
  }

}

int sumNumbersIsolate(int n) {
  return SumNumbersUseCase().sumNumbers(n);
}

int nextFibonacciIsolate(int n) {
  return SumNumbersUseCase().fibonacciNumbers(n);
}

int factorialTailIsolate(int n, int acc){
  return SumNumbersUseCase().factorialTail(n, acc);
}