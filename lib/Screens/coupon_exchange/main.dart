import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dep_college_app/Screens/Chat/chathome.dart';
import 'package:dep_college_app/Screens/coupon_exchange/edit_coupon.dart';
import 'package:dep_college_app/Screens/coupon_exchange/selectview.dart';
import 'package:dep_college_app/Screens/coupon_exchange/searchbar.dart';
import 'package:dep_college_app/models/coupon.dart';
import 'package:dep_college_app/utilities/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
//import 'package:url_launcher/url_launcher.dart';
//import 'package:url_launcher_web/url_launcher_web.dart';
import 'package:whatsapp_share2/whatsapp_share2.dart';
import './delete_alert.dart';

import 'sell_coupon.dart';

class CouponHome extends StatefulWidget {
  List<Coupon> coupons = [];
  var _currentUser;
  Function _changeAppBarTitle;

  CouponHome(this._currentUser, this._changeAppBarTitle, this.coupons) {
    _changeAppBarTitle('Coupons');
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
    Meal.full: 'Full day',
  };
  int _selectedView = 0;
  List<String> _image = ['assets/images/bhopal.jpeg', 'assets/images/kanaka.jpeg'];

  // void _createRoom(_currentUser, _otherUser) {
  //   String chatroomid = [FirebaseAuth.instance.currentUser?.uid, _otherUser].join();
  //   print(_otherUser);
  //   FirebaseFirestore.instance.collection('chatrooms').doc().set({
  //     'messages': [],
  //     'dov': Timestamp.fromDate(DateTime.now()),
  //   }).then((value) {
  //     FirebaseFirestore.instance.collection('chatrooms').doc(chatroomid).get().then((value) {
  //       List<List<String>> messages = value['messages']; // index 0 sender, index 1 message
  //       DateTime doc = (value['dov'] as Timestamp).toDate();

  //       Navigator.push(context, MaterialPageRoute(builder: (context) => ChatHome(_currentUser, chatroomid, widget._changeAppBarTitle)));
  //     });
  //   });
  // }

  Future<void> _createRoom(_currentUser, _otherUser) async {
    FirebaseFirestore.instance.collection('users').doc(_otherUser).get().then((value) async {
      String phonenumber = value['Phonenumber'].toString();

      await WhatsappShare.share(phone: phonenumber, text: 'Hi!! I am interested in buying your coupon. Can i get more details?');
    });
  }

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

    FirebaseFirestore.instance.collection('coupons').add({
      'cost': cost,
      'discount': 0,
      'dov': Timestamp.fromDate(dov),
      'type': meal,
      'phonenumber': widget._currentUser['Phonenumber'],
      'quantity': 1,
      'seller': FirebaseAuth.instance.currentUser?.uid,
      'vendor': vendor,
    }).then((value) {
      setState(() {
        widget.coupons.add(Coupon(
            id: value.id,
            cost: double.parse(cost),
            discount: 0,
            dov: dov,
            quantity: 1,
            type: type,
            phonenumber: widget._currentUser['Phonenumber'],
            seller: FirebaseAuth.instance.currentUser?.uid as String,
            vendor: v));
      });
      return;
    });
  }

  void _editCoupon(String cost, String date, String meal, String vendor, int index) {
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
    String id = widget.coupons[index].id;

    Meal type = meal_to_string.inverse[meal] as Meal;

    FirebaseFirestore.instance.collection('coupons').doc(id).update({
      'cost': cost,
      'discount': 0,
      'dov': Timestamp.fromDate(dov),
      'type': meal,
      'phonenumber': widget._currentUser['Phonenumber'],
      'quantity': 1,
      'seller': FirebaseAuth.instance.currentUser?.uid,
      'vendor': vendor,
    }).then((value) {
      setState(() {
        widget.coupons[index] = Coupon(
            id: id,
            cost: double.parse(cost),
            discount: 0,
            dov: dov,
            quantity: 1,
            type: type,
            phonenumber: widget._currentUser['Phonenumber'],
            seller: FirebaseAuth.instance.currentUser?.uid as String,
            vendor: v);
      });
      return;
    });
  }

  void _deleteCoupon(int index) {
    String id = widget.coupons[index].id;
    setState(() {
      widget.coupons.removeAt(index);
    });

    FirebaseFirestore.instance.collection('coupons').doc(id).delete();
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
            child: EditCoupon(_editCoupon, index, widget.coupons[index]),
          );
        });
  }

  void _updateSelectedView(int opt) {
    setState(() {
      _selectedView = opt;
    });
  }

  void _filterCoupon(List<String> options) {
    ;
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
            SearchBar(_filterCoupon),
            Container(
                height: 600,
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
                                        image: new AssetImage(widget.coupons[index].vendor == Vendor.bhopal ? _image[0] : _image[1]),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10, right: 30),
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                              (widget.coupons[index].vendor == Vendor.bhopal ? "Bhopal - " : "Kanaka - ") + meal_to_string[widget.coupons[index].type].toString()),
                                          SizedBox(height: 10.0),
                                          Text(
                                            'Valid for : ' + DateFormat.yMd().format(widget.coupons[index].dov.add(Duration(days: 2))).toString(),
                                            style: TextStyle(fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            'Sold by : ' + widget.coupons[index].phonenumber,
                                            style: TextStyle(fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 7, left: 10),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Rs. ${widget.coupons[index].cost}',
                                            style: TextStyle(color: Color(greenColor), fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                _createRoom(widget._currentUser, widget.coupons[index].seller);
                                              },
                                              splashRadius: 20,
                                              icon: Icon(
                                                Icons.chat_bubble,
                                                color: Theme.of(context).primaryColor,
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
                          if (widget.coupons[index].seller != FirebaseAuth.instance.currentUser?.uid)
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
                                          image: new AssetImage(widget.coupons[index].vendor == Vendor.bhopal ? _image[0] : _image[1]),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10, right: 30),
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                (widget.coupons[index].vendor == Vendor.bhopal ? "Bhopal - " : "Kanaka - ") + meal_to_string[widget.coupons[index].type].toString()),
                                            SizedBox(height: 10.0),
                                            Text(
                                              'Valid for : ' + DateFormat.yMd().format(widget.coupons[index].dov.add(Duration(days: 2))).toString(),
                                              style: TextStyle(fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              'Sold by : ' + widget.coupons[index].phonenumber,
                                              style: TextStyle(fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 7, left: 1),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Rs. ${widget.coupons[index].cost}',
                                              style: TextStyle(color: Color(greenColor), fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      showMyDialog(context, index, _deleteCoupon);
                                                    },
                                                    splashRadius: 20,
                                                    icon: Icon(
                                                      Icons.delete_forever,
                                                      color: Theme.of(context).primaryColor,
                                                    )),
                                                IconButton(
                                                    onPressed: () {
                                                      _editCouponSheet(ctx, index);
                                                    },
                                                    splashRadius: 20,
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: Theme.of(context).primaryColor,
                                                    )),
                                              ],
                                            ),
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
