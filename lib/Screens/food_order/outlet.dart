import 'package:dep_college_app/Screens/food_order/searchbar.dart';
import 'package:flutter/material.dart';

class OutletMenu extends StatefulWidget {
  int _selectedOutlet = 0;
  Function _selectView;
  Function _changeAppBarTitle;

  final List<String> _outlet_names = [
    'CAFETARIA',
    'HOTSPOT',
    'JUICE CORNER',
    'KERALA CANTEEN',
    'COFFEE DAY',
  ];

  OutletMenu(this._selectedOutlet, this._selectView, this._changeAppBarTitle) {
    // this._changeAppBarTitle(_outlet_names[_selectedOutlet]);
  }

  @override
  State<OutletMenu> createState() => _OutletMenuState();
}

class _OutletMenuState extends State<OutletMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      widget._changeAppBarTitle('Food');
                      widget._selectView(0);
                    },
                    icon: Icon(Icons.arrow_back)),
                Container(
                  width: 300,
                  child: Text(
                    'MENU',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  alignment: Alignment.center,
                ),
              ],
            ),
            SearchBar(() => {})
          ],
        ),
      ),
    );
  }
}
