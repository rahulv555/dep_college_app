import 'package:dep_college_app/Screens/coupon_exchange/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_filter_dialog/flutter_filter_dialog.dart';

class SearchBar extends StatefulWidget {
  Function _filterItems;
  SearchBar(this._filterItems);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: TextField(
                  cursorColor: Color(0xFFBDBDBD),
                  decoration: InputDecoration(
                    fillColor: Color(0xFFF6F6F6),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xffBDBDBD),
                    ),
                    suffixIcon: IconButton(
                      iconSize: 20,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FilterCoupons(widget._filterItems)));
                      },
                      splashRadius: 1,
                      icon: Icon(
                        Icons.filter_alt_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),

                    // prefixIcon: Container(
                    //   padding: EdgeInsets.all(15),
                    //   child: Image.asset('assets/icons/search.png'),
                    //   width: 18,
                    // )),
                  ),
                ),
              ),
              // Container(
              //     margin: EdgeInsets.only(left: 10),
              //     // padding: EdgeInsets.all(15),
              //     alignment: Alignment.center,
              //     // decoration: BoxDecoration(
              //     //     color: Theme.of(context).primaryColor,
              //     //     borderRadius: BorderRadius.circular(15)),
              //     // child: Image.asset('../assets/icons/filter.png'),
              //     child: ElevatedButton(
              //       onPressed: () {},
              //       child: Icon(
              //         Icons.filter_alt_rounded,
              //         color: Theme.of(context).backgroundColor,
              //       ),
              //     ),
              //     width: 50),
            ],
          )
        ],
      ),
    );
  }
}
