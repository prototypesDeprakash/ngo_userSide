import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Requestforvolunteer extends StatefulWidget {
  const Requestforvolunteer({super.key});

  @override
  State<Requestforvolunteer> createState() => _RequestforvolunteerState();
}

class _RequestforvolunteerState extends State<Requestforvolunteer> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController age = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request For Volunteer"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(30),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "NAME",
                      labelText: "NAME"),
                  validator: (val) {
                    if (val!.isEmpty || val == null) {
                      return "PLEASE FILL THIS FIELD";
                    }
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "EMAIL",
                      labelText: "EMAIL"),
                  validator: (val) {
                    if (val!.isEmpty || val == null) {
                      return "PLEASE FILL THIS FIELD";
                    }
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: phoneNumber,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "PHONE",
                      labelText: "PHONE"),
                  validator: (val) {
                    if (val!.isEmpty || val == null) {
                      return "PLEASE FILL THIS FIELD";
                    }
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: age,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "AGE",
                      labelText: "AGE"),
                  validator: (val) {
                    if (val!.isEmpty || val == null) {
                      return "PLEASE FILL THIS FIELD";
                    }
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print("Clicked");
                        requestForVolunteer(
                            name: name.text,
                            email: email.text,
                            phone: phoneNumber.text,
                            age: age.text);
                      }
                    },
                    child: Text("Submit"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> requestForVolunteer(
      {required String name,
      required String email,
      required String phone,
      required String age}) async {
    print(name);
    print(phone);
    print(email);
    print(age);
    await FirebaseFirestore.instance.collection("VOLUNTEER REQUEST").doc().set({
      'name': name,
      'email': email,
      'phoneNumBer': phone,
      'age': age
    }).whenComplete(() {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("UPDATED SUCCESSFULLY")));
    });
  }
}
