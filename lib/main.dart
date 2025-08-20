import 'package:counter_task/Presentation/View/Home_Page.dart';
import 'package:counter_task/Presentation/ViewModel/list_view_model.dart';
import 'package:counter_task/Presentation/ViewModel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LoginProvider()),
          ChangeNotifierProvider(create: (context) => ListProvider()),
        ],
         child: const MyApp()
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}




