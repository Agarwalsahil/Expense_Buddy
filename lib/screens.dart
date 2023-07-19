import 'package:expense_buddy/pages/debt_page.dart';
import 'package:expense_buddy/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Screens extends StatefulWidget {
  const Screens({super.key});

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomePage(),
    DebtPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        color: Colors.teal.shade400,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.teal.shade400,
            color: Colors.teal.shade100,
            activeColor: Colors.black,
            tabBackgroundColor: Colors.teal.shade800,
            gap: 8,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Track Expense',
                iconSize: 33,
              ),
              GButton(
                icon: Icons.people,
                text: 'Money Lent',
                iconSize: 33,
              ),
            ],
            selectedIndex: _currentIndex,
            onTabChange: (index) {
              setState(
                () {
                  _currentIndex = index;
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
