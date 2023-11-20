import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataFetchScreen extends StatelessWidget {
  static const String routeName = '/data_fetch';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Fetch'),
      ),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Map<String, dynamic>> data = snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Name: ${data[index]['name']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${data[index]['email']}'),
                      Text('Mobile: ${data[index]['mobile']}'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    List<Map<String, dynamic>> dataList = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('client').get();
      
      querySnapshot.docs.forEach((doc) {
        dataList.add({
          'name': doc['name'],
          'email': doc['email'],
          'mobile': doc['mobile'],
        });
      });

      return dataList;
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data: $e');
    }
  }
}
