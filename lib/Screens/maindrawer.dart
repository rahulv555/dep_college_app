import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dep_college_app/Screens/sellerprof.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'prof.dart';

class MainDrawer extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final _currentUser;
  MainDrawer(this._currentUser);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).backgroundColor,
      child: Column(children: [
        Container(
          height: 120,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          child: Text(
            'Hello, ${_currentUser?['Name']}',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 30, color: Theme.of(context).primaryColor),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // ListTile(
        //   leading: Icon(Icons.settings, size: 26),
        //   title: Text('Settings'),
        //   onTap: () {},
        // ),
        Theme(
          data: ThemeData(
            splashColor: Colors.blue[100],
            highlightColor: Colors.blue.withOpacity(.5),
          ),
          child: ListTile(
            leading: Icon(Icons.settings, size: 26),
            title: Text("Settings"),
            onTap: () {},
          ),
        ),
        Theme(
            data: ThemeData(
              splashColor: Colors.blue[100],
              highlightColor: Colors.blue.withOpacity(.5),
            ),
            child: ListTile(
              leading: Icon(Icons.man, size: 26),
              title: Text("Profile"),
              onTap: () {
                if (_currentUser["outlet"] == false) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(_currentUser)));
                } else {
                  //seller profile
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SellerProfile(_currentUser)));
                }
              },
            ))
      ]),
    );
  }
}
