import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:userside/Volunteer/Query.dart';
import 'package:userside/Volunteer/delevery.dart';
import 'package:userside/Volunteer/emergency.dart';

class Deliverypage extends StatelessWidget {
  const Deliverypage({super.key});

  void signout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    void del() {
      Navigator.push(
        context,
        (MaterialPageRoute(builder: (context) => DeliverProduPage())),
      );
    }

    void quer() {
      Navigator.push(
        context,
        (MaterialPageRoute(builder: (context) => QueryPage())),
      );
    }

    void emer() {
      Navigator.push(
        context,
        (MaterialPageRoute(builder: (context) => Emergency())),
      );
    }

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 150),
            Icon(Icons.logout, size: 100),
            SizedBox(height: 30),
            Text('Thanks for Donate', style: TextStyle(fontSize: 30.0)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: signout,
              child: Text('LOGOUT', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                textStyle: TextStyle(color: Colors.black, fontSize: 20),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('HELP PAGE'),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          GestureDetector(
            onTap: emer,
            child: Container(
              padding: EdgeInsets.all(25.0),
              margin: EdgeInsets.symmetric(horizontal: 90),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(30.0)),
              child: Row(
                children: [
                  Icon(Icons.bloodtype),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'EMERGENCY',
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: quer,
            child: Container(
              padding: EdgeInsets.all(25.0),
              margin: EdgeInsets.symmetric(horizontal: 90),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(30.0)),
              child: Row(
                children: [
                  Icon(Icons.query_builder),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'QUERY',
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: del,
            child: Container(
              padding: EdgeInsets.all(25.0),
              margin: EdgeInsets.symmetric(horizontal: 90),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(30.0)),
              child: Row(
                children: [
                  Icon(Icons.delivery_dining),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'DELIVERY',
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
