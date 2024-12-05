class Order {
  final String id;
  final bool isActive;
  final double price;
  final String company;
  final String buyer;
  final String status;
  final DateTime registered;

  Order({
    required this.id,
    required this.isActive,
    required this.price,
    required this.company,
    required this.buyer,
    required this.status,
    required this.registered,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      isActive: json['isActive'],
      price: double.parse(json['price'].replaceAll(RegExp(r'[^0-9.]'), '')),
      company: json['company'],
      buyer: json['buyer'],
      status: json['status'],
      registered: DateTime.parse(json['registered']),
    );
  }
}
