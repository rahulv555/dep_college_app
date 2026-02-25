import 'package:flutter/material.dart';

class ChatHome extends StatefulWidget {
  var _currentUser;
  Function _changeAppBarTitle;
  ChatHome(this._currentUser, this._changeAppBarTitle) {
    _changeAppBarTitle("Chats");
  }

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Theme.of(context).scaffoldBackgroundColor, body: Container());
  }
}
