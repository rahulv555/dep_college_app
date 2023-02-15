import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrdersHome extends StatefulWidget {
  const OrdersHome({super.key});

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
