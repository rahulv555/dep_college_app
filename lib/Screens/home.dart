import 'package:dep_college_app/Screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  var _currentUser;
  HomeScreen({currentUser}) {
    this._currentUser = currentUser;
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        Text('LOLOLO'),
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
      body: Text(widget._currentUser?['Name']),
    );
  }
}
