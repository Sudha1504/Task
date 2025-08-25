import 'package:counter_task/Core/Constants/string_constants.dart';
import 'package:counter_task/features/presentation/view_model/home_view_model.dart';
import 'package:counter_task/features/presentation/widgets/appbar/home_appbar.dart';
import 'package:counter_task/features/presentation/widgets/floating_action_button/home_float_button.dart';
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
          Selector<HomeViewModel, bool>(
            selector: (context, homeProvider) => homeProvider.isLoading,
            builder: (context, isLoading, child) {
              if (!isLoading) return const SizedBox.shrink();
              return Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.green),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          HomeFloatButton(
            onPressed: () {
              context.read<HomeViewModel>().increment();
              final count = context.read<HomeViewModel>().count;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${StringConstants.counterIncrement} $count"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          HomeFloatButton(
            onPressed: () {
              context.read<HomeViewModel>().reset();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(StringConstants.counterReset),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Icon(Icons.restart_alt),
          ),
          SizedBox(height: 10),
          Selector<HomeViewModel, bool>(
            selector: (context, homeProvider) => homeProvider.isLoading,
            builder: (context, isLoading, child) {
              return HomeTextButton(
                onPressed: () async {
                  final value =
                      await context.read<HomeViewModel>().computeSum();
                  final count = await context.read<HomeViewModel>().count;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Sum from 1 to $count: $value"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
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
