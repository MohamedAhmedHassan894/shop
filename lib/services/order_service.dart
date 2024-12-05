import 'dart:convert';
import '../models/order.dart';
import '../utils/file_helper.dart';

class OrderService {
  Future<List<Order>> getOrders(String filePath) async {
    final String jsonString = await FileHelper.loadJsonFromFile(filePath);
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Order.fromJson(json)).toList();
  }
}
