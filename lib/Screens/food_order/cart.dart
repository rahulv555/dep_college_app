import "package:dep_college_app/Screens/food_order/qr.dart";
import "package:dep_college_app/models/fooditem.dart";
import "package:flutter/material.dart";

class Cart extends StatefulWidget {
  Map<String, FoodItem> _cart;
  Function _setActualQuant;
  String _selectedOutlet;

  Cart(this._cart, this._setActualQuant, this._selectedOutlet);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  double _calculateTotal() {
    double total = 0;
    widget._cart.forEach((key, value) {
      total += widget._cart[key]!.price * widget._cart[key]!.quantity;
    });
    return total;
  }

  Widget _addButton(String itemname) {
    return SizedBox(
      height: 40,
      width: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(padding: EdgeInsets.zero, shape: const StadiumBorder(), backgroundColor: Theme.of(context).primaryColor),
        onPressed: () {
          setState(() {
            widget._cart[itemname]!.quantity++;
            widget._setActualQuant(itemname, widget._cart[itemname]!.quantity);
          });
        },
        child: const Text('Add', style: TextStyle(fontSize: 14)),
      ),
    );
  }

  Widget _quantityButton(String itemname) {
    return SizedBox(
      height: 40,
      width: 100,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  widget._cart[itemname]!.quantity--;
                  widget._setActualQuant(itemname, widget._cart[itemname]!.quantity);
                });
              },
              child: const Icon(Icons.remove, size: 18, color: Colors.white),
            ),
            Text(widget._cart[itemname]!.quantity.toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget._cart[itemname]!.quantity++;
                  widget._setActualQuant(itemname, widget._cart[itemname]!.quantity);
                });
              },
              child: const Icon(Icons.add, size: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).primaryColor, title: Text('Cart', style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor))),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(padding: EdgeInsets.symmetric(vertical: 30), child: Text('CART', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
            Container(
              height: 500,
              child: ListView.builder(
                itemCount: widget._cart.length,
                itemBuilder: (ctx, index) {
                  String itemname = widget._cart.keys.elementAt(index);
                  return Column(
                    children: [
                      Card(
                        elevation: 0,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// LEFT: ITEM INFO (flexible, wraps safely)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget._cart[itemname]!.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 4),
                                    Text('Rs. ${widget._cart[itemname]!.price}', style: const TextStyle(fontSize: 14)),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 8),

                              /// RIGHT: CONTROLS (fixed width, never overflows)
                              SizedBox(
                                width: 170,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    /// PACK CHECKBOX
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Text('Pack?', style: TextStyle(fontSize: 12)),
                                        Checkbox(
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: VisualDensity.compact,
                                          activeColor: Theme.of(context).primaryColor,
                                          value: widget._cart[itemname]!.pack,
                                          onChanged: (b) {
                                            setState(() {
                                              widget._cart[itemname]!.pack = b!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),

                                    /// ADD / QUANTITY BUTTON
                                    widget._cart[itemname]!.quantity == 0 ? _addButton(itemname) : _quantityButton(itemname),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(color: Theme.of(context).primaryColor, thickness: 1, indent: 20, endIndent: 20),
                    ],
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total : Rs.' + _calculateTotal().toString(), style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 25)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: widget._cart.length == 0 ? Colors.grey : Colors.red, shape: StadiumBorder(), fixedSize: Size(100, 50)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Qr(widget._cart, widget._selectedOutlet)));
                    },
                    child: Text('Order'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
