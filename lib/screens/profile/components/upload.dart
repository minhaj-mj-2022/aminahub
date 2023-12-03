import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadForm extends StatefulWidget {
  static const String routeName = '/upload_form';

  const UploadForm({super.key});

  @override
  _UploadFormState createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationStateController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  String? selectedCategory;
  final List<String> categories = ['Property', 'Events', 'IT Training'];
  List<String> imageUrls = [];
  File? selectedImage;

  String generateUuid() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  double _uploadProgress = 0.0;

  Future<void> _pickImage() async {
    XFile? pickedImage =
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
    if (selectedImage == null) {
      return;
    }

    final String fileExtension =
        selectedImage!.path.split('.').last.toLowerCase();

    final storageReference =
        FirebaseStorage.instance.ref().child('images/$adsId.$fileExtension');

    final File imageFile = File(selectedImage!.path);

    final UploadTask uploadTask = storageReference.putFile(
      imageFile,
      SettableMetadata(contentType: 'image/$fileExtension'),
    );

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      double progress = snapshot.bytesTransferred / snapshot.totalBytes;
      setState(() {
        _uploadProgress = progress;
      });
    });

    await uploadTask;

    final String downloadURL = await storageReference.getDownloadURL();
    imageUrls.add(downloadURL);
  }

  void uploadData() async {
    if (areFieldsFilled()) {
      String adsId = generateUuid();
      String title = titleController.text;
      String contact = contactController.text;
      String descriptions = descriptionController.text;
      String price = priceController.text;
      String locationState = locationStateController.text;

      if (selectedCategory != null && selectedCategory!.isNotEmpty) {
        await _uploadImage(adsId);

        await FirebaseFirestore.instance.collection('ads').add({
          'ads_id': adsId,
          'title': title,
          'category': selectedCategory!,
          'images': imageUrls,
          'contact': contact,
          'description': descriptions,
          'location_state': locationState,
          'price': price,
        });

        imageUrls = [];
        setState(() {
          _uploadProgress = 0.0; // Reset progress after successful upload
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Upload successful'),
          ),
        );

        // Wait for 3 seconds and then reload the screen
        await Future.delayed(Duration(seconds: 3));

        // Reload the screen
        Navigator.of(context).pushReplacementNamed(UploadForm.routeName);
      } else {
        if (kDebugMode) {
          print('Please select a category.');
        }
      }
    }
  }

  bool areFieldsFilled() {
    if (titleController.text.isEmpty ||
        contactController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        locationStateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All text fields must be filled'),
        ),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Ads'),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              const SizedBox(height: 8.0),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Descriptions'),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: priceController,
                decoration:
                    const InputDecoration(labelText: 'Price (optional)'),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: locationStateController,
                decoration: const InputDecoration(labelText: 'Location State'),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: contactController,
                decoration: const InputDecoration(labelText: 'Contact'),
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
              LinearProgressIndicator(value: _uploadProgress),
              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  uploadData();
                },
                child: const Text('Upload'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
