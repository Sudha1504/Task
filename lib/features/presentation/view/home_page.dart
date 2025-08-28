import 'package:counter_task/core/constants/string_constants.dart';
import 'package:counter_task/features/presentation/utils/snackbar_helper.dart';
import 'package:counter_task/features/presentation/view_model/home_view_model.dart';
import 'package:counter_task/features/presentation/widgets/appbar/home_appbar.dart';
import 'package:counter_task/features/presentation/widgets/floating_action_button/home_float_button.dart';
import 'package:counter_task/features/presentation/widgets/loading_overlay/home_loading.dart';
import 'package:counter_task/features/presentation/widgets/text_button/home_text_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppbar(title: "Increment Counter App"),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Selector<HomeViewModel, int>(
                  selector: (context, homeProvider) => homeProvider.count,
                  builder: (context, count, child) {
                    return Text("Counter value: ${count}");
                  },
                ),
              ],
            ),
          ),
          LoadingOverlay(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Selector<HomeViewModel, bool> (
            selector: (context, homeProvider) => homeProvider.isFibonacciMode,
            builder: (context, isFibonacciMode, child) {
              return HomeFloatButton(
                onPressed: () async {
                  final value = await context.read<HomeViewModel>().increment();
                  showSnack(context, isFibonacciMode ?
                  ("${StringConstants.counterIncrementFib} $value") :
                  ("${StringConstants.counterIncrementNormal} $value"));
                },
                bgClr: isFibonacciMode ? Colors.green : Colors.teal,
                child: Icon(Icons.add),
              );
            },
          ),
          SizedBox(height: 10),
          HomeFloatButton(
            onPressed: () {
              context.read<HomeViewModel>().reset();
              showSnack(context, StringConstants.counterReset);
            },
            bgClr: Colors.blueGrey,
            child: Icon(Icons.restart_alt),
          ),
          SizedBox(height: 10),
          Selector<HomeViewModel, (bool,bool)>(
            selector: (context, homeProvider) => (homeProvider.isFibonacciMode, homeProvider.isLoading),
            builder: (context, values, child) {
              final (isFibonacciMode, isLoading) = values;
              return HomeTextButton(
                  onPressed: () {
                    context.read<HomeViewModel>().toggleCounter();
                  },
                  bgClr: isFibonacciMode ? Colors.green : Colors.teal,
                  isLoading: isLoading,
                  text: isFibonacciMode ? "Fibonacci" : "Normal"
              );
            },
          ),
          Selector<HomeViewModel, bool>(
            selector: (context, homeProvider) => homeProvider.isLoading,
            builder: (context, isLoading, child) {
              return HomeTextButton(
                onPressed: () async {
                  final value =
                      await context.read<HomeViewModel>().computeSum();
                  final count = await context.read<HomeViewModel>().count;
                  showSnack(context, "Sum from 1 to $count: $value");
                },
                bgClr: Colors.blueGrey,
                isLoading: isLoading,
                text: "Calculate Sum",
              );
            },
          ),
        ],
      ),
    );
  }
}
