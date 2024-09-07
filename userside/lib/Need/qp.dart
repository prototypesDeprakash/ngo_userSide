import 'package:lottie/lottie.dart';
import 'package:userside/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class qpage extends StatefulWidget {
  const qpage({super.key});

  @override
  State<qpage> createState() => _qpageState();
}

class _qpageState extends State<qpage> {
  final TextEditingController quertext = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController discription = TextEditingController();
  String options = 'food';
  var items = {
    'food',
    'cloth',
    'medicine',
    'education',
  };

  Future<void> postQuery() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        });
    if (quertext.text.isNotEmpty &&
            nameController.text.isNotEmpty &&
            phoneController.text.isNotEmpty &&
            addressController.text.isNotEmpty ||
        discription.text.isNotEmpty) {
      try {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }

        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Location permission is required')),
          );
          return;
        }

        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        await FirebaseFirestore.instance
            .collection('query')
            .add({
          'queryname': quertext.text,
          'name': nameController.text,
          'phone': phoneController.text,
          'address': addressController.text,
          'latitude': position.latitude,
          'longitude': position.longitude,
          'discription': discription.text,
          'options': options,
        });

        quertext.clear();
        nameController.clear();
        phoneController.clear();
        addressController.clear();
        discription.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Details posted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to post details: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'What\'s your need ',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 19, 0, 233),
      ),
      body: SingleChildScrollView(
        child: Container(
          //background gradient
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 19, 0, 233),
                Color.fromARGB(255, 141, 139, 255)
              ], // Your gradient colors here
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),

          padding: EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              children: [
                Container(
                  child: Lottie.asset(
                    "assets/animations/request_need.json",
                    width: 300,
                    height: 300,
                  ),
                  width: 250,
                  height: 250,
                ),
                Textfield(
                  hinttext: 'Enter your Name',
                  obsecuretext: false,
                  i: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  controller: nameController,
                ),
                SizedBox(
                  height: 20,
                ),
                Textfield(
                  hinttext: 'Enter the Query',
                  obsecuretext: false,
                  i: Icon(
                    Icons.type_specimen,
                    color: Colors.white,
                  ),
                  controller: quertext,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    DropdownButton(
                        dropdownColor: Colors.purple,
                        style: TextStyle(color: Colors.white),
                        value: options,
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.white,
                        ),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                              value: items, child: Text(items));
                        }).toList(),
                        onChanged: (String? newvalue) {
                          setState(() {
                            options = newvalue!;
                          });
                        }),
                  ],
                ),
                SizedBox(height: 20.0),
                Textfield(
                  hinttext: 'Enter the Query Discription ',
                  obsecuretext: false,
                  i: Icon(
                    Icons.type_specimen,
                    color: Colors.white,
                  ),
                  controller: discription,
                ),
                SizedBox(height: 20.0),
                Textfield(
                  hinttext: 'Enter your Phone Number',
                  obsecuretext: false,
                  i: Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  controller: phoneController,
                ),
                SizedBox(height: 20.0),
                Textfield(
                  hinttext: 'Enter your Address',
                  obsecuretext: false,
                  i: Icon(
                    Icons.location_city,
                    color: Colors.white,
                  ),
                  controller: addressController,
                ),
                SizedBox(height: 70.0),
                GestureDetector(
                  onTap: postQuery,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 115, 0, 255),
                          Color.fromARGB(255, 190, 111, 255)
                        ],
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
                    ),
                    child: Center(
                        child: Text(
                      "Send",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2, // Adds spacing between letters
                      ),
                    )),
                    width: 200,
                    height: 50,
                  ),
                ),
                SizedBox(height: 90.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
