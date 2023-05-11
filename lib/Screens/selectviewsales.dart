import 'package:dep_college_app/utilities/colors.dart';
import 'package:flutter/material.dart';

class SelectView extends StatefulWidget {
  Function _updateSelectedView;
  SelectView(this._updateSelectedView);

  @override
  State<SelectView> createState() => _SelectViewState();
}

class _SelectViewState extends State<SelectView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
      height: 50,
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFF6F6F6),
              elevation: 0,
              bottom: TabBar(
                  unselectedLabelColor: Color(greenColor),
                  onTap: (value) {
                    print(value);
                    return widget._updateSelectedView(value);
                  },
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(gradient: LinearGradient(colors: [Color(greenColor), Color(0xFF7FC37E)]), borderRadius: BorderRadius.circular(50), color: Colors.redAccent),
                  tabs: [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Sales last week"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Expected demand"),
                      ),
                    ),
                  ]),
            ),
            body: TabBarView(children: [
              Icon(Icons.apps),
              Icon(Icons.movie),
            ]),
          )),
    );
  }
}
