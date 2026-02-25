import 'package:dep_college_app/models/order.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  List<Orderr> orders;
  Function _changeAppBarTitle;
  int _selectedOutlet;
  HistoryPage(this._selectedOutlet, this._changeAppBarTitle, this.orders) {
    print(this.orders);
  }

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        child: ListView.builder(
          itemCount: widget.orders.length,
          itemBuilder: (context, index) {
            if (widget.orders[index].status == 3) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Column(
                    children: [
                      Card(
                        elevation: 0,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text('ORDER ID : ' + widget.orders[index].orderid.substring(23), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Name : ' + widget.orders[index].custname, style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('Phone Number : ' + widget.orders[index].phonenumber, style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [Text('Item Name', style: TextStyle(fontWeight: FontWeight.bold)), Text('Qty', style: TextStyle(fontWeight: FontWeight.bold))],
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: widget.orders[index].items.length,
                                    itemBuilder: (c, i) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [Text('•  ' + widget.orders[index].items[i].name), Text(widget.orders[index].items[i].quantity.toString())],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Theme.of(context).primaryColor, thickness: 1, indent: 20, endIndent: 20),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
