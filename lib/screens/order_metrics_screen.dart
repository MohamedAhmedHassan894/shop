import 'package:flutter/material.dart';
import '../services/order_service.dart';
import '../models/order.dart';
import '../widgets/metric_card.dart';
import 'order_graph_screen.dart';

class OrderMetricsScreen extends StatefulWidget {
  const OrderMetricsScreen({super.key});

  @override
  _OrderMetricsScreenState createState() => _OrderMetricsScreenState();
}

class _OrderMetricsScreenState extends State<OrderMetricsScreen> {
  late Future<List<Order>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = OrderService().getOrders('assets/orders.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Insights', style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold,),),
        backgroundColor: Colors.blue.shade600,
        elevation: 0,
      ),
      body: FutureBuilder<List<Order>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data.'));
          } else {
            final orders = snapshot.data!;
            final totalOrders = orders.length;
            final averagePrice = orders.fold(0.0, (sum, order) => sum + order.price) / totalOrders;
            final returnsCount = orders.where((order) => order.status == 'RETURNED').length;

            return Container(
              color: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Overview',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue.shade800),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        MetricCard(
                          title: 'Total Orders',
                          value: totalOrders.toString(),
                          icon: Icons.list_alt,
                          color: Colors.blue.shade600,
                        ),
                        MetricCard(
                          title: 'Average Price',
                          value: '\$${averagePrice.toStringAsFixed(2)}',
                          icon: Icons.attach_money,
                          color: Colors.green.shade600,
                        ),
                        MetricCard(
                          title: 'Number of Returns',
                          value: returnsCount.toString(),
                          icon: Icons.warning,
                          color: Colors.red.shade600,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OrderGraphScreen(orders: orders)),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade600,
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                            ),
                            child: const Text(
                              'View Graph',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
