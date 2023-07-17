import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/expense_summary.dart';
import '../components/expense_tile.dart';
import '../data/expense_data.dart';
import '../models/expense_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController newExpenseNameController = TextEditingController();
  TextEditingController newExpenseDollarController = TextEditingController();
  TextEditingController newExpenseCentsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //prepare the data when app start for first time
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a new expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newExpenseNameController,
                cursorWidth: 2,
                decoration: const InputDecoration(
                  hintText: 'Expense Name',
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: newExpenseDollarController,
                      decoration: const InputDecoration(hintText: 'Dollar'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: newExpenseCentsController,
                      decoration: const InputDecoration(hintText: 'Cents'),
                    ),
                  )
                ],
              ),
            ],
          ),
          actions: [
            MaterialButton(
              onPressed: save,
              child: const Text('Save'),
            ),
            MaterialButton(
              onPressed: cancel,
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  void save() {
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseDollarController.text.isNotEmpty) {
      String amount =
          '${newExpenseDollarController.text == '' ? '00' : newExpenseDollarController.text}.${newExpenseCentsController.text == '' ? '00' : newExpenseCentsController.text == '0' ? '00' : newExpenseCentsController.text}';
      ExpenseItem newExpense = ExpenseItem(
        newExpenseNameController.text,
        amount,
        DateTime.now(),
      );
      // if (newExpenseCentsController.text == '') {
      //   amount = '${amount}00';
      // }
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseNameController.clear();
    newExpenseDollarController.clear();
    newExpenseCentsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.teal.shade400,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            onPressed: addNewExpense,
            child: const Icon(
              Icons.add,
              size: 35,
            ),
          ),
          body: ListView(
            children: [
              //Weekly Summary
              ExpenseSummary(startOfWeek: value.startOfWeekDate()!),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Expense Details',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Amount',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),

              //expense List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getAllExpenseList().length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ExpenseTile(
                        name: value.getAllExpenseList()[index].name,
                        amount: value.getAllExpenseList()[index].amount,
                        dateTime: value.getAllExpenseList()[index].dateTime,
                        deleteTapped: (p0) => deleteExpense(
                          value.getAllExpenseList()[index],
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.teal.shade900,
                        // height: 0,
                      ),
                    ],
                  );
                },
              ),
            ],
          )),
    );
  }
}
