import 'package:dep_college_app/Screens/buy_and_sell/main.dart';
import 'package:dep_college_app/Screens/coupon_exchange/main.dart';
import 'package:dep_college_app/Screens/food_order/main.dart';
import 'package:dep_college_app/Screens/login.dart';
import 'package:dep_college_app/Screens/orders/main.dart';
import 'package:dep_college_app/Screens/prof.dart';
import 'package:dep_college_app/models/coupon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'coupon_exchange/sell_coupon.dart';
import 'maindrawer.dart';

class HomeScreen extends StatefulWidget {
  var _currentUser;
  HomeScreen({currentUser}) {
    this._currentUser = currentUser;
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0; // to keep track of active tab index

  List<int> tabColor = [0XFFFEFEE2, 0XFFFEFEE2, 0XFFFEFEE2, 0XFFFEFEE2];

  final List<Widget> screens = [
    CouponHome(),
    FoodHome(),
    OrdersHome(),
    BuySellHome(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = CouponHome(); // Our first view in viewport

  void _changeTab(number) {
    setState(() {
      currentTab = number;
      currentScreen = screens[
          currentTab]; // if user taps on this dashboard tab will be active
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Useful App"), actions: [
          ElevatedButton(
            child: Text("Logout"),
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
                              'Orders',
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
                              Icons.list_alt,
                              size: 35,
                              color: currentTab == 1
                                  ? Color(tabColor[1])
                                  : Colors.grey[450],
                            ),
                            Text(
                              'Menu',
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
                              Icons.history,
                              size: 35,
                              color: currentTab == 2
                                  ? Color(tabColor[2])
                                  : Colors.grey[450],
                            ),
                            Text(
                              'History',
                              style: TextStyle(
                                color: currentTab == 2
                                    ? Color(tabColor[2])
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
