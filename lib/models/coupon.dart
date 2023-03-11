class Coupon {
  final Vendor vendor;
  final double cost;
  final int quantity;
  final String seller;
  final String phonenumber;
  final double discount;
  final DateTime dov;
  final Meal type;
  final String id;

  Coupon({
    required this.id,
    required this.vendor,
    required this.cost,
    required this.quantity,
    required this.seller,
    required this.phonenumber,
    required this.discount,
    required this.dov,
    required this.type,
  });
}

enum Vendor {
  bhopal,
  kanaka,
}

enum Meal {
  breakfast,
  lunch,
  dinner,
  full,
}

extension InvertMap<K, V> on Map<K, V> {
  Map<V, K> get inverse =>
      Map.fromEntries(entries.map((e) => MapEntry(e.value, e.key)));
}
