import 'package:dep_college_app/Screens/food_order/food_home.dart';
import 'package:dep_college_app/Screens/food_order/outlet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FoodHome extends StatefulWidget {
  Function _changeAppBarTitle;
  FoodHome(this._changeAppBarTitle) {
    _changeAppBarTitle('Food');
  }

  @override
  State<FoodHome> createState() => _FoodHomeState();
}

class _FoodHomeState extends State<FoodHome> {
  int _selectedView = 0;
  int _selectedOutlet = 0;

  void _selectView(int v) {
    setState(() {
      _selectedView = v;
    });
  }

  void _selectOutlet(int o) {
    setState(() {
      _selectedOutlet = o;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedView == 1) {
      return OutletMenu(
          _selectedOutlet, _selectView, widget._changeAppBarTitle);
    } else
      return FoodHomePage(
          _selectOutlet, _selectView, widget._changeAppBarTitle);
  }
}
