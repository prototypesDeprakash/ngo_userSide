import 'package:userside/Textfield.dart';
import 'package:userside/source/registerpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Front());
  }
}

class Front extends StatefulWidget {
  Front({super.key});

  @override
  State<Front> createState() => _FrontState();
}

class _FrontState extends State<Front> {
  final username = TextEditingController();

  final password = TextEditingController();

  void p1() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: username.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      wrongpass1(e.code == '');
    }
    Navigator.of(context).pop();
  }

  wrongpass1(s) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('WRONG CREDENTIALS'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('LOGIN PAGE'),
        backgroundColor: Colors.amber,
      ),
      // backgroundColor: Colors.grey.gr,
      body: Column(
        children: [
          Align(alignment: Alignment.center),
          SizedBox(
            height: 60,
          ),
          Icon(
            Icons.lock,
            size: 100,
            color: Colors.amber,
          ),
          SizedBox(height: 40),
          Textfield(
            controller: username,
            hinttext: 'e-mail ',
            obsecuretext: false,
            i: Icon(Icons.email),
          ),
          SizedBox(height: 40),
          Textfield(
            controller: password,
            hinttext: 'password',
            obsecuretext: true,
            i: Icon(Icons.password),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: p1,
            child: Container(
              padding: EdgeInsets.all(25.0),
              margin: EdgeInsets.symmetric(horizontal: 90),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(30.0)),
              child: Center(
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 35),
          Row(
            children: [
              Text('      Not a member ? '),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Registerpage()));
                },
                child: Text(
                  'Register here',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
