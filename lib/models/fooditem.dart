class FoodItem {
  String name;
  double price;
  List<String> availability;
  double quantity;
  bool pack;

  FoodItem({required this.name, required this.price, required this.availability, required this.quantity, this.pack = false});
}
