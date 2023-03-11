import 'package:flutter/material.dart';

import '../../models/coupon.dart';
import '../../utilities/constants.dart';

class SellCoupon extends StatefulWidget {
  Function _addCoupon;
  SellCoupon(this._addCoupon);

  @override
  State<SellCoupon> createState() => _SellCouponState();
}

class _SellCouponState extends State<SellCoupon> {
  final _costController = TextEditingController();

  Map<String, Vendor> vendors = {
    'Bhopal': Vendor.bhopal,
    'Kanaka': Vendor.kanaka,
  };

  Map<String, Meal> meal = {
    'Breakfast': Meal.breakfast,
    'Lunch': Meal.lunch,
    'Dinner': Meal.dinner,
  };

  List<String> date = ['Today', 'Tomorrow', 'Day after tomorrow'];

  String selectedVendor = 'Bhopal';
  String selectedMeal = 'Breakfast';
  String selectedDate = 'Today';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Card(
        color: Theme.of(context).backgroundColor,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Vendor',
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: DropdownButton(
                      focusColor: Theme.of(context).primaryColor,
                      iconEnabledColor: Theme.of(context).primaryColor,
                      items: vendors.keys.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(items, textAlign: TextAlign.center),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedVendor = newValue!;
                        });
                      },
                      value: selectedVendor,
                      dropdownColor: Theme.of(context).primaryColor,
                      style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                          fontFamily: 'OpenSans'),
                      // Down Arrow Icon
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
                height: 10,
              ),
              TextField(
                style: TextStyle(color: Theme.of(context).primaryColor),
                decoration: InputDecoration(
                    labelText: 'Cost',
                    focusColor: Theme.of(context).primaryColor),
                controller: _costController,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Meal',
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: DropdownButton(
                      iconEnabledColor: Theme.of(context).primaryColor,

                      items: meal.keys.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(items, textAlign: TextAlign.center),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedMeal = newValue!;
                        });
                      },
                      value: selectedMeal,
                      dropdownColor: Theme.of(context).primaryColor,
                      style: const TextStyle(
                          color: Colors.white, fontFamily: 'OpenSans'),
                      // Down Arrow Icon
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Day',
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: DropdownButton(
                      iconEnabledColor: Theme.of(context).primaryColor,
                      items: date.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(items, textAlign: TextAlign.center),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDate = newValue!;
                        });
                      },
                      value: selectedDate,
                      dropdownColor: Theme.of(context).primaryColor,
                      style: const TextStyle(
                          color: Colors.white, fontFamily: 'OpenSans'),
                      // Down Arrow Icon
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  // widget.addTx(
                  //     titleController.text,
                  //     double.parse(amountController.text),
                  //     categories[selectedCategory]);
                  widget._addCoupon(_costController.text, selectedDate,
                      selectedMeal, selectedVendor);
                  
                },
                child: Text(
                  'Add Coupon',
                  style: TextStyle(color: Colors.green),
                ),
              )
            ],
          ),
        ),
        elevation: 5,
      ),
    );
  }
}
