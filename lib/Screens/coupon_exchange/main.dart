import 'dart:io';

import 'package:dep_college_app/Screens/coupon_exchange/selectview.dart';
import 'package:dep_college_app/Screens/searchbar.dart';
import 'package:dep_college_app/models/coupon.dart';
import 'package:dep_college_app/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import 'sell_coupon.dart';

class CouponHome extends StatefulWidget {
  List<Coupon> coupons = [];
  var _currentUser;
  Function _changeAppBarTitle;

  CouponHome(this._currentUser, this._changeAppBarTitle) {
    _changeAppBarTitle('Coupons');
    coupons = [
      Coupon(
          cost: 51,
          discount: 23,
          dov: DateTime.now(),
          phonenumber: "92038982103",
          quantity: 2,
          seller: 'dsfsdfdsfd',
          vendor: Vendor.bhopal,
          type: Meal.breakfast),
      Coupon(
          cost: 322,
          discount: 13,
          dov: DateTime.now(),
          phonenumber: "92038222103",
          quantity: 1,
          seller: 'asdasdasdasd',
          vendor: Vendor.kanaka,
          type: Meal.dinner),
    ];
    print("Coupons");
  }

  @override
  State<CouponHome> createState() => _CouponHomeState();
}

class _CouponHomeState extends State<CouponHome> {
  Map<Meal, String> meal_to_string = {
    Meal.breakfast: 'Breakfast',
    Meal.lunch: 'Lunch',
    Meal.dinner: 'Dinner',
  };
  int _selectedView = 0;
  List<String> _image = [
    'assets/images/bhopal.jpeg',
    'assets/images/kanaka.jpeg'
  ];

  void _addCoupon(String cost, String date, String meal, String vendor) {
    Navigator.pop(context);
    DateTime dov = DateTime.now();
    switch (date) {
      case 'Today':
        break;
      case 'Tomorrow':
        dov = DateTime.now().add(Duration(days: 1));
        break;
      case 'Day after tomorrow':
        dov = DateTime.now().add(Duration(days: 2));
        break;
    }

    Vendor v = vendor == 'Bhopal' ? Vendor.bhopal : Vendor.kanaka;

    Meal type = meal_to_string.inverse[meal] as Meal;
    setState(() {
      widget.coupons.add(Coupon(
          cost: double.parse(cost),
          discount: 0,
          dov: dov,
          quantity: 1,
          type: type,
          phonenumber: widget._currentUser['Phonenumber'],
          seller: FirebaseAuth.instance.currentUser?.uid as String,
          vendor: v));
    });
  }

  void _sellCouponSheet(BuildContext ctx) {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).backgroundColor,
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: SellCoupon(_addCoupon),
          );
        });
  }

  void _editCouponSheet(BuildContext ctx, int index) {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).backgroundColor,
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: SellCoupon(_addCoupon),
          );
        });
  }

  void _updateSelectedView(int opt) {
    setState(() {
      _selectedView = opt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).backgroundColor,
        ),
        onPressed: () {
          _sellCouponSheet(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SelectView(_updateSelectedView),
            SearchBar(),
            Container(
                child: _selectedView == 0
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          return Column(
                            children: [
                              Card(
                                elevation: 0,
                                color: Theme.of(context).backgroundColor,
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 30),
                                      width: 60,
                                      height: 60,
                                      child: Image(
                                        width: 50,
                                        height: 50,
                                        image: new AssetImage(
                                            widget.coupons[index].vendor ==
                                                    Vendor.bhopal
                                                ? _image[0]
                                                : _image[1]),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 30),
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              (widget.coupons[index].vendor ==
                                                          Vendor.bhopal
                                                      ? "Bhopal - "
                                                      : "Kanaka - ") +
                                                  meal_to_string[widget
                                                          .coupons[index].type]
                                                      .toString()),
                                          SizedBox(height: 10.0),
                                          Text(
                                            'Valid for : ' +
                                                DateFormat.yMd()
                                                    .format(widget
                                                        .coupons[index].dov
                                                        .add(Duration(days: 2)))
                                                    .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            'Sold by : ' +
                                                widget
                                                    .coupons[index].phonenumber,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 7),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Rs. ${widget.coupons[index].cost}',
                                            style: TextStyle(
                                                color: Color(greenColor),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              splashRadius: 20,
                                              icon: Icon(
                                                Icons.chat_bubble,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: Theme.of(context).primaryColor,
                                thickness: 1,
                                indent: 50,
                                endIndent: 50,
                              )
                            ],
                          );
                        },
                        itemCount: widget.coupons.length,
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) {
                          if (widget.coupons[index].seller !=
                              FirebaseAuth.instance.currentUser?.uid)
                            return SizedBox.shrink();
                          else
                            return Column(
                              children: [
                                Card(
                                  elevation: 0,
                                  color: Theme.of(context).backgroundColor,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 30),
                                        width: 60,
                                        height: 60,
                                        child: Image(
                                          width: 50,
                                          height: 50,
                                          image: new AssetImage(
                                              widget.coupons[index].vendor ==
                                                      Vendor.bhopal
                                                  ? _image[0]
                                                  : _image[1]),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 10, right: 30),
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                                (widget.coupons[index].vendor ==
                                                            Vendor.bhopal
                                                        ? "Bhopal - "
                                                        : "Kanaka - ") +
                                                    meal_to_string[widget
                                                            .coupons[index]
                                                            .type]
                                                        .toString()),
                                            SizedBox(height: 10.0),
                                            Text(
                                              'Valid for : ' +
                                                  DateFormat.yMd()
                                                      .format(widget
                                                          .coupons[index].dov
                                                          .add(Duration(
                                                              days: 2)))
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              'Sold by : ' +
                                                  widget.coupons[index]
                                                      .phonenumber,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 7),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Rs. ${widget.coupons[index].cost}',
                                              style: TextStyle(
                                                  color: Color(greenColor),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  _editCouponSheet(ctx, index);
                                                },
                                                splashRadius: 20,
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Theme.of(context).primaryColor,
                                  thickness: 1,
                                  indent: 50,
                                  endIndent: 50,
                                )
                              ],
                            );
                        },
                        itemCount: widget.coupons.length,
                      )),
          ],
        ),
      ),
    );
  }
}
