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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(elevation: 0, actions: [], backgroundColor: Theme.of(context).primaryColor),
      body: Stack(
        children: [
          Column(children: [Container(height: 100, color: Theme.of(context).primaryColor)]),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(child: CircleAvatar(backgroundColor: Colors.grey, minRadius: 40, child: Icon(Icons.person, color: Colors.white, size: 150)), alignment: Alignment.center),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Name : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            Text(widget._currentUser['Name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          ],
                        ),
                      ),
                      Divider(color: Theme.of(context).primaryColor, thickness: 1, indent: 20, endIndent: 20),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Phone number : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            Text(widget._currentUser['Phonenumber'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          ],
                        ),
                      ),
                      Divider(color: Theme.of(context).primaryColor, thickness: 1, indent: 20, endIndent: 20),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Graduation Year : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            Text(widget._currentUser['Gradyear'].toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(padding: EdgeInsets.only(top: 30), height: 230, child: Image(image: AssetImage('assets/images/bitebuddy_black.png'))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
