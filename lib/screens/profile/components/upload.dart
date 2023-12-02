import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadForm extends StatefulWidget {
  static const String routeName = '/upload_form';

  const UploadForm({Key? key}) : super(key: key);

  @override
  _UploadFormState createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  final TextEditingController titleController = TextEditingController();
  String? selectedCategory;
  final List<String> categories = ['Category 1', 'Category 2', 'Category 3'];

  File? selectedImage;

  String generateUuid() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        selectedImage = File(pickedImage.path);
      } else {
        if (kDebugMode) {
          print('No image selected.');
        }
      }
    });
  }

  Future<void> _uploadImage(String adsId) async {
    if (selectedImage != null) {
      final storageReference =
          FirebaseStorage.instance.ref().child('images/$adsId.jpg');

      final File file = File(selectedImage!.path);

      await storageReference.putFile(file);

      final String downloadURL = await storageReference.getDownloadURL();

      FirebaseFirestore.instance.collection('ads').add({
        'ads_id': adsId,
        'title': titleController.text,
        'category': selectedCategory!,
        'image_url': downloadURL,
      });
    }
  }

  void uploadData() {
    String adsId = generateUuid();
    String title = titleController.text;

    if (selectedCategory != null && selectedCategory!.isNotEmpty) {
      _uploadImage(adsId);
    } else {
      if (kDebugMode) {
        print('Please select a category.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Ads'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 8.0),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
            ),
            Center(
              child: IconButton(
                iconSize: 150.0,
                onPressed: () {
                  _pickImage();
                },
                icon: const Icon(Icons.image),
              ),
            ),
            selectedImage != null
                ? Image.file(
                    File(selectedImage!.path),
                    height: 200.0,
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 15.0),
            ElevatedButton(
              onPressed: () {
                uploadData();
              },
              child: const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
