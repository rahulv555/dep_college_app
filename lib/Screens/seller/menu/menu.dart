import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dep_college_app/Screens/food_order/cart.dart';
import 'package:dep_college_app/Screens/food_order/searchbar.dart';
import 'package:dep_college_app/Screens/seller/menu/edit.dart';
import 'package:dep_college_app/models/fooditem.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:get/get_connect/http/src/utils/utils.dart';

class OutletMenuSeller extends StatefulWidget {
  int _selectedOutlet = 0;

  Function _changeAppBarTitle;
  Map<String, List<FoodItem>> _menu;
  Map<String, List<FoodItem>> _orimenu = {};

  final List<String> _outlet_names = [
    'CAFETARIA',
    'HOTSPOT',
    'JUICE CORNER',
    'KERALA CANTEEN',
    'COFFEE DAY',
  ];

  OutletMenuSeller(this._selectedOutlet, this._changeAppBarTitle, this._menu) {
    print(this._menu.length);
    _orimenu = _menu;
    // this._changeAppBarTitle(_outlet_names[_selectedOutlet]);
  }

  @override
  State<OutletMenuSeller> createState() => _OutletMenuSellerState();
}

class _OutletMenuSellerState extends State<OutletMenuSeller> {
  Map<String, FoodItem> _cart = {};

  void _setActualQuant(String i, double q) {
    setState(() {
      _cart[i]!.quantity = q;
      if (_cart[i]!.quantity == 0) {
        _cart.remove(i);
        print(_cart);
      }
    });
  }

  void _editMenuItem(BuildContext ctx, String category, int i) {
    print(widget._menu[category]![i]);

    showModalBottomSheet(
        backgroundColor: Theme.of(context).backgroundColor,
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: EditItem(widget._menu[category]![i], category, i, widget._menu.keys, _editItem),
          );
        });
  }

  void _editItem(String category, int i, String name, String cost, String _originalCategory) {
    Navigator.pop(context);
    List<FoodItem> items = widget._menu[category]!;
    print("lol");
    print(cost);
    items.add(FoodItem(name: name, price: double.parse(cost), availability: widget._menu[category]![i].availability, quantity: 0));

    List<FoodItem> original_items = widget._menu[_originalCategory]!;
    original_items.removeAt(i);

    FirebaseFirestore.instance.collection('outlets').doc(widget._selectedOutlet.toString()).collection('menu').doc(category).update({
      'items': items,
    }).then((value) {
      FirebaseFirestore.instance.collection('outlets').doc(widget._selectedOutlet.toString()).collection('menu').doc(_originalCategory).update({
        'items': original_items,
      }).then((value) {
        setState(() {
          widget._menu[category] = items;
          widget._menu[_originalCategory] = original_items;
        });
      });
    });
  }

  void _setMenuSearch(String s) {
    print("lol");
    Map<String, List<FoodItem>> _tempmenu = {};
    s = s.toLowerCase();
    widget._orimenu.forEach((key, value) {
      // print(key);

      // RegExp pattern = RegExp(key.toLowerCase());
      bool isMatch = key.toLowerCase().contains(s);
      // print(isMatch);
      if (isMatch) {
        _tempmenu[key] = value;
      } else {
        List<FoodItem> templist = [];
        value.forEach((element) {
          // pattern = RegExp(element.name.toLowerCase());
          // print(pattern);
          isMatch = element.name.toLowerCase().contains(s);
          print(isMatch);
          if (isMatch) {
            templist.add(element);
          }
        });
        if (templist.length > 0) {
          _tempmenu[key] = templist;
        }
      }
    });

    print(_tempmenu);

    setState(() {
      widget._menu = _tempmenu;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body:
          // height: 100,

          Stack(children: [
        Positioned(
            left: 0,
            right: 0,
            top: 140,
            bottom: 0,
            child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget._menu.length,
                itemBuilder: (ctx, index) {
                  String category = widget._menu.keys.elementAt(index);
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            category,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget._menu[category]!.length,
                            itemBuilder: (c, i) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                width: 5,
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 0,
                                      color: Theme.of(context).backgroundColor,
                                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                widget._menu[category]![i].name,
                                                style: TextStyle(fontSize: 20),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                'Rs.' + widget._menu[category]![i].price.toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          child: Column(
                                            children: [
                                              widget._menu[category]![i].quantity == 0
                                                  ? ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Theme.of(context).primaryColor,
                                                        fixedSize: Size(150, 10),
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(50),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        //open edit sheet
                                                        _editMenuItem(context, category, i);
                                                      },
                                                      child: Text('Edit'))
                                                  : ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor: Theme.of(context).primaryColor,
                                                          fixedSize: Size(150, 10),
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                                                      onPressed: () {},
                                                      child: Row(
                                                        children: [
                                                          IconButton(
                                                            icon: const Icon(Icons.remove),
                                                            onPressed: () {
                                                              setState(() {
                                                                widget._menu[category]![i].quantity--;
                                                                if (_cart[widget._menu[category]![i].name]!.quantity == 0) {
                                                                  _cart.remove(widget._menu[category]![i].name);
                                                                  print(_cart);
                                                                }
                                                              });
                                                            },
                                                          ),
                                                          Text(widget._menu[category]![i].quantity.toString()),
                                                          IconButton(
                                                            icon: const Icon(Icons.add),
                                                            onPressed: () {
                                                              setState(() {
                                                                widget._menu[category]![i].quantity++;
                                                                print(_cart);
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
                                      ]),
                                    ),
                                    Divider(
                                      color: Theme.of(context).primaryColor,
                                      thickness: 1,
                                      indent: 20,
                                      endIndent: 20,
                                    )
                                  ],
                                ),
                              );
                            })
                      ],
                    ),
                  );
                })),
        Positioned(
            top: 5,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Text(
                          'MENU',
                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                  SearchBar(_setMenuSearch),
                ],
              ),
            )),
      ]),
    );
  }
}
