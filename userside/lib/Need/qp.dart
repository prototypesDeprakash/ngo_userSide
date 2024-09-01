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
        addressController.text.isNotEmpty) {
      try {
        // Check location permission
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

        // Get current location
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        // Upload all details to Firestore
        await FirebaseFirestore.instance.collection('query').add({
          'queryname': quertext.text,
          'name': nameController.text,
          'phone': phoneController.text,
          'address': addressController.text,
          'latitude': position.latitude,
          'longitude': position.longitude,
        });

        // Clear the text fields
        quertext.clear();
        nameController.clear();
        phoneController.clear();
        addressController.clear();

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
            'Querry Page',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 19, 0, 233),
      ),
      body: Container(
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

        padding: EdgeInsets.all(15.0),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 30.0),
              Lottie.asset(
                "assets/animations/hold.json",
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 50,
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
              SizedBox(height: 20.0),
              Textfield(
                hinttext: 'Enter your Name',
                obsecuretext: false,
                i: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                controller: nameController,
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
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: postQuery,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
