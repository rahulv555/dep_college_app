class FoodItem {
  final String name;
  final double price;
  final List<String> availability;
  double quantity;

  FoodItem(
      {required this.name,
      required this.price,
      required this.availability,
      required this.quantity});
}
