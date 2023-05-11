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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Cart',
          style: TextStyle(color: Theme.of(context).backgroundColor),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                'CART',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 500,
              child: ListView.builder(
                  itemCount: widget._cart.length,
                  itemBuilder: (ctx, index) {
                    String itemname = widget._cart.keys.elementAt(index);
                    return Column(children: [
                      Card(
                        elevation: 0,
                        color: Theme.of(context).backgroundColor,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    widget._cart[itemname]!.name,
                                    style: TextStyle(fontSize: 20),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'Rs.' + widget._cart[itemname]!.price.toString(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Text('Pack?'),
                                  Checkbox(
                                      activeColor: Theme.of(context).primaryColor,
                                      checkColor: Theme.of(context).backgroundColor,
                                      value: widget._cart[itemname]!.pack,
                                      onChanged: (b) {
                                        setState(() {
                                          widget._cart[itemname]!.pack = b as bool;
                                        });
                                      }),
                                  widget._cart[itemname]!.quantity == 0
                                      ? ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(context).primaryColor,
                                            fixedSize: Size(150, 10),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              widget._cart[itemname]!.quantity++;
                                              widget._setActualQuant(itemname, widget._cart[itemname]!.quantity);
                                              print(widget._cart);
                                            });
                                          },
                                          child: Text('Add'))
                                      : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Theme.of(context).primaryColor, fixedSize: Size(150, 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                                          onPressed: () {},
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.remove),
                                                onPressed: () {
                                                  setState(() {
                                                    widget._cart[itemname]!.quantity--;
                                                    double q = widget._cart[itemname]!.quantity;

                                                    // if (widget._cart[itemname]!.quantity == 0) {
                                                    //   widget._cart.remove(widget._cart[itemname]!.name);
                                                    //   print(widget._cart);
                                                    // }

                                                    widget._setActualQuant(itemname, q);
                                                  });
                                                },
                                              ),
                                              Text(widget._cart[itemname]!.quantity.toString()),
                                              IconButton(
                                                icon: const Icon(Icons.add),
                                                onPressed: () {
                                                  setState(() {
                                                    widget._cart[itemname]!.quantity++;
                                                    widget._setActualQuant(itemname, widget._cart[itemname]!.quantity);
                                                    print(widget._cart);
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                  // Checkbox(
                                  //     shape: CircleBorder(),
                                  //     value: false,
                                  //     onChanged: (value) {})
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).primaryColor,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      )
                    ]);
                  }),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total : Rs.' + _calculateTotal().toString(), style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 30)),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: widget._cart.length == 0 ? Colors.grey : Colors.red, shape: StadiumBorder(), fixedSize: Size(100, 50)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Qr(widget._cart, widget._selectedOutlet)));
                      },
                      child: Text(
                        'Order',
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
