import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dep_college_app/models/order.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class OrderSeller extends StatefulWidget {
  Function _changeAppBarTitle;
  int _selectedOutlet;
  List<Orderr> orders;
  OrderSeller(
    this._selectedOutlet,
    this._changeAppBarTitle,
    this.orders,
  ) {
    print('selected outlet' + this._selectedOutlet.toString());
    print(orders);
  }

  @override
  State<OrderSeller> createState() => _OrderSellerState();
}

class _OrderSellerState extends State<OrderSeller> {
  Map cardcolor = {
    0: Colors.grey,
    2: Colors.green,
  };

  @override
  Widget build(BuildContext context) {
    bool y = false;
    widget.orders.forEach((element) {
      if (element.status < 3 && element.status > -1) {
        y = true;
      }
    });

    return Scaffold(
      body: Stack(children: [
        Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.all(20),
          child: Center(
              child: Text(
            'NO ORDERS YET!!!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Theme.of(context).primaryColor),
          )),
        ),
        if (y)
          Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Container(
              width: double.infinity,
              child: ListView.builder(
                  itemCount: widget.orders.length,
                  itemBuilder: (context, index) {
                    if (widget.orders[index].status <= 3)
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                                elevation: 0,
                                color: widget.orders[index].status == 1 ? Theme.of(context).backgroundColor : cardcolor[widget.orders[index].status],
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          'ORDER ID : ' + widget.orders[index].orderid.substring(23),
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Name : ' + widget.orders[index].custname, style: TextStyle(fontWeight: FontWeight.bold)),
                                            Text('Phone Number : ' + widget.orders[index].phonenumber, style: TextStyle(fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                                        child: Column(
                                          children: [
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
                                                    ],
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                      if (widget.orders[index].status == 0)
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(fixedSize: Size(150, 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('outlets')
                                                      .doc(widget._selectedOutlet.toString())
                                                      .collection('orders')
                                                      .where('orderid', isEqualTo: widget.orders[index].orderid)
                                                      .get()
                                                      .then((querySnapshot) {
                                                    if (querySnapshot.size > 0) {
                                                      // Assuming there is only one document matching the query
                                                      final documentSnapshot = querySnapshot.docs[0];

                                                      // Update the parameter value
                                                      documentSnapshot.reference.update({
                                                        'status': 1,
                                                      }).then((_) {
                                                        setState(() {
                                                          widget.orders[index].status = 1;
                                                        });
                                                        print('Parameter updated successfully!');
                                                      }).catchError((error) {
                                                        print('Failed to update parameter: $error');
                                                      });
                                                    } else {
                                                      print('No matching documents found.');
                                                    }
                                                  });
                                                },
                                                child: Text('Verify payment'),
                                              ),
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.red, fixedSize: Size(150, 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('outlets')
                                                        .doc(widget._selectedOutlet.toString())
                                                        .collection('orders')
                                                        .where('orderid', isEqualTo: widget.orders[index].orderid)
                                                        .get()
                                                        .then((querySnapshot) {
                                                      if (querySnapshot.size > 0) {
                                                        // Assuming there is only one document matching the query
                                                        final documentSnapshot = querySnapshot.docs[0];

                                                        // Update the parameter value
                                                        documentSnapshot.reference.update({
                                                          'status': -2,
                                                        }).then((_) {
                                                          setState(() {
                                                            widget.orders.removeAt(index);
                                                          });
                                                          print('Parameter updated successfully!');
                                                        }).catchError((error) {
                                                          print('Failed to update parameter: $error');
                                                        });
                                                      } else {
                                                        print('No matching documents found.');
                                                      }
                                                    });
                                                  },
                                                  child: Text('Cancel Order'))
                                            ],
                                          ),
                                        ),
                                      if (widget.orders[index].status == 1)
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: ElevatedButton(
                                            child: Text('Order Ready'),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Theme.of(context).primaryColor, fixedSize: Size(150, 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection('outlets')
                                                  .doc(widget._selectedOutlet.toString())
                                                  .collection('orders')
                                                  .where('orderid', isEqualTo: widget.orders[index].orderid)
                                                  .get()
                                                  .then((querySnapshot) {
                                                if (querySnapshot.size > 0) {
                                                  // Assuming there is only one document matching the query
                                                  final documentSnapshot = querySnapshot.docs[0];

                                                  // Update the parameter value
                                                  documentSnapshot.reference.update({
                                                    'status': 2,
                                                  }).then((_) {
                                                    setState(() {
                                                      widget.orders[index].status = 2;
                                                    });
                                                    print('Parameter updated successfully!');
                                                    FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(documentSnapshot['custid'])
                                                        .collection('orders')
                                                        .where('orderid', isEqualTo: widget.orders[index].orderid)
                                                        .get()
                                                        .then((value) {
                                                      if (value.size > 0) {
                                                        // Assuming there is only one document matching the query
                                                        final documentSnapshot = value.docs[0];

                                                        // Update the parameter value
                                                        documentSnapshot.reference.update({
                                                          'status': 2,
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
                                          ),
                                        ),
                                    ],
                                  ),
                                )),
                          ),
                          Divider(
                            color: Theme.of(context).primaryColor,
                            thickness: 1,
                            indent: 50,
                            endIndent: 50,
                          )
                        ],
                      );
                  }),
            ),
          ),
      ]),
    );
  }
}
