import 'package:flutter/material.dart';
import '../lib/database/expense_database_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppDatabase db = AppDatabase();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      home: ExpenseHomePage(db: db),
    );
  }
}

class ExpenseHomePage extends StatelessWidget {
  final AppDatabase db;
  const ExpenseHomePage({required this.db});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expenses")),
      body: StreamBuilder<List<Expense>>(
        stream: db.watchAllExpenses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final expenses = snapshot.data!;
            return ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final e = expenses[index];
                return ListTile(
                  title: Text(e.title),
                  subtitle: Text("${e.amount} on ${e.date}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => db.deleteExpense(e.id),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await db.insertExpense(
            ExpensesCompanion.insert(
              title: "Sample Expense",
              amount: 123.45,
              date: DateTime.now(),
            ),
          );
        },
      ),
    );
  }
}
