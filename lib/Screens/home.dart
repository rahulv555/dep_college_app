import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dep_college_app/Screens/Chat/chathome.dart';
import 'package:dep_college_app/Screens/buy_and_sell/main.dart';
import 'package:dep_college_app/Screens/coupon_exchange/main.dart';
import 'package:dep_college_app/Screens/food_order/main.dart';
import 'package:dep_college_app/Screens/login.dart';
import 'package:dep_college_app/Screens/orders/main.dart';
import 'package:dep_college_app/Screens/prof.dart';
import 'package:dep_college_app/Screens/welcome.dart';
import 'package:dep_college_app/models/coupon.dart';
import 'package:dep_college_app/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'coupon_exchange/sell_coupon.dart';
import 'maindrawer.dart';

class HomeScreen extends StatefulWidget {
  var _currentUser;
  List<Coupon> _coupons = [];
  String appBarTitle = "BiteBuddy";
  HomeScreen({currentUser}) {
    this._currentUser = currentUser;
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = -1; // to keep track of active tab index

  List<int> tabColor = [0XFFFEFEE2, 0XFFFEFEE2, 0XFFFEFEE2, 0XFFFEFEE2];

  // final List<Widget> screens = [
  //   CouponHome(._currentUser),
  //   FoodHome(),
  //   OrdersHome(),
  //   BuySellHome(),
  // ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = WelcomeScreen(); // Our first view in viewport

  void _changeAppBarTitle(String text) {
    setState(() {
      widget.appBarTitle = text;
    });
  }

  Map<Meal, String> meal_to_string = {
    Meal.breakfast: 'Breakfast',
    Meal.lunch: 'Lunch',
    Meal.dinner: 'Dinner',
    Meal.full: 'Full day',
  };

  void _changeTab(number) {
    //COUPON TAB LOADING
    if (number == 0) {
      List<Coupon> c = [];
      FirebaseFirestore.instance
          .collection('coupons')
          .get()
          .then((QuerySnapshot qs) {
        qs.docs.forEach((doc) {
          print(doc);
          if ((doc['dov'] as Timestamp)
                  .toDate()
                  .difference(DateTime.now())
                  .inDays <=
              -1) {
            //delete
            FirebaseFirestore.instance
                .collection('coupons')
                .doc(doc.id)
                .delete()
                .then((value) => print("deleted"));
          } else {
            c.add(Coupon(
                cost: double.parse(doc['cost']),
                discount: 0,
                dov: (doc['dov'] as Timestamp).toDate(),
                id: doc.id,
                phonenumber: doc['phonenumber'],
                quantity: 1,
                seller: doc['seller'],
                type: meal_to_string.inverse[doc['type']] as Meal,
                vendor:
                    doc['vendor'] == 'Bhopal' ? Vendor.bhopal : Vendor.kanaka));
          }
        });

        // print('lol');
        // print(c);

        setState(() {
          widget._coupons = c;
          currentTab = number;
          print(number);
          print(c);
          currentScreen = CouponHome(
              widget._currentUser, _changeAppBarTitle, widget._coupons);
          ; // if user taps on this dashboard tab will be active
        });
      });
    } else if (number == 1) {
      currentTab = number;
      currentScreen = FoodHome(_changeAppBarTitle);
    } else if (number == 2) {
      currentTab = number;
      currentScreen = OrdersHome(_changeAppBarTitle);
    } else if (number == 3) {
      setState(() {
        print(number);
        currentTab = number;
        currentScreen = ChatHome(widget._currentUser, _changeAppBarTitle);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 70,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  iconSize: 100,
                  icon: ImageIcon(
                    AssetImage('assets/images/bitebuddy_cream.png'),
                    size: 100,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            title:
                Text(widget.appBarTitle, style: TextStyle(color: creamColor)),
            backgroundColor: Theme.of(context).primaryColor,
            actions: [
              ElevatedButton(
                child: Text(
                  "Logout",
                  style: TextStyle(color: creamColor),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(greenColor))),
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    print("Signed Out");
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName('/login'),
                    );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
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
                              color: currentTab == 0
                                  ? Color(tabColor[0])
                                  : Colors.grey[450],
                            ),
                            Text(
                              'Coupons',
                              style: TextStyle(
                                color: currentTab == 0
                                    ? Color(tabColor[0])
                                    : Colors.grey[450],
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
                              Icons.food_bank_outlined,
                              size: 35,
                              color: currentTab == 1
                                  ? Color(tabColor[1])
                                  : Colors.grey[450],
                            ),
                            Text(
                              'Food',
                              style: TextStyle(
                                color: currentTab == 1
                                    ? Color(tabColor[1])
                                    : Colors.grey[450],
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
                              Icons.blinds_closed,
                              size: 35,
                              color: currentTab == 2
                                  ? Color(tabColor[2])
                                  : Colors.grey[450],
                            ),
                            Text(
                              'Orders',
                              style: TextStyle(
                                color: currentTab == 2
                                    ? Color(tabColor[2])
                                    : Colors.grey[450],
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        padding: EdgeInsets.only(left: 25, right: 25),
                        onPressed: () {
                          _changeTab(3);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.chat,
                              size: 35,
                              color: currentTab == 3
                                  ? Color(tabColor[3])
                                  : Colors.grey[450],
                            ),
                            Text(
                              'Chats',
                              style: TextStyle(
                                color: currentTab == 3
                                    ? Color(tabColor[3])
                                    : Colors.grey[450],
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
