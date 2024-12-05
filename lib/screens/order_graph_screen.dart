import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/order.dart';

class OrderGraphScreen extends StatelessWidget {
  final List<Order> orders;

  const OrderGraphScreen({required this.orders, super.key});

  @override
  Widget build(BuildContext context) {
    // Group orders by month and year
    final Map<String, int> orderCounts = {};
    for (var order in orders) {
      final monthYear = "${order.registered.year}-${order.registered.month.toString().padLeft(2, '0')}";
      orderCounts[monthYear] = (orderCounts[monthYear] ?? 0) + 1;
    }

    // Prepare data for the graph
    final data = orderCounts.entries
        .map((entry) => ChartData(entry.key, entry.value))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders by Month' , style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold,),),
        backgroundColor: Colors.blue.shade600,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SfCartesianChart(
            primaryXAxis: const CategoryAxis(
              title: AxisTitle(
                text: 'Month-Year',
                textStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              labelRotation: 45,
              majorGridLines: MajorGridLines(width: 0),
            ),
            primaryYAxis: const NumericAxis(
              title: AxisTitle(
                text: 'Order Count',
                textStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              majorGridLines: MajorGridLines(dashArray: [5, 5]),
            ),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries>[
              ColumnSeries<ChartData, String>(
                dataSource: data,
                xValueMapper: (datum, _) => datum.label,
                yValueMapper: (datum, _) => datum.count,
                color: Colors.blue.shade800,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              ),
            ],
            borderWidth: 0,
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final String label; // Month-Year label
  final int count;

  ChartData(String monthYear, this.count)
      : label = _formatMonthYear(monthYear),
        date = DateTime.parse("${monthYear.split('-')[0]}-${monthYear.split('-')[1]}-01");

  final DateTime date;

  static String _formatMonthYear(String monthYear) {
    final parts = monthYear.split('-');
    final year = parts[0];
    final month = int.parse(parts[1]);

    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    return "${months[month - 1]} $year";
  }
}
