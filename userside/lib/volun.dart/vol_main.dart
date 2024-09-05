import 'package:flutter/material.dart';
import 'package:userside/volun.dart/req_vol.dart';
import 'package:userside/volun.dart/vol_login.dart';

class VolMain extends StatelessWidget {
  const VolMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 440,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyWidget()));
            },
            child: Container(
              padding: EdgeInsets.all(25.0),
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Center(
                child: Text(
                  'REQUEST AS VOLUNTEER',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Front_vol_()));
            },
            child: Container(
              padding: EdgeInsets.all(25.0),
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
