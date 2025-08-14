import 'package:flutter/material.dart';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import '../../Domain/UseCase/Sum_Numbers.dart';
import '../../Core/Mixins/logger_mixin.dart';

class LoginProvider extends ChangeNotifier with LoggerMixin {
  int count = 0;
  bool isLoading = false;
  bool isFibonacciMode = false;

  Future<int> increment () async {
    if (isFibonacciMode) {
      final currentValue = count;
      final next = await Isolate.run(() => nextFibonacciIsolate(currentValue));
      log("Fibonacci mode: $count → $next");
      count = next;
    }
    else {
      count++;
      log("Counter incremented to $count");
    }
    notifyListeners();
    return count;
  }
  void reset() {
    count = 0;
    log("Counter reset to 0");
    notifyListeners();
  }

  void toggleCounter() {
    isFibonacciMode = !isFibonacciMode;
    notifyListeners();
  }

  Future<int> computeSum() async {
    isLoading = true;
    log("Starting sum calculation for 1 to $count");
    notifyListeners();

    final currentCount = count;
    final result = await Isolate.run(() => sumNumbersIsolate(currentCount));

    isLoading = false;
    log("Finished sum calculation. Result: $result");
    notifyListeners();

    return result;
  }
}