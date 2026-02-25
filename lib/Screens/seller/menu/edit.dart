import 'package:dep_college_app/models/fooditem.dart';
import 'package:flutter/material.dart';

class EditItem extends StatefulWidget {
  String category;
  int i;
  Function _editItem;
  FoodItem item;
  Iterable<String> categories;
  String _selectedCategory = "";
  String _selectedCost = "";
  String _selectedName = "";
  final _itemnamecontroller = TextEditingController();
  final _pricecontroller = TextEditingController();
  String _originalCategory = "";

  EditItem(this.item, this.category, this.i, this.categories, this._editItem) {
    _selectedCategory = this.category;
    _itemnamecontroller.text = item.name;
    _pricecontroller.text = item.price.toString();
    this._originalCategory = this.category;
  }

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select Category'),
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
                          widget.categories.map((String items) {
                            return DropdownMenuItem(value: items, child: Padding(padding: const EdgeInsets.all(8.0), child: Text(items, textAlign: TextAlign.center)));
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          widget._selectedCategory = newValue!;
                        });
                      },
                      value: widget._selectedCategory,
                      dropdownColor: Theme.of(context).primaryColor,
                      style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor, fontFamily: 'OpenSans'),
                      // Down Arrow Icon
                      icon: Icon(Icons.keyboard_arrow_down, color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  TextField(
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(labelText: 'Item Name', focusColor: Theme.of(context).primaryColor),
                    controller: widget._itemnamecontroller,
                  ),
                  SizedBox(height: 10),
                ],
              ),
              Column(
                children: [
                  TextField(
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(labelText: 'Price', focusColor: Theme.of(context).primaryColor),
                    controller: widget._pricecontroller,
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // widget.addTx(
                      //     titleController.text,
                      //     double.parse(amountController.text),
                      //     categories[selectedCategory]);
                      print("lmao");
                      print(widget._pricecontroller.text);
                      widget._editItem(widget._selectedCategory, widget.i, widget._selectedName, widget._pricecontroller.text, widget._originalCategory);
                    },
                    child: Text('Edit Item', style: TextStyle(color: Colors.green)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
