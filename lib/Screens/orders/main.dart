import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dep_college_app/models/order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrdersHome extends StatefulWidget {
  Function _changeAppBarTitle;
  List<Orderr> orders;
  List<String> outlets;
  OrdersHome(this._changeAppBarTitle, this.orders, this.outlets) {
    _changeAppBarTitle('Orders');
  }

  @override
  State<OrdersHome> createState() => _OrdersHomeState();
}

class _OrdersHomeState extends State<OrdersHome> {
  Map cardcolor = {
    0: Colors.grey,
    2: Colors.green,
  };

  final List<String> _outlet_names = [
    'CANTEEN',
    'HOTSPOT',
    'JUICE CORNER',
    'KERALA CANTEEN',
    'COFFEE DAY',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: ListView.builder(
            itemCount: widget.orders.length,
            itemBuilder: (context, index) {
              if (widget.orders[index].status <= 3)
                return Column(
                  children: [
                    Card(
                      elevation: 0,
                      //color: Theme.of(context).backgroundColor,
                      color: widget.orders[index].status != 2 ? Theme.of(context).backgroundColor : cardcolor[widget.orders[index].status],
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(children: [
                          Container(padding: EdgeInsets.all(10), child: Text('ORDER ID : ' + widget.orders[index].orderid.substring(23), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _outlet_names[int.parse(widget.outlets[index])],
                                      style: TextStyle(color: Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Item Name',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text('Qty', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: widget.orders[index].items.length,
                                    itemBuilder: (c, i) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('•  ' + widget.orders[index].items[i].name),
                                          Text(widget.orders[index].items[i].quantity.toString()),
                                          // Text(_outlet_names[widget.outlets[index]]),
                                        ],
                                      );
                                    }),
                              ],
                            ),
                          ),
                          if (widget.orders[index].status == 2)
                            Container(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(fixedSize: Size(150, 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth.instance.currentUser?.uid)
                                      .collection('orders')
                                      .where('orderid', isEqualTo: widget.orders[index].orderid)
                                      .get()
                                      .then((querySnapshot) {
                                    if (querySnapshot.size > 0) {
                                      // Assuming there is only one document matching the query
                                      final documentSnapshot = querySnapshot.docs[0];

                                      // Update the parameter value
                                      documentSnapshot.reference.update({
                                        'status': 3,
                                      }).then((_) {
                                        setState(() {
                                          widget.orders[index].status = 3;
                                        });
                                        print('Parameter updated successfully!');
                                        FirebaseFirestore.instance
                                            .collection('outlets')
                                            .doc(documentSnapshot['outlet'])
                                            .collection('orders')
                                            .where('orderid', isEqualTo: widget.orders[index].orderid)
                                            .get()
                                            .then((value) {
                                          if (value.size > 0) {
                                            // Assuming there is only one document matching the query
                                            final documentSnapshot = value.docs[0];

                                            // Update the parameter value
                                            documentSnapshot.reference.update({
                                              'status': 3,
                                            });
                                          }
                                        });
                                      }).catchError((error) {
                                        print('Failed to update parameter: $error');
                                      });
                                    } else {
                                      print('No matching documents found.');
                                    }
                                  });
                                },
                                child: Text('Received order'),
                              ),
                            )
                        ]),
                      ),
                    ),
                    if (widget.orders[index].status == 1)
                      Text('Getting ready...',
                          style: TextStyle(
                            color: Colors.red,
                          )),
                    Divider(
                      color: Theme.of(context).primaryColor,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    )
                  ],
                );
            }));
  }
}
