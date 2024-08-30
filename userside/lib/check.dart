import 'package:userside/Need/itemslistp.dart';
import 'package:userside/source/auth_page.dart';
import 'package:userside/volunteer/main.dart';
import 'package:flutter/material.dart';

class Check extends StatelessWidget {
  Check({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Front(),
    );
  }
}

class Front extends StatelessWidget {
  const Front({super.key});

  @override
  Widget build(BuildContext context) {
    void need() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ItemListPage()));
    }

    void sell() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AuthPage()));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber,
      body: Column(
        children: [
          SizedBox(height: 220),
          Center(
            child: Icon(
              Icons.handshake,
              size: 140.0,
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Text(
            'DONATE APP',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 30.0,
          ),
          GestureDetector(
            onTap: need,
            child: Container(
              padding: EdgeInsets.all(25.0),
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Center(
                child: Text(
                  'NEEDED',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: sell,
            child: Container(
              padding: EdgeInsets.all(25.0),
              margin: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  'DONATE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Checkvol()));
            },
            child: Container(
              padding: EdgeInsets.all(25.0),
              margin: EdgeInsets.symmetric(
                horizontal: 25,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  'VOLUNTEER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
