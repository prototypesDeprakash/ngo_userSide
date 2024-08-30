import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:userside/Volunteer/dpdp.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliverProduPage extends StatefulWidget {
  const DeliverProduPage({super.key});

  @override
  State<DeliverProduPage> createState() => _DeliverProduPageState();
}

class _DeliverProduPageState extends State<DeliverProduPage> {
  void _openDirections(String userLatitude, String userLongitude,
      String productLatitude, String productLongitude) async {
    final String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&origin=$userLatitude,$userLongitude&destination=$productLatitude,$productLongitude';
    await launchUrl(Uri.parse(googleMapsUrl));
  }

  void _deleteItem(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('deliverprodu')
          .doc(documentId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete item: $e')),
      );
    }
  }

  void _viewDetails(Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeliverProduDetailPage(data: data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deliver Product Data'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('deliverprodu').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData) {
              final documents = snapshot.data!.docs;

              if (documents.isEmpty) {
                return Center(child: Text('No data found.'));
              }

              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final data = documents[index].data() as Map<String, dynamic>;
                  final documentId = documents[index].id;

                  final address = data['address'] ?? 'No address available';
                  final name = data['name'] ?? 'No name available';
                  final phoneNumber =
                      data['phone_number'] ?? 'No phone number available';
                  final productImage = data['product_image'] ?? '';
                  final productcamImage = data['productcam_image'] ?? '';
                  final productLatitude =
                      data['product_latitude']?.toString() ?? '';
                  final productLongitude =
                      data['product_longitude']?.toString() ?? '';
                  final productName =
                      data['product_name'] ?? 'No product name available';
                  final userLatitude = data['user_latitude']?.toString() ?? '';
                  final userLongitude =
                      data['user_longitude']?.toString() ?? '';

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (productImage.isNotEmpty)
                            Image.network(productImage, fit: BoxFit.cover),
                          if (productcamImage.isNotEmpty)
                            Image.network(productcamImage, fit: BoxFit.cover),
                          Text('Address: $address',
                              style: TextStyle(fontSize: 16)),
                          Text('Name: $name', style: TextStyle(fontSize: 16)),
                          Text('Phone Number: $phoneNumber',
                              style: TextStyle(fontSize: 16)),
                          Text('Product Name: $productName',
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 10),
                          if (productLatitude.isNotEmpty &&
                              productLongitude.isNotEmpty &&
                              userLatitude.isNotEmpty &&
                              userLongitude.isNotEmpty)
                            ElevatedButton(
                              onPressed: () => _openDirections(
                                  userLatitude,
                                  userLongitude,
                                  productLatitude,
                                  productLongitude),
                              child: Text('Get Directions'),
                            ),
                          ElevatedButton(
                            onPressed: () => _viewDetails(data),
                            child: Text('View Details'),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () => _deleteItem(documentId),
                            child: Text('Completed'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            return Center(child: Text('No data found.'));
          },
        ),
      ),
    );
  }
}
