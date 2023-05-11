import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dep_college_app/Screens/home.dart';
import 'package:dep_college_app/utilities/constants.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:dep_college_app/Controller/skills.dart';
import 'package:dep_college_app/utilities/Skill.dart';

class Details extends StatefulWidget {
  final String _email;
  final String _password;

  Details(this._email, this._password);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  TextEditingController _date = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _phonenumber = TextEditingController();

  String dropdownvalue = 'Item 1';

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  Widget _buildTF(String x, String y, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          x,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              //contentPadding: EdgeInsets.only(top: 14.0),
              hintText: y,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGradYear() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Enter Your Graduation Year',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _date,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Expected Graduation Year',
              hintStyle: kHintTextStyle,
            ),
            //onTap: () async {
            // DateTime? pickedDate = await showDatePicker(
            //   context: context,
            //   initialDate: DateTime.now(),
            //   firstDate: DateTime(DateTime.now().year - 100, 1),
            //   lastDate: DateTime(DateTime.now().year + 100, 1),
            // );
            // if (pickedDate != null) {
            //   setState(() {
            //     _date.text = pickedDate.year.toString();
            //   });
            // }
            //}
          ),
        ),
      ],
    );
  }

  bool phoneNumberValidator(String s) {
    if (s == null) {
      return false;
    }
    if (double.tryParse(s) == null) return false;
    if (double.tryParse(s) != null && (double.parse(s) < 1e9 || double.parse(s) >= 1e10)) return false;
    return true;
  }

  bool textValidator(String s) {
    if (s == null) {
      return false;
    }
    return !(double.tryParse(s) != null);
  }

  bool pos = true;
  bool error = false;
  Widget _buildSubmitButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          print('submit Button Pressed');
          if (_name.text.isEmpty || dropdownvalue.isEmpty || _date.text.isEmpty || phoneNumberValidator(_phonenumber.text) == false || textValidator(_name.text) == false) {
            pos = false;
          } else
            pos = true;
          print(pos);
          if (pos) {
            setState(() {
              error = false;
            });
            FirebaseAuth.instance.createUserWithEmailAndPassword(email: widget._email, password: widget._password).then((value) async {
              print("Created new account");
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .set({})
                  .then((value) => print('Created user ${FirebaseAuth.instance.currentUser?.uid}'))
                  .catchError((error) => print(error));
              print("Created new account again");

              await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).update({
                "Name": _name.text,
                "Phonenumber": _phonenumber.text,
                "Gradyear": int.parse(_date.text),
                "Balance": double.parse('0'),
                "outlet": false,
              }).then((value) {
                print("Uers data added");
                //  pos=0;
                var _currentUser;
                FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get().then((DocumentSnapshot doc) {
                  if (doc.exists) {
                    _currentUser = doc.data();

                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(currentUser: _currentUser)));
                    print(_currentUser);

                    // print(_userEvents);
                  } else {
                    print('Document does not exist on the database');
                  }
                });
              });
            }).onError((error, stackTrace) {
              print("Error ${error.toString()}");
            });
            print(_name.text);
            print(_phonenumber.text);
            print(dropdownvalue);

            print(int.parse(_date.text));

            // print("here");
            // List<String> skills = [];
            // for (var i = 0; i < skillData.length; i++) {
            //   print(skillData[i].skillname);
            //   skills.add(skillData[i].skillname);
            //   print(skills[i]);
            // }
            print('here');
            print(pos);
          } else {
            setState(() {
              error = true;
            });
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        child: Text(
          'SUBMIT',
          style: TextStyle(
            color: Theme.of(context).backgroundColor,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  // List<SkillModel> skillData = [];
  // Widget _buildMultiSelect() {
  //   return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Text(
  //           'Skills',
  //           style: kLabelStyle,
  //         ),
  //         SizedBox(height: 10.0),
  //         Container(
  //           alignment: Alignment.centerLeft,
  //           decoration: kBoxDecorationStyle,
  //           // height: 170.0,
  //           child: GetBuilder<AppDataController>(
  //             builder: (controller) {
  //               return Padding(
  //                 padding: const EdgeInsets.all(10.0),
  //                 child: MultiSelectDialogField(
  //                   dialogHeight: 200,
  //                   items: controller.dropDownData,
  //                   title: const Text(
  //                     "Select skills",
  //                     style: TextStyle(
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                   selectedColor: Colors.blue,
  //                   decoration: BoxDecoration(
  //                     color: Colors.blueAccent,
  //                     borderRadius: const BorderRadius.all(Radius.circular(30)),
  //                   ),
  //                   buttonIcon: const Icon(
  //                     Icons.arrow_drop_down,
  //                     color: Colors.white,
  //                   ),
  //                   buttonText: const Text(
  //                     "Select your strong skills",
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontFamily: 'OpenSans',
  //                     ),
  //                   ),
  //                   onConfirm: (results) {
  //                     //skillData = [];
  //                     for (var i = 0; i < results.length; i++) {
  //                       SkillModel data = results[i] as SkillModel;
  //                       print(data.skillname);
  //                       print(data.skillid);
  //                       skillData.add(data);
  //                     }
  //                     //skillData=results;
  //                     print(" here data $skillData");
  //                   },
  //                 ),
  //               );
  //             },
  //           ),
  //         )
  //       ]);
  // }

  final AppDataController controller = Get.put(AppDataController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getSkillData();
    });
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Theme.of(context).backgroundColor, Theme.of(context).backgroundColor, Theme.of(context).backgroundColor, Theme.of(context).backgroundColor],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Fill Your Details',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildTF('Name', 'Enter your Full Name', _name),
                      SizedBox(height: 30.0),
                      _buildTF('Phone Number', 'Enter your Phone Number', _phonenumber),
                      SizedBox(height: 30.0),

                      //_buildGradYear(),
                      _buildTF("Graduation Year", "Enter your Graduation Year", _date),
                      SizedBox(height: 30.0),

                      _buildSubmitButton(),
                      SizedBox(height: 30.0),
                      Visibility(
                        visible: error,
                        child: Text('Please fill all the details properly',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                            )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
