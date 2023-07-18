import 'package:expense_buddy/data/debt_data.dart';
import 'package:expense_buddy/screens.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'data/expense_data.dart';

void main() async {
  // initialise the hive
  await Hive.initFlutter();

  //open a hive box
  await Hive.openBox("expense_database");

  await Hive.openBox("debt_database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExpenseData>(
          create: (context) => ExpenseData(),
        ),
        ChangeNotifierProvider<DebtData>(
          create: (context) => DebtData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.teal,
          ),
        ),
        home: const Screens(),
      ),
    );
  }
}
