import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final controller;
  final obsecuretext;
  final hinttext;
  final i;

  const Textfield(
      {super.key, this.controller, this.hinttext, this.obsecuretext, this.i});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.amber,
        controller: controller,
        obscureText: obsecuretext,
        decoration: InputDecoration(
            icon: i,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              
            ),
            hintText: hinttext,
            hintStyle: TextStyle(
              color: Colors.white,
            )
            // cursorWidth: 10.0,
            ),
      ),
    );
  }
}
