import 'package:counter_task/features/presentation/view_model/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Counter class - Increment", () {
    late HomeViewModel counter;

    setUp(() {
      counter = HomeViewModel();
    });
    test("given Counter class when instantiated then the value is 0", () {
      final value = counter.count;
      print("Counter initial value = $value");
      expect(value, 0);
    });
    test("given Counter class when it is incremented the value is 1", () {
      counter.increment();
      final value = counter.count;
      expect(value, 1);
    });
  });

  group("Counter class - Reset", () {
    late HomeViewModel counter;

    setUp(() {
      counter = HomeViewModel();
    });
    test("given Counter class when reseted then the value is 0", () {
      counter.increment();
      final beforeVal = counter.count;
      print("Counter first value = $beforeVal");
      counter.reset();
      final afterVal = counter.count;
      print("Counter reseted value = $afterVal");
      expect(afterVal, 0);
    });
  });

  group("Counter class - ComputeSum", () {
    late HomeViewModel counter;

    setUp(() {
      counter = HomeViewModel();
    });

    test("Calculate sum with await", () async {
      counter.count = 5;
      final result = await counter.computeSum();
      expect(result, 15);
      expect(counter.isLoading, false);
    });

    test("Calculate sum with loading state", () async {
      counter.count = 3;
      final future = counter.computeSum();
      expect(counter.isLoading, true);
      final result = await future;
      expect(result, 6);
      expect(counter.isLoading, false);
    });

    test("Calculate sum with 0", () async {
      counter.count = 0;
      final result = await counter.computeSum();
      expect(result, 0);
      expect(counter.isLoading, false);
    });
  });
}
