import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/coupon.dart';

class EditCoupon extends StatefulWidget {
  Map<String, Vendor> vendors = {'Bhopal': Vendor.bhopal, 'Kanaka': Vendor.kanaka};

  Map<String, Meal> meal = {'Breakfast': Meal.breakfast, 'Lunch': Meal.lunch, 'Dinner': Meal.dinner};

  List<String> date = ['Today', 'Tomorrow', 'Day after tomorrow'];

  Coupon coupon;
  Function _editCoupon;
  int index;
  String selectedVendor = 'Bhopal';
  String selectedMeal = 'Breakfast';
  String selectedDate = 'Today';
  final _costController = TextEditingController();
  EditCoupon(this._editCoupon, this.index, this.coupon) {
    selectedVendor = vendors.inverse[coupon.vendor].toString();
    selectedMeal = meal.inverse[coupon.type].toString();
    //date
    if (DateFormat("YYYYMMDD").format(DateTime.now()) == DateFormat("YYYYMMDD").format(coupon.dov)) {
      selectedDate = date[0];
    } else if (DateFormat("YYYYMMDD").format(DateTime.now().add(Duration(days: 1))) == DateFormat("YYYYMMDD").format(coupon.dov)) {
      selectedDate = date[1];
    } else {
      selectedDate = date[2];
    }
    _costController.text = coupon.cost.toString();
  }

  @override
  State<EditCoupon> createState() => _EditCouponState();
}

class _EditCouponState extends State<EditCoupon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select Vendor'),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6.0, offset: Offset(0, 2))],
                    ),
                    child: DropdownButton(
                      focusColor: Theme.of(context).primaryColor,
                      iconEnabledColor: Theme.of(context).primaryColor,
                      items:
                          widget.vendors.keys.map((String items) {
                            return DropdownMenuItem(value: items, child: Padding(padding: const EdgeInsets.all(8.0), child: Text(items, textAlign: TextAlign.center)));
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          widget.selectedVendor = newValue!;
                        });
                      },
                      value: widget.selectedVendor,
                      dropdownColor: Theme.of(context).primaryColor,
                      style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor, fontFamily: 'OpenSans'),
                      // Down Arrow Icon
                      icon: Icon(Icons.keyboard_arrow_down, color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.black, height: 10),
              TextField(
                style: TextStyle(color: Theme.of(context).primaryColor),
                decoration: InputDecoration(labelText: 'Cost', focusColor: Theme.of(context).primaryColor),
                controller: widget._costController,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select Meal'),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6.0, offset: Offset(0, 2))],
                    ),
                    child: DropdownButton(
                      iconEnabledColor: Theme.of(context).primaryColor,

                      items:
                          widget.meal.keys.map((String items) {
                            return DropdownMenuItem(value: items, child: Padding(padding: const EdgeInsets.all(8.0), child: Text(items, textAlign: TextAlign.center)));
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          widget.selectedMeal = newValue!;
                        });
                      },
                      value: widget.selectedMeal,
                      dropdownColor: Theme.of(context).primaryColor,
                      style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.black, height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select Day'),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6.0, offset: Offset(0, 2))],
                    ),
                    child: DropdownButton(
                      iconEnabledColor: Theme.of(context).primaryColor,
                      items:
                          widget.date.map((String items) {
                            return DropdownMenuItem(value: items, child: Padding(padding: const EdgeInsets.all(8.0), child: Text(items, textAlign: TextAlign.center)));
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          widget.selectedDate = newValue!;
                        });
                      },
                      value: widget.selectedDate,
                      dropdownColor: Theme.of(context).primaryColor,
                      style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.black, height: 10),
              TextButton(
                onPressed: () {
                  // widget.addTx(
                  //     titleController.text,
                  //     double.parse(amountController.text),
                  //     categories[selectedCategory]);
                  widget._editCoupon(widget._costController.text, widget.selectedDate, widget.selectedMeal, widget.selectedVendor, widget.index);
                },
                child: Text('Edit Coupon', style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
        ),
        elevation: 5,
      ),
    );
  }
}
