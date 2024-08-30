import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:userside/Volunteer/QueryDetailPage.dart';

class QueryPage extends StatefulWidget {
  const QueryPage({super.key});

  @override
  State<QueryPage> createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
  void _deleteQuery(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('query')
          .doc(documentId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Query deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete query: $e')),
      );
    }
  }

  void _navigateToDetailPage(Map<String, dynamic> data, String documentId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            QueryDetailPage(data: data, documentId: documentId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Query Data'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('query').snapshots(),
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
                  final latitude =
                      data['latitude']?.toString() ?? 'No latitude';
                  final longitude =
                      data['longitude']?.toString() ?? 'No longitude';
                  final name = data['name'] ?? 'No name available';
                  final phone = data['phone'] ?? 'No phone number available';
                  final queryName =
                      data['queryname'] ?? 'No query name available';

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Address: $address',
                              style: TextStyle(fontSize: 16)),
                          Text('Latitude: $latitude',
                              style: TextStyle(fontSize: 16)),
                          Text('Longitude: $longitude',
                              style: TextStyle(fontSize: 16)),
                          Text('Name: $name', style: TextStyle(fontSize: 16)),
                          Text('Phone: $phone', style: TextStyle(fontSize: 16)),
                          Text('Query Name: $queryName',
                              style: TextStyle(fontSize: 16)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () =>
                                    _navigateToDetailPage(data, documentId),
                                child: Text('View Details'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () => _deleteQuery(documentId),
                                child: Text('Completed'),
                              ),
                            ],
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
