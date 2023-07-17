import 'package:expense_buddy/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'data/expense_data.dart';

void main() async {
  // initialise the hive
  await Hive.initFlutter();

  //open a hive box
  await Hive.openBox("expense_database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.teal,
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
