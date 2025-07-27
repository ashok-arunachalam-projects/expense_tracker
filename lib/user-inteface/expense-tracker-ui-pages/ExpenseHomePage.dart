import 'package:flutter/material.dart';

import 'MonthlyExpensePage.dart';

class ExpenseHomePage extends StatelessWidget
{
  final transactions =
  [
    {"title": "Shopping", "date": "Apr 20", "category": "Groceries", "amount": -50, "icon": Icons.shopping_bag, "color": Colors.redAccent},
    {"title": "Subscription", "date": "Apr 18", "category": "Streaming", "amount": -12, "icon": Icons.subscriptions, "color": Colors.purpleAccent},
    {"title": "Salary", "date": "Apr 16", "category": "Income", "amount": 2500, "icon": Icons.work, "color": Colors.blueAccent},
    {"title": "Eating Out", "date": "Apr 14", "category": "Restaurants", "amount": -30, "icon": Icons.restaurant, "color": Colors.tealAccent},
  ];

  ExpenseHomePage({super.key});

  @override
  Widget build(BuildContext context)
  {

    double totalIncome = transactions
        .where((t) => (t["amount"] as num) > 0)
        .fold(0.0, (sum, t) => sum + (t["amount"] as num).toDouble());

    double totalExpense = transactions
        .where((t) => (t["amount"] as num) < 0)
        .fold(0.0, (sum, t) => sum + (t["amount"] as num).toDouble());


    double totalBalance = totalIncome + totalExpense;

    return Scaffold
      (
      appBar: AppBar(
        title: Text('Expense Tracker'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildBalanceCard(totalBalance),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildStatCard('Expenses Today', totalExpense, Colors.red)),
                const SizedBox(width: 10),
                Expanded(child: _buildStatCard('This Month Expense', totalIncome, Colors.deepOrangeAccent)),
              ],
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Transactions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  final tx = transactions[index];
                  return _buildTransactionTile(tx);
                },
              ),
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MonthlyExpensePage()),
          );
        },
        child: Icon(Icons.pie_chart),
      ),

    );
  }

  Widget _buildBalanceCard(double balance)
  {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Expenses Till Year", style: TextStyle(fontSize: 16, color: Colors.grey[400])),
            const SizedBox(height: 10),
            Text("\$${balance.toStringAsFixed(2)}", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, double amount, Color color)
  {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title, style: TextStyle(color: Colors.grey[400], fontSize: 14)),
            const SizedBox(height: 8),
            Text("\$${amount.abs().toStringAsFixed(2)}", style: TextStyle(fontSize: 20, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTile(Map<String, dynamic> tx)
  {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: tx["color"],
          child: Icon(tx["icon"], color: Colors.black),
        ),
        title: Text(tx["title"], style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("${tx["date"]} • ${tx["category"]}"),
        trailing: Text(
          (tx["amount"] > 0 ? '+' : '') + "\$${tx["amount"].abs()}",
          style: TextStyle(
            color: tx["amount"] > 0 ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
