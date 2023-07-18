import 'package:hive_flutter/adapters.dart';

import '../models/debt_item.dart';

class HiveDataBaseDebt {
  // reference the box
  final _myBox1 = Hive.box("debt_database");

  //write the data into debt database
  void saveDataForDebt(List<DebtItem> allDebt) {
    /*

      Hive can only store strings and datetime and not custom objects like debtItem.
      So lets convert debtItem objects into types that can be stored in our db

      alldebt = 
      [

        debtItem(name, amount, dateTime)

      ]

      ->

      [
        [name,amount,dateTime]
        ...
      ]

    */

    List<List<dynamic>> allDebtFormatted = [];

    for (var debt in allDebt) {
      List<dynamic> debtFormatted = [
        debt.personName,
        debt.debtAmount,
        debt.dateTime,
      ];

      allDebtFormatted.add(debtFormatted);
    }

    _myBox1.put("ALL_debts", allDebtFormatted);
  }

  //read data from debt database

  List<DebtItem> readDataForDebt() {
    List savedDebts = _myBox1.get("ALL_debts") ?? [];
    List<DebtItem> allDebt = [];

    for (int i = 0; i < savedDebts.length; i++) {
      String personName = savedDebts[i][0];
      String debtamount = savedDebts[i][1];
      DateTime dateTime = savedDebts[i][2];

      //create debt Item
      DebtItem debt = DebtItem(
        personName = personName,
        debtamount = debtamount,
        dateTime = dateTime,
      );

      //add debt to overall list of debts
      allDebt.add(debt);
    }
    return allDebt;
  }
}
