import 'package:expense_buddy/data/hive_databse_debt.dart';
import 'package:expense_buddy/models/debt_item.dart';
import 'package:flutter/material.dart';

class DebtData extends ChangeNotifier {
  //list of all debt
  List<DebtItem> overallDebtList = [];

  //get debt list
  List<DebtItem> getAllDebtList() {
    return overallDebtList;
  }

  final db = HiveDataBaseDebt();

  void prepareDataforDebt() {
    if (db.readDataForDebt().isNotEmpty) {
      overallDebtList = db.readDataForDebt();
    }
  }

  //add new debt
  void addNewDebt(DebtItem debt) {
    overallDebtList.add(debt);
    notifyListeners();
    db.saveDataForDebt(overallDebtList);
  }

  //delete debt
  void deleteDebt(DebtItem debt) {
    overallDebtList.remove(debt);
    notifyListeners();
    db.saveDataForDebt(overallDebtList);
  }

  // get weekday {mon,tues, etc} from a dateTime object
  // String getWeekDayName(DateTime dateTime) {
  //   switch (dateTime.weekday) {
  //     case 1:
  //       return 'Mon';
  //     case 2:
  //       return 'Tue';
  //     case 3:
  //       return 'Wed';
  //     case 4:
  //       return 'Thu';
  //     case 5:
  //       return 'Fri';
  //     case 6:
  //       return 'Sat';
  //     case 7:
  //       return 'Sun';
  //     default:
  //       return '';
  //   }
  // }

  // //get the date for start of the week(sunday)

  // DateTime? startOfWeekDate() {
  //   DateTime? startOfWeek;

  //   // get today's date
  //   DateTime today = DateTime.now();

  //   //go backward from today to find sunday
  //   for (int i = 0; i < 7; i++) {
  //     if (getWeekDayName(today.subtract(Duration(days: i))) == 'Sun') {
  //       startOfWeek = today.subtract(Duration(days: i));
  //     }
  //   }

  //   return startOfWeek;
  // }

  /*


  convet overall list of expenses into a daily expense summary


  e.g. overallDebtList =  
  [
    [name, date, amount]
  ]

  -> 
  personDebtSummary = 
  [
    [date,amouunt]
  ]

  */

  Map<String, double> calculatePersonDebtSummary() {
    Map<String, double> personDebtSummary = {};

    for (var debt in overallDebtList) {
      String name = debt.personName;
      double amount = double.parse(debt.debtAmount);

      if (personDebtSummary.containsKey(name)) {
        double currentAmount = personDebtSummary[name]!;
        currentAmount += amount;
        personDebtSummary[name] = currentAmount;
      } else {
        personDebtSummary.addAll({name: amount});
      }
    }
    return personDebtSummary;
  }
}
