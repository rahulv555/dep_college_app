import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  var _currentUser;

  Profile(this._currentUser) {}

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: []),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            child: Icon(
              Icons.person,
              size: 150,
            ),
            alignment: Alignment.center,
          ),
          Container(
            child: Text(widget._currentUser['Name']),
          ),
          Container(
            child: Text(widget._currentUser['Phonenumber']),
          ),
          Container(
            child: Text(widget._currentUser['Gradyear'].toString()),
          ),
        ],
      )),
    );
  }
}
