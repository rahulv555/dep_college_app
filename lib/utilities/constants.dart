import 'package:dep_college_app/utilities/colors.dart';
import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Color(greenColor),
  fontFamily: 'OpenSans',
);

final kHintTextStyleGreyed = TextStyle(
  color: Color(0xFFBDBDBD),
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Color(greenColor),
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFFF6F6F6),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
