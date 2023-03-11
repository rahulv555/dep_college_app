import 'package:flutter/material.dart';

Future<void> showMyDialog(context, int index, Function _deleteCoupon) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete?'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('Are you sure you want to delete this coupon?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Confirm',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              print('Confirmed');
              _deleteCoupon(index);
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
