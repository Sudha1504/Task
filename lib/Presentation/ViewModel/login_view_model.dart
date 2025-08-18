import 'package:flutter/material.dart';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Domain/UseCase/Sum_Numbers.dart';
import '../../Core/Mixins/logger_mixin.dart';

class LoginProvider extends ChangeNotifier with LoggerMixin {
  int count = 0;
  bool isLoading = false;
  bool isFibonacciMode = false;
  int currentStreak = 0;
  int highestStreak = 0;
  DateTime? lastTapTime;
  final Duration streakTimeout = Duration(seconds: 120);

  LoginProvider() {
    loadHighestStreak();
  }

  Future<void> saveHighestStreak() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("highestStreak", highestStreak);
  }

  Future<void> loadHighestStreak() async {
    final prefs = await SharedPreferences.getInstance();
    highestStreak = prefs.getInt("highestStreak") ?? 0;
    notifyListeners();
  }


  Future<int> increment () async {
    final now = DateTime.now();
    if (lastTapTime != null && now.difference(lastTapTime!) > streakTimeout) {
      currentStreak = 0;
    }
    lastTapTime = now;
    currentStreak++;

    if(currentStreak > highestStreak) {
      highestStreak = currentStreak;
      await saveHighestStreak();
    }

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
    currentStreak = 0;
    log("Counter reset to 0, Streak reset");
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