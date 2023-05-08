import 'package:dep_college_app/Screens/food_order/cart.dart';
import 'package:dep_college_app/Screens/food_order/searchbar.dart';
import 'package:dep_college_app/models/fooditem.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class OutletMenu extends StatefulWidget {
  int _selectedOutlet = 0;
  Function _selectView;
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

  OutletMenu(this._selectedOutlet, this._selectView, this._changeAppBarTitle, this._menu) {
    print(this._menu.length);
    _orimenu = _menu;
    // this._changeAppBarTitle(_outlet_names[_selectedOutlet]);
  }

  @override
  State<OutletMenu> createState() => _OutletMenuState();
}

class _OutletMenuState extends State<OutletMenu> {
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
                                                        setState(() {
                                                          _cart[widget._menu[category]![i].name] = widget._menu[category]![i];

                                                          widget._menu[category]![i].quantity++;
                                                          print(_cart);
                                                        });
                                                      },
                                                      child: Text('Add'))
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                widget._changeAppBarTitle('Food');
                                widget._selectView(0);
                              },
                              icon: Icon(Icons.arrow_back)),
                        ],
                      ),
                      Container(
                        child: Text(
                          'MENU',
                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: CircleAvatar(
                          backgroundColor: _cart.isEmpty ? Theme.of(context).backgroundColor : Theme.of(context).primaryColor,
                          child: IconButton(
                            style: IconButton.styleFrom(),
                            icon: Icon(
                              Icons.shopping_cart,
                              color: _cart.isEmpty ? Colors.black : Theme.of(context).backgroundColor,
                            ),
                            onPressed: () {
                              if (_cart.isNotEmpty) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Cart(
                                              _cart,
                                              _setActualQuant,
                                            )));
                              }
                            },
                          ),
                        ),
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
