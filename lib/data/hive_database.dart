import 'package:hive_flutter/adapters.dart';

import '../models/expense_item.dart';

class HiveDataBase {
  // reference the box
  final _myBox = Hive.box("expense_database");

  //write the data
  void saveData(List<ExpenseItem> allExpenses) {
    /*

      Hive can only store strings and datetime and not custom objects like ExpenseItem.
      So lets convert ExpenseItem objects into types that can be stored in our db

      allExpense = 
      [

        ExpenseItem(name, amount, dateTime)

      ]

      ->

      [
        [name,amount,dateTime]
        ...
      ]

    */

    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpenses) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];

      allExpensesFormatted.add(expenseFormatted);
    }

    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
  }

  //read data from database

  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      //create Expense Item
      ExpenseItem expense = ExpenseItem(
        name = name,
        amount = amount,
        dateTime = dateTime,
      );

      //add expense to overall list of expenses
      allExpenses.add(expense);
    }
    return allExpenses;
  }


  
}
