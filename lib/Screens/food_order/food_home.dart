import 'package:flutter/material.dart';

class FoodHomePage extends StatefulWidget {
  Function _selectOutlet;
  Function _selectView;
  Function _changeAppBarTitle;

  FoodHomePage(this._selectOutlet, this._selectView, this._changeAppBarTitle) {
    // this._changeAppBarTitle('Food');
  }

  @override
  State<FoodHomePage> createState() => _FoodHomePageState();
}

class _FoodHomePageState extends State<FoodHomePage> {
  final List<String> _image_locs = ['assets/images/main-cafe.jpg', 'assets/images/maggipoint.jpg', 'assets/images/juice-corner.jpg', 'assets/images/keralacanteen.jpg', 'assets/images/coffeeday.jpg'];

  final List<String> _outlet_names = ['CANTEEN', 'HOTSPOT', 'JUICE CORNER', 'KERALA CANTEEN', 'COFFEE DAY'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView.builder(
        itemCount: _image_locs.length,
        itemBuilder: (ctx, index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: GestureDetector(
              onTap: () {
                print(_outlet_names[index]);
                widget._selectOutlet(index);
                widget._selectView(1);
                widget._changeAppBarTitle(_outlet_names[index]);
              },
              child: Stack(
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(20), child: Image(fit: BoxFit.contain, width: 400, image: new AssetImage(_image_locs[index]))),
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 180),
                    child: Text(
                      '${_outlet_names[index]}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        shadows: [Shadow(offset: Offset(3, 3), blurRadius: 5, color: Color.fromARGB(255, 0, 0, 0))],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
