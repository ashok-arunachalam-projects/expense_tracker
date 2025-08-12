import 'package:flutter/material.dart';

import 'expense-tracker-ui-pages/ExpenseHomePage.dart';

class ExpenseTrackerApp extends StatelessWidget
{

  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        cardColor: Color(0xFF1D1E33),
      ),
      home: ExpenseHomePage(),
    );
  }
}
