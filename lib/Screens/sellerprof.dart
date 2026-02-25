import 'dart:convert';

import 'package:dep_college_app/Screens/sales.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SellerProfile extends StatefulWidget {
  var _currentUser;

  SellerProfile(this._currentUser) {}

  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

Future<void> readJson() async {
  final String response = await rootBundle.loadString('assets/PREDICTIONS.json');
  final data = await json.decode(response);
// ...
}

class _SellerProfileState extends State<SellerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Profile'),
        elevation: 0,
        actions: [],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(children: [
        Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
        SingleChildScrollView(
            child: Column(
          children: [
            Container(
              child: Image(
                image: AssetImage('assets/images/main-cafe.jpg'),
                width: 500,
              ),
              alignment: Alignment.center,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Name : ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          widget._currentUser['Name'],
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).primaryColor,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phone number : ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          widget._currentUser['Phonenumber'],
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).primaryColor,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                ],
              ),
            ),
            // Container(
            //   padding: EdgeInsets.only(top: 30),
            //   height: 230,
            //   child: Image(
            //     image: AssetImage('assets/images/bitebuddy_black.png'),
            //   ),
            // )
            ElevatedButton(
              onPressed: () async {
                final String response = await rootBundle.loadString('assets/PREDICTIONS.json');
                final data = await json.decode(response);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Sales(widget._currentUser, data['items'])));
              },
              child: Text('Sales'),
              style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, minimumSize: Size(100, 50)),
            )
          ],
        )),
      ]),
    );
  }
}
