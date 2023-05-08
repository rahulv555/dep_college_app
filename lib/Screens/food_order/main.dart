import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dep_college_app/Screens/food_order/food_home.dart';
import 'package:dep_college_app/Screens/food_order/outlet.dart';
import 'package:dep_college_app/models/fooditem.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
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
  Map<String, List<FoodItem>> _menu = {};

  void _selectView(int v) {
    setState(() {
      _selectedView = v;
    });
  }

  void _selectOutlet(int o) {
    FirebaseFirestore.instance.collection('outlets').doc(o.toString()).collection('menu').get().then((QuerySnapshot qs) {
      Map<String, List<FoodItem>> categories = {};
      qs.docs.forEach((doc) {
        if (doc.exists) {
          //doc is one category
          String cat_name = doc["name"];
          List<FoodItem> fs = [];
          // print(doc);
          (doc["items"] as List).forEach((item) {
            item = item as Map<String, dynamic>;
            // print('1');
            // print(item.values.first["Price"]);
            double p = item.values.first["Price"].toDouble();
            List<String> av = [];
            item.values.first["Available"].forEach((a) {
              av.add(a.toString());
            });
            fs.add(FoodItem(name: item.keys.elementAt(0), price: p, availability: av, quantity: 0));
          });
          categories[cat_name] = fs;
        }
      });

      setState(() {
        _selectedOutlet = o;
        _menu = categories;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedView == 1) {
      return OutletMenu(_selectedOutlet, _selectView, widget._changeAppBarTitle, _menu);
    } else
      return FoodHomePage(_selectOutlet, _selectView, widget._changeAppBarTitle);
  }
}
