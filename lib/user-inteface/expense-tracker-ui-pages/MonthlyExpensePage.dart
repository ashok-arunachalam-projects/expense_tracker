import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyExpensePage extends StatelessWidget {
  final Map<String, double> categoryExpenses = {
    'Groceries': 120.0,
    'Streaming': 45.0,
    'Restaurants': 90.0,
    'Travel': 60.0,
    'Shopping': 150.0,
  };

  final List<Color> categoryColors = [
    Colors.redAccent,
    Colors.purpleAccent,
    Colors.tealAccent,
    Colors.orangeAccent,
    Colors.blueAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Expenses'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFF0A0E21),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Spending Breakdown", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            AspectRatio(
              aspectRatio: 1.2,
              child: PieChart(
                PieChartData(
                  sections: getSections(),
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                ),
              ),
            ),
            SizedBox(height: 30),
            ...categoryExpenses.entries.mapIndexed((index, entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      color: categoryColors[index],
                    ),
                    SizedBox(width: 10),
                    Expanded(child: Text(entry.key, style: TextStyle(fontSize: 16))),
                    Text("\$${entry.value.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            }).toList()
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> getSections() {
    final total = categoryExpenses.values.fold(0.0, (a, b) => a + b);

    return categoryExpenses.entries.mapIndexed((index, entry) {
      final percentage = (entry.value / total) * 100;
      return PieChartSectionData(
        color: categoryColors[index],
        value: entry.value,
        title: "${percentage.toStringAsFixed(1)}%",
        radius: 60,
        titleStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
      );
    }).toList();
  }
}

extension MapIndexed<K, V> on Iterable<MapEntry<K, V>> {
  Iterable<T> mapIndexed<T>(T Function(int index, MapEntry<K, V> e) f) {
    int i = 0;
    return map((e) => f(i++, e));
  }
}
