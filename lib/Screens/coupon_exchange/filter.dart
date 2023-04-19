import 'package:flutter/material.dart';

class FilterCoupons extends StatefulWidget {
  Function _filterCoupons;
  FilterCoupons(this._filterCoupons);

  @override
  State<FilterCoupons> createState() => _FilterCouponsState();
}

class _FilterCouponsState extends State<FilterCoupons> {
  List<bool> _selectedVendors = [false, false];
  List<bool> _selectedtypes = [false, false, false, false];
  List<bool> _selectedPricerange = [false, false, false];

  List<String> vendors = ['Bhopal', 'Kanaka'];
  List<String> types = ['Breakfast', 'Lunch', 'Dinner', 'Full Day'];
  List<String> price = ['<Rs.40', 'Rs.40-60', '>Rs.60'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Filter'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Vendor',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  )),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return Card(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(vendors[index]),
                      ),
                      Checkbox(
                          value: _selectedVendors[index],
                          onChanged: (bool? value) {
                            print(value);
                            setState(() {
                              _selectedVendors[index] = value!;
                            });
                          })
                    ],
                  ));
                },
                itemCount: vendors.length,
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Meal',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  )),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return Card(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(types[index]),
                      ),
                      Checkbox(
                          value: _selectedtypes[index],
                          onChanged: (bool? value) {
                            print(value);
                            setState(() {
                              _selectedtypes[index] = value!;
                            });
                          })
                    ],
                  ));
                },
                itemCount: types.length,
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Price',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  )),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return Card(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(price[index]),
                      ),
                      Checkbox(
                          value: _selectedPricerange[index],
                          onChanged: (bool? value) {
                            print(value);
                            setState(() {
                              _selectedPricerange[index] = value!;
                            });
                          })
                    ],
                  ));
                },
                itemCount: price.length,
              ),
            ],
          ),
        ));
  }
}
