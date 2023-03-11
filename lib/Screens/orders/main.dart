import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrdersHome extends StatefulWidget {
  Function _changeAppBarTitle;
  OrdersHome(this._changeAppBarTitle) {
    _changeAppBarTitle('Orders');
  }

  @override
  State<OrdersHome> createState() => _OrdersHomeState();
}

class _OrdersHomeState extends State<OrdersHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Your orders'),
    );
  }
}
