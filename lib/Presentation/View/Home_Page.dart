import 'dart:isolate';

import 'package:counter_task/Core/Constants/String_Constants.dart';
import 'package:counter_task/Presentation/ViewModel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text("Increment Counter App",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),),),
          body: Consumer<LoginProvider>(builder: (context, loginProvider, child) {
            return Stack(
              children: [
                 Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Counter value: ${loginProvider.count}"),
                      SizedBox(height: 10),
                      Text("Current Streak: ${loginProvider.currentStreak}"),
                      SizedBox(height: 10),
                      Text("Highest Streak: ${loginProvider.highestStreak}"),
                    ],
                  ),
                ),
                if (loginProvider.isLoading)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    ),
                  )
              ],
            );
          },
          ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Consumer<LoginProvider>(builder: (context, loginProvider, child) {
                return FloatingActionButton(
                    backgroundColor: loginProvider.isFibonacciMode ? Colors.green : Colors.teal,
                    onPressed: () async {
                      final value = await context.read<LoginProvider>().increment();
                      final count = context.read<LoginProvider>().count;
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: loginProvider.isFibonacciMode ?
                            Text("${StringConstants.counterIncrementFib} $value") :
                            Text("${StringConstants.counterIncrementNormal} $count"),
                            duration: Duration(seconds: 2), ));
                      },
                    child: Icon(Icons.add, color: Colors.white,));
             }
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              context.read<LoginProvider>().reset();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(StringConstants.counterReset),
                    duration: Duration(seconds: 2),
                )
              );
            },
            child: Icon(Icons.restart_alt),
          ),
          SizedBox(height: 10),
          TextButton(onPressed: () {
            context.read<LoginProvider>().toggleCounter();
            },
              child: Consumer<LoginProvider>(builder: (context, loginProvider, child) {
                return Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: loginProvider.isFibonacciMode ? Colors.green : Colors.teal,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        loginProvider.isFibonacciMode ? "Fibonacci" : "Normal",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                );
              }
              )
          ),
          TextButton(onPressed: () async {
            final value = await context.read<LoginProvider>().computeSum();
            ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Sum from 1 to ${context.read<LoginProvider>().count}: $value"),
                      duration: Duration(seconds: 2),
                    )
                  );
          },
           child: Consumer<LoginProvider>(
               builder: (context, loginProvider, child) {
                  return Container(
                         height: 50,
                         width: 100,
                         decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                    child: Center(
                      child: loginProvider.isLoading ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.green,
                          strokeWidth: 2,
                        ),
                      ) : Text("Calculate Sum", style: TextStyle(color: Colors.white, fontSize: 13))
                    )
                  );
           }
           )
          )
        ]
      )
    );






  }
}
