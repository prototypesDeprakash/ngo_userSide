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
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: TextField(
        controller: controller,
        obscureText: obsecuretext,
        decoration: InputDecoration(
          icon: i,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
          ),
          hintText: hinttext,
        ),
      ),
    );
  }
}
