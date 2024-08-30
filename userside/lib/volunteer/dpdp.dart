import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DeliverProduDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const DeliverProduDetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final address = data['address'] ?? 'No address available';
    final name = data['name'] ?? 'No name available';
    final phoneNumber = data['phone_number'] ?? 'No phone number available';
    final productImage = data['product_image'] ?? '';
    final productcamImage = data['productcam_image'] ?? '';
    final productLatitude =
        data['product_latitude']?.toString() ?? 'No latitude';
    final productLongitude =
        data['product_longitude']?.toString() ?? 'No longitude';
    final productName = data['product_name'] ?? 'No product name available';
    final userLatitude = data['user_latitude']?.toString() ?? 'No latitude';
    final userLongitude = data['user_longitude']?.toString() ?? 'No longitude';

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (productImage.isNotEmpty)
              Image.network(productImage, fit: BoxFit.cover),
            if (productcamImage.isNotEmpty)
              Image.network(productcamImage, fit: BoxFit.cover),
            SizedBox(height: 10),
            Text('Address: $address', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Name: $name', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Phone Number: $phoneNumber', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Product Name: $productName', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            if (productLatitude.isNotEmpty && productLongitude.isNotEmpty)
              ElevatedButton(
                onPressed: () => _openMap(productLatitude, productLongitude),
                child: Text('Product Location'),
              ),
            SizedBox(height: 10),
            if (userLatitude.isNotEmpty && userLongitude.isNotEmpty)
              ElevatedButton(
                onPressed: () => _openMap(userLatitude, userLongitude),
                child: Text('User Location'),
              ),
          ],
        ),
      ),
    );
  }

  void _openMap(String latitude, String longitude) async {
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    await canLaunchUrlString(googleMapsUrl);
  }
}
