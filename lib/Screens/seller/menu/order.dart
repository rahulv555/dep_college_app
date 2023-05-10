import 'package:dep_college_app/models/order.dart';
import 'package:flutter/material.dart';

class OrderSeller extends StatefulWidget {
  Function _changeAppBarTitle;
  int _selectedOutlet;
  List<Orderr> orders;
  OrderSeller(this._selectedOutlet, this._changeAppBarTitle, this.orders);

  @override
  State<OrderSeller> createState() => _OrderSellerState();
}

class _OrderSellerState extends State<OrderSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
            itemCount: widget.orders.length,
            itemBuilder: (context, index) => Card(
                  child: Text('lol'),
                )),
      ),
    );
  }
}
