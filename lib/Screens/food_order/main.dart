import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FoodHome extends StatefulWidget {
  const FoodHome({super.key});

  @override
  State<FoodHome> createState() => _FoodHomeState();
}

class _FoodHomeState extends State<FoodHome> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Good luck with the canteen'),);
  }
}