import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/home_screen.dart';

import '../helpers/var_helper.dart';
import '../providers/food_provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => FoodProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nham Ey',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Chrieng',
        appBarTheme: const AppBarTheme(
          backgroundColor: pColor50,
          elevation: 0,
          centerTitle: false,
          actionsIconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
