import 'dart:io';

import 'package:flutter/material.dart';

//  global color variable

// For backgrounds color pallet
const Color Bg1 = Color.fromARGB(255, 247, 239, 229); // Full opacity
const Color Bg2 = Color.fromARGB(255, 255, 255, 255); // Full opacity
const Color color3 = Color.fromARGB(255, 200, 161, 224); // Full opacity
const Color color4 = Color.fromARGB(255, 103, 65, 136); // Full opacity

//for texts
const Color Btext1 = Color.fromARGB(255, 0, 0, 0);

//for buttons
const Color But1 = Color.fromARGB(255, 255, 175, 78);
const Color But2 = Color.fromARGB(255, 252, 165, 59);

const Color specBut1 = Color.fromARGB(255, 52, 115, 252);
const Color specBut2 = Color.fromARGB(255, 91, 110, 255);

//icon colors
const Color ico1 = Color.fromARGB(255, 0, 0, 0);

//TextField Coors
const Color textfieldtext = Colors.black;
const Color textfieldPlaceholder = Colors.grey;

//dropdown color
const Color dropdowncol = Color.fromARGB(255, 255, 234, 181);
//button design Template

//button design for common buttons
final BoxDecoration myBoxDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [But1, But2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  borderRadius: BorderRadius.circular(30.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      spreadRadius: 2,
      blurRadius: 5,
      offset: Offset(0, 4), // Shadow position
    ),
  ],
);

// button design for special buttons

final BoxDecoration mySpecialBoxDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [specBut1, specBut2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  borderRadius: BorderRadius.circular(30.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      spreadRadius: 2,
      blurRadius: 5,
      offset: Offset(0, 4), // Shadow position
    ),
  ],
);
