import 'package:dep_college_app/Screens/selectviewsales.dart';
import 'package:flutter/material.dart';

class Sales extends StatefulWidget {
  var _currentUser;
  List<dynamic> data;
  Sales(this._currentUser, this.data) {
    print(data);
    this.data.sort((a, b) {
      // Extract the values from the maps
      dynamic valueA = a.values.first;
      dynamic valueB = b.values.first;

      // Compare the values
      return valueB.compareTo(valueA);
    });
  }

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  int _selectedView = 1;
  void _updateSelectedView(int opt) {
    setState(() {
      _selectedView = opt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Sales'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Container(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Item',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text('Expected Demand', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
              ]),
            ),
            Container(
                padding: EdgeInsets.only(top: 20),
                height: 600,

                // SelectView(_updateSelectedView),
                child: Container(
                  child: ListView.builder(
                    itemCount: widget.data.length,
                    itemBuilder: (context, index) => Container(
                      child: Card(
                          color: Theme.of(context).backgroundColor,
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text(widget.data[index].keys.first.toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                            Text(widget.data[index][widget.data[index].keys.first.toString()].toString().split('.')[0], style: TextStyle(fontSize: 15))
                          ])),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
