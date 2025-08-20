import 'dart:isolate';

import 'package:counter_task/Core/Constants/String_Constants.dart';
import 'package:counter_task/Presentation/View/List_Screen.dart';
import 'package:counter_task/Presentation/ViewModel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) =>  IconButton(onPressed: () {
              Scaffold.of(context).openEndDrawer();
            }, icon: const Icon(Icons.menu, color: Colors.white)),
          ),
        ],
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Increment Counter App",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),),
      ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 120,
                child: DrawerHeader(
                    decoration: BoxDecoration(
                  color: Colors.blueGrey
                ),child: Text("Menu", style: TextStyle(color: Colors.white, fontSize: 24))),
              ), 
              ListTile(
                leading: Icon(Icons.list),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ListScreen()));
                },
                title: Text("List Screen"),
              )
            ],
          ),
        ),
          body: Consumer<LoginProvider>(builder: (context, loginProvider, child) {
            return Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Counter value: ${loginProvider.count}")
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
<<<<<<< Updated upstream
          FloatingActionButton(
            onPressed: () {
               context.read<LoginProvider>().increment();
               final count = context.read<LoginProvider>().count;
               ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                     content: Text("${StringConstants.counterIncrement} $count"),
                     duration: Duration(seconds: 2),
                   )
               );
            },
            child: Icon(Icons.add),
=======
          Consumer<LoginProvider>(builder: (context, loginProvider, child) {
                return FloatingActionButton(
                  heroTag: "HomeFab",
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
>>>>>>> Stashed changes
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
