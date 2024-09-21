import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:userside/Need/itemslistp.dart';
import 'package:userside/source/auth_page.dart';
import 'package:userside/theme_global.dart';
import 'package:userside/volun.dart/vol_auth.dart';
import 'package:userside/volun.dart/vol_main.dart';
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Bg1, Bg2], // Your gradient colors here
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Container(
            //   child: Lottie.asset("assets/animations/particle.json",
            //       width: 420, height: 200),

            // ),
            SizedBox(height: 190),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Makes the container circular
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), // Shadow color
                      spreadRadius: 4, // Spread radius
                      blurRadius: 6, // Blur radius
                      offset: Offset(0, 2), // Shadow position (x, y)
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/logomain.png',
                    height: 160.0,
                    width: 160.0,
                    fit: BoxFit
                        .cover, // Ensures the image fits within the circular container
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'SANVI',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'airel',
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              ' "Giving Made Simple, Impact Made Big"',
              style: TextStyle(
                fontSize: 17,
                fontStyle: FontStyle.italic,
                fontFamily: 'airel',
                color: Btext1,
              ),
            ),
            //first gap after the logo and title
            SizedBox(height: 60.0),

            //button - 1
            GestureDetector(
              onTap: need,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration:
                    myBoxDecoration, //myBoxDecoration -> code for this is written in theme_global
                child: Center(
                  child: Text(
                    'Require Aid',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2, // Adds spacing between letters
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 25), // for gap

            // button - 2

            GestureDetector(
              onTap: sell,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: myBoxDecoration,
                child: Center(
                  child: Text(
                    'Donate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2, // Adds spacing between letters
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 25), //for gap

            //button -3

            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => vol_auth()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: mySpecialBoxDecoration,
                child: Center(
                  child: Text(
                    'Volunteer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2, // Adds spacing between letters
                    ),
                  ),
                ),
              ),
            ),

            //need another button or wanna add something? - add here !
          ],
        ),
      ),
    );
  }
}
