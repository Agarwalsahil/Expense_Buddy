import 'package:expense_buddy/data/debt_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/expense_tile.dart';
import '../models/debt_item.dart';

class DebtPage extends StatefulWidget {
  const DebtPage({super.key});

  @override
  State<DebtPage> createState() => _DebtPageState();
}

class _DebtPageState extends State<DebtPage> {
  TextEditingController newPersonNameController = TextEditingController();
  TextEditingController newDebtDollarController = TextEditingController();
  TextEditingController newDebtCentsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //prepare the data when app start for first time
    Provider.of<DebtData>(context, listen: false).prepareDataforDebt();
  }

  void addNewDebt() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a new debt'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newPersonNameController,
                cursorWidth: 2,
                decoration: const InputDecoration(
                  hintText: 'Person Name',
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: newDebtDollarController,
                      decoration: const InputDecoration(hintText: 'Dollar'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: newDebtCentsController,
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

  void deleteDebt(DebtItem debt) {
    Provider.of<DebtData>(context, listen: false).deleteDebt(debt);
  }

  void save() {
    if (newPersonNameController.text.isNotEmpty &&
        newDebtDollarController.text.isNotEmpty) {
      String amount =
          '${newDebtDollarController.text == '' ? '00' : newDebtDollarController.text}.${newDebtCentsController.text == '' ? '00' : newDebtCentsController.text == '0' ? '00' : newDebtCentsController.text}';
      DebtItem newDebt = DebtItem(
        newPersonNameController.text,
        amount,
        DateTime.now(),
      );
      // if (newDebtCentsController.text == '') {
      //   amount = '${amount}00';
      // }
      Provider.of<DebtData>(context, listen: false).addNewDebt(newDebt);
    }

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newPersonNameController.clear();
    newDebtDollarController.clear();
    newDebtCentsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DebtData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.teal.shade400,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: () {
                  addNewDebt();
                },
                icon: const Icon(
                  Icons.add,
                  size: 35,
                  color: Colors.black,
                ),
              ),
            )
          ],
          elevation: 0,
          backgroundColor: Colors.teal.shade600,
          title: Text(
            'Account of Debts',
            style: GoogleFonts.pangolin(
              textStyle: const TextStyle(
                fontSize: 23,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: ListView(
          children: [
            //Weekly Summary
            // ExpenseSummary(startOfWeek: value.startOfWeekDate()!),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Person Name',
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
              itemCount: value.getAllDebtList().length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CommonTile(
                      name: value.getAllDebtList()[index].personName,
                      amount: value.getAllDebtList()[index].debtAmount,
                      dateTime: value.getAllDebtList()[index].dateTime,
                      deleteTapped: (p0) => deleteDebt(
                        value.getAllDebtList()[index],
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
        ),
      ),
    );
  }
}
