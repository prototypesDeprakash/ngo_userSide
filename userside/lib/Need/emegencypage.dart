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
        // Upload gallery image to Firebase Storage
        String fileName =
            '${DateTime.now().millisecondsSinceEpoch}_gallery.png';
        Reference storageReferenceGallery =
            FirebaseStorage.instance.ref().child('emergency_images/$fileName');
        UploadTask uploadTaskGallery = storageReferenceGallery.putFile(_image!);
        await uploadTaskGallery;

        // Get gallery image URL
        String imageUrl = await storageReferenceGallery.getDownloadURL();

        // Upload camera image to Firebase Storage
        String fileNameCam =
            '${DateTime.now().millisecondsSinceEpoch}_camera.png';
        Reference storageReferenceCamera = FirebaseStorage.instance
            .ref()
            .child('emergency_images/$fileNameCam');
        UploadTask uploadTaskCamera = storageReferenceCamera.putFile(_image1!);
        await uploadTaskCamera;

        // Get camera image URL
        String imageUrlcam = await storageReferenceCamera.getDownloadURL();

        // Upload details to Firestore
        await FirebaseFirestore.instance.collection('emergency').add({
          'happend': problem.text,
          'detail': dicripti.text,
          'image': imageUrl,
          'imagecam': imageUrlcam,
          'latitude': _currentPosition!.latitude,
          'longitude': _currentPosition!.longitude,
        });

        // Clear the fields
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
      appBar: AppBar(
        title: Text('EMERGENCY'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Textfield(
              hinttext: 'PROBLEM',
              controller: problem,
              obsecuretext: false,
              i: Icon(Icons.report_problem),
            ),
            SizedBox(height: 40),
            Textfield(
              hinttext: 'PROBLEM DESCRIPTION',
              controller: dicripti,
              obsecuretext: false,
              i: Icon(Icons.description),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: imagegal,
              child: Container(
                padding: EdgeInsets.all(25.0),
                margin: EdgeInsets.symmetric(horizontal: 90),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30.0)),
                child: Center(
                  child: Text(
                    _image == null
                        ? 'PICK IMAGE FROM GALLERY'
                        : 'GALLERY IMAGE SELECTED',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: imagecam,
              child: Container(
                padding: EdgeInsets.all(25.0),
                margin: EdgeInsets.symmetric(horizontal: 90),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30.0)),
                child: Center(
                  child: Text(
                    _image1 == null
                        ? 'PICK IMAGE FROM CAMERA'
                        : 'CAMERA IMAGE SELECTED',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: _getLocation,
              child: Container(
                padding: EdgeInsets.all(25.0),
                margin: EdgeInsets.symmetric(horizontal: 90),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30.0)),
                child: Center(
                  child: Text(
                    _currentPosition == null
                        ? 'GET LOCATION'
                        : 'LOCATION OBTAINED',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.0),
            GestureDetector(
              onTap: uploadData,
              child: Container(
                padding: EdgeInsets.all(25.0),
                margin: EdgeInsets.symmetric(horizontal: 90),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30.0)),
                child: Center(
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
