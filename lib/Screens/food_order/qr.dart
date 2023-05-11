import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dep_college_app/models/fooditem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Qr extends StatefulWidget {
  Map<String, FoodItem> _cart;
  String _selectedOutlet;

  Qr(this._cart, this._selectedOutlet);

  @override
  State<Qr> createState() => _QrState();
}

class _QrState extends State<Qr> {
  int status = 0;
  String _orderid = '';

  @override
  Widget build(BuildContext context) {
    String phonenumber = "";
    String name = "";

    FirebaseFirestore.instance.collection('outlets').doc(widget._selectedOutlet).collection('orders').where('orderid', isEqualTo: _orderid).get().then((value) {
      if (value.docs.first['status'] == -2) {
        final documentSnapshot = value.docs[0];
        documentSnapshot.reference.delete();
        // Update the parameter value

        Navigator.of(context).pop();
      } else if (value.docs.first['status'] == 1) {
        List<Map> _items = [];
        widget._cart.forEach((key, value) {
          _items.add({
            'Name': key,
            'Price': widget._cart[key]!.price,
            'Quantity': widget._cart[key]!.quantity,
          });
        });
        FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('orders').add({
          "orderid": _orderid,
          "phonenumber": phonenumber,
          "custname": name,
          "items": _items,
          "status": 1,
          "outlet": widget._selectedOutlet,
        });
        Navigator.pop(context);
        Navigator.pop(context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: Column(
          children: [
            Container(padding: EdgeInsets.only(top: 150), child: Image(image: new AssetImage('assets/images/qr.png'))),
            status == 0
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () {
                      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
                        List<Map> _items = [];
                        widget._cart.forEach((key, value) {
                          _items.add({
                            'Name': key,
                            'Price': widget._cart[key]!.price,
                            'Quantity': widget._cart[key]!.quantity,
                          });
                        });
                        setState(() {
                          _orderid = DateTime.now().toString();
                          phonenumber = value["Phonenumber"];
                          name = value["Name"];
                        });
                        FirebaseFirestore.instance.collection('outlets').doc(widget._selectedOutlet).collection('orders').add({
                          "orderid": _orderid,
                          "phonenumber": value['Phonenumber'],
                          "custname": value["Name"],
                          "items": _items,
                          "status": 0,
                          "custid": FirebaseAuth.instance.currentUser?.uid.toString(),
                        }).then((value) {
                          setState(() {
                            status = 1;
                          });
                        });
                      });
                    },
                    child: Text('Payment completed'))
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () {
                      setState(() {
                        status += 1;
                      });
                    },
                    child: Text('Waiting for confirmation, click to refresh'))
          ],
        ),
      ),
    );
  }
}
