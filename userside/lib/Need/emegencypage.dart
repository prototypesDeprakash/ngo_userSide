import 'package:lottie/lottie.dart';
import 'package:userside/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

class emergencypage extends StatefulWidget {
  const emergencypage({super.key});

  @override
  _emergencypageState createState() => _emergencypageState();
}

class _emergencypageState extends State<emergencypage> {
  final TextEditingController problem = TextEditingController();
  final TextEditingController dicripti = TextEditingController();
  File? _image;
  File? _image1;
  Position? _currentPosition;

  Future<void> imagegal() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> imagecam() async {
    final pickedFile1 =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile1 != null) {
      setState(() {
        _image1 = File(pickedFile1.path);
      });
    }
  }

  Future<void> _getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permissions are permanently denied')),
      );
      //return;
    }

    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location permissions are denied')),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Location obtained')),
    );
  }

  Future<void> uploadData() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        });
    if (_image != null &&
        problem.text.isNotEmpty &&
        dicripti.text.isNotEmpty &&
        _image1 != null &&
        _currentPosition != null) {
      try {
        String fileName =
            '${DateTime.now().millisecondsSinceEpoch}_gallery.png';
        Reference storageReferenceGallery =
            FirebaseStorage.instance.ref().child('emergency_images/$fileName');
        UploadTask uploadTaskGallery = storageReferenceGallery.putFile(_image!);
        await uploadTaskGallery;

        String imageUrl = await storageReferenceGallery.getDownloadURL();

        String fileNameCam =
            '${DateTime.now().millisecondsSinceEpoch}_camera.png';
        Reference storageReferenceCamera = FirebaseStorage.instance
            .ref()
            .child('emergency_images/$fileNameCam');
        UploadTask uploadTaskCamera = storageReferenceCamera.putFile(_image1!);
        await uploadTaskCamera;

        String imageUrlcam = await storageReferenceCamera.getDownloadURL();

        await FirebaseFirestore.instance.collection('emergency').add({
          'happend': problem.text,
          'detail': dicripti.text,
          'image': imageUrl,
          'imagecam': imageUrlcam,
          'latitude': _currentPosition!.latitude,
          'longitude': _currentPosition!.longitude,
        });

        problem.clear();
        dicripti.clear();
        setState(() {
          _image = null;
          _image1 = null;
          _currentPosition = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Emergency data uploaded successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload data: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Please fill all fields, pick an image, and obtain location'),
        ),
      );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
            child: Text(
          'Emergency',
          style: TextStyle(
            color: Colors.white,
          ),
        )),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 19, 0, 233),
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

          child: Column(
            children: [
              //vector animation
              Lottie.asset(
                "assets/animations/emergency3.json",
                width: 150,
                height: 150,
              ),

              // vector ends here
              SizedBox(height: 10),
              Textfield(
                hinttext: 'Problem',
                controller: problem,
                obsecuretext: false,
                i: Icon(
                  Icons.report_problem,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              Textfield(
                hinttext: 'Problem Description',
                controller: dicripti,
                obsecuretext: false,
                i: Icon(
                  Icons.description,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),

              //button 1
              GestureDetector(
                onTap: imagegal,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 19, 0, 233),
                        Color.fromARGB(255, 141, 139, 255)
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
                  child: Row(
                    //animation
                    children: [
                      _image == null
                          ? Lottie.asset("assets/animations/select.json",
                              width: 50, height: 50)
                          : Lottie.asset("assets/animations/done2.json",
                              width: 50, height: 50),

                      //animation ends
                      //space after animation
                      SizedBox(
                        width: 15,
                      ),

                      Center(
                        child: Text(
                          _image == null ? 'Select from galary' : 'selected',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //button 1 ends here
              SizedBox(height: 20.0),
              // button 2 starts here

              GestureDetector(
                onTap: imagecam,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 19, 0, 233),
                        Color.fromARGB(255, 141, 139, 255)
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
                  child: Row(
                    //animation
                    children: [
                      _image1 == null
                          ? Lottie.asset("assets/animations/camera2.json",
                              width: 50, height: 50)
                          : Lottie.asset("assets/animations/done2.json",
                              width: 50, height: 50),

                      //animation ends
                      //space after animation
                      SizedBox(
                        width: 15,
                      ),

                      Center(
                        child: Text(
                          _image1 == null ? 'Open Camera' : 'Selected',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // button 2 hends here
              SizedBox(height: 20.0),
              //button 3 starts

              GestureDetector(
                onTap: _getLocation,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 19, 0, 233),
                        Color.fromARGB(255, 141, 139, 255)
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
                  child: Row(
                    //animation
                    children: [
                      _currentPosition == null
                          ? Lottie.asset("assets/animations/location.json",
                              width: 50, height: 50)
                          : Lottie.asset("assets/animations/done2.json",
                              width: 50, height: 50),

                      //animation ends
                      //space after animation
                      SizedBox(
                        width: 15,
                      ),

                      Center(
                        child: Text(
                          _currentPosition == null
                              ? 'Get Location'
                              : 'Location Obtained',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // button3 ends

              SizedBox(height: 40.0),
              GestureDetector(
                onTap: uploadData,
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
                    "Submit",
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
              SizedBox(
                height: 45,
              )
            ],
          ),
        ),
      ),
    );
  }
}
