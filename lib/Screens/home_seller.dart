import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dep_college_app/Screens/buy_and_sell/main.dart';
import 'package:dep_college_app/Screens/coupon_exchange/main.dart';
import 'package:dep_college_app/Screens/food_order/main.dart';
import 'package:dep_college_app/Screens/login.dart';
import 'package:dep_college_app/Screens/orders/main.dart';
import 'package:dep_college_app/Screens/prof.dart';
import 'package:dep_college_app/Screens/seller/menu/menu.dart';
import 'package:dep_college_app/Screens/seller/menu/order.dart';
import 'package:dep_college_app/Screens/welcome.dart';
import 'package:dep_college_app/models/coupon.dart';
import 'package:dep_college_app/models/fooditem.dart';
import 'package:dep_college_app/models/order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'coupon_exchange/sell_coupon.dart';
import 'maindrawer.dart';

class HomeScreenSeller extends StatefulWidget {
  var _currentUser;
  String appBarTitle = "";
  var _selectedOutlet = 0;

  final List<String> _outlet_names = [
    'CANTEEN',
    'HOTSPOT',
    'JUICE CORNER',
    'KERALA CANTEEN',
    'COFFEE DAY',
  ];
  HomeScreenSeller({currentUser}) {
    this.appBarTitle = 'BiteBuddy';
    this._currentUser = currentUser;
    this._selectedOutlet = _outlet_names.indexOf(this._currentUser["Name"]);
  }

  @override
  State<HomeScreenSeller> createState() => _HomeScreenSellerState();
}

class _HomeScreenSellerState extends State<HomeScreenSeller> {
  int currentTab = 0; // to keep track of active tab index
  Map<String, List<FoodItem>> _menu = {};

  List<int> tabColor = [0XFFFEFEE2, 0XFFFEFEE2, 0XFFFEFEE2, 0XFFFEFEE2];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = WelcomeScreen(); // Our first view in viewport

  void _changeAppBarTitle(String text) {
    setState(() {
      widget.appBarTitle = text;
    });
  }

  void _changeTab(number) {
    setState(() {
      currentTab = number; // if user taps on this dashboard tab will be active
    });

    if (currentTab == 0) {
      FirebaseFirestore.instance.collection('outlets').doc(widget._selectedOutlet.toString()).collection('orders').where('status', isLessThan: 3).get().then((QuerySnapshot qs) {
        List<Orderr> _orders = [];
        qs.docs.forEach((doc) {
          if (doc.exists) {
            List<FoodItem> _items = [];
            (doc["items"] as List).forEach((item) {
              double p = item.values.first["Price"].toDouble();
              List<String> av = [];
              item.values.first["Available"].forEach((a) {
                av.add(a.toString());
              });
              _items.add(FoodItem(name: item.keys.elementAt(0), price: p, availability: av, quantity: item.values.first["Quantity"]));
            });

            _orders.add(Orderr(doc["orderid"], doc["phonenumber"], doc["custname"], _items, doc["status"]));
          }
        });

        setState(() {
          currentScreen = OrderSeller(widget._selectedOutlet, _changeAppBarTitle, _orders);
        });
      });
    } else if (currentTab == 1) {
      print('lol');

      print(widget._selectedOutlet);
      FirebaseFirestore.instance.collection('outlets').doc(widget._selectedOutlet.toString()).collection('menu').get().then((QuerySnapshot qs) {
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
          _menu = categories;
        });
        setState(() {
          currentScreen = OutletMenuSeller(widget._selectedOutlet, _changeAppBarTitle, _menu);
        });
      });
    } else if (currentTab == 2) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.appBarTitle), backgroundColor: Theme.of(context).primaryColor, actions: [
          ElevatedButton(
            child: Text("Logout"),
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                print("Signed Out");
                Navigator.popUntil(
                  context,
                  ModalRoute.withName('/login'),
                );
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              });
            },
          ),
        ]),
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.add),
        //   onPressed: () {
        //     _sellStuffSheet(context);
        //   },
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        drawer: MainDrawer(widget._currentUser),
        bottomNavigationBar: BottomAppBar(
            color: Color(0xFF5F995E),
            // shape: CircularNotchedRectangle(),
            // notchMargin: 10,
            child: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MaterialButton(
                        minWidth: 40,
                        padding: EdgeInsets.only(left: 25, right: 25),
                        onPressed: () {
                          _changeTab(0);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.dashboard,
                              size: 35,
                              color: currentTab == 0 ? Color(tabColor[0]) : Colors.grey[450],
                            ),
                            Text(
                              'Orders',
                              style: TextStyle(
                                color: currentTab == 0 ? Color(tabColor[0]) : Colors.grey[450],
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        padding: EdgeInsets.only(left: 25, right: 25),
                        onPressed: () {
                          _changeTab(1);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.list_alt,
                              size: 35,
                              color: currentTab == 1 ? Color(tabColor[1]) : Colors.grey[450],
                            ),
                            Text(
                              'Menu',
                              style: TextStyle(
                                color: currentTab == 1 ? Color(tabColor[1]) : Colors.grey[450],
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        padding: EdgeInsets.only(left: 25, right: 25),
                        onPressed: () {
                          _changeTab(2);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.history,
                              size: 35,
                              color: currentTab == 2 ? Color(tabColor[2]) : Colors.grey[450],
                            ),
                            Text(
                              'History',
                              style: TextStyle(
                                color: currentTab == 2 ? Color(tabColor[2]) : Colors.grey[450],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // MaterialButton(
                      //   minWidth: 40,
                      //   padding: EdgeInsets.only(left: 25, right: 25),
                      //   onPressed: () {
                      //     _changeTab(3);
                      //   },
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: <Widget>[
                      //       Icon(
                      //         Icons.shopping_bag,
                      //         size: 35,
                      //         color: currentTab == 3
                      //             ? Color(tabColor[3])
                      //             : Colors.grey,
                      //       ),
                      //       Text(
                      //         'Buy/Sell',
                      //         style: TextStyle(
                      //           color: currentTab == 3
                      //               ? Color(tabColor[3])
                      //               : Colors.grey,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),

                  // Right Tab bar icons

                  //   Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       MaterialButton(
                  //         minWidth: 40,
                  //         onPressed: () {
                  //           _changeTab(2);
                  //         },
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: <Widget>[
                  //             Icon(
                  //               Icons.blinds_closed,
                  //               size: 35,
                  //               color: currentTab == 2
                  //                   ? Color(tabColor)
                  //                   : Colors.grey,
                  //             ),
                  //             Text(
                  //               'Orders',
                  //               style: TextStyle(
                  //                 color: currentTab == 2
                  //                     ? Color(tabColor)
                  //                     : Colors.grey,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       MaterialButton(
                  //         minWidth: 40,
                  //         onPressed: () {
                  //           _changeTab(3);
                  //         },
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: <Widget>[
                  //             Icon(
                  //               Icons.shopping_bag,
                  //               size: 35,
                  //               color: currentTab == 3
                  //                   ? Color(tabColor)
                  //                   : Colors.grey,
                  //             ),
                  //             Text(
                  //               'Buy/Sell',
                  //               style: TextStyle(
                  //                 color: currentTab == 3
                  //                     ? Color(tabColor)
                  //                     : Colors.grey,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   )
                  // ],
                ],
              ),
            )));
  }
}
