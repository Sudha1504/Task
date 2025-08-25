class SumNumbersUseCase {
  int sumNumbers(int n) {
    int sum = 0;
    for (int i = 1; i <= n; i++) {
      sum += i;
    }
    return sum;
  }
}

int sumNumbersIsolate(int n) {
  return SumNumbersUseCase().sumNumbers(n);
}