import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BuySellHome extends StatefulWidget {
  const BuySellHome({super.key});

  @override
  State<BuySellHome> createState() => _BuySellHomeState();
}

class _BuySellHomeState extends State<BuySellHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
