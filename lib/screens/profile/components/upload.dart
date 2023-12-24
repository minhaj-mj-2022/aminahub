import 'package:aminahub/imports.dart';
import 'dart:io';
import 'dart:async';

class UploadForm extends StatefulWidget {
  static const String routeName = '/upload_form';

  const UploadForm({Key? key}) : super(key: key);

  @override
  _UploadFormState createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationStateController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  String? originalPoster = FirebaseAuth.instance.currentUser!.email;
  String? selectedCategory;
  final List<String> categories = [
    'Property',
    'Events',
    'IT Training',
    'Rentals',
    'Services',
    'travel',
    'buySell',
    'homeservices',
    'lawyer',
    'roommates'
  ];
  List<String> imageUrls = [];
  List<File> selectedImages = [];

  String generateUuid() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  double _uploadProgress = 0.0;

  Future<void> _pickImages() async {
    List<XFile>? pickedImages = await ImagePicker().pickMultiImage();

    setState(() {
      if (pickedImages.isNotEmpty) {
        selectedImages = pickedImages.map((pickedImage) {
          return File(pickedImage.path);
        }).toList();
      } else {
        if (kDebugMode) {
          print('No images selected.');
        }
      }
    });
  }

  Future<void> _uploadImages(String adsId) async {
    for (File selectedImage in selectedImages) {
      final String fileExtension =
          selectedImage.path.split('.').last.toLowerCase();

      final storageReference = FirebaseStorage.instance
          .ref()
          .child('images/$adsId/${generateUuid()}.$fileExtension');

      final File imageFile = File(selectedImage.path);

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
        await _uploadImages(adsId);

        await FirebaseFirestore.instance.collection('ads').add({
          'ads_id': adsId,
          'title': title,
          'category': selectedCategory!,
          'images': imageUrls,
          'contact': contact,
          'description': descriptions,
          'location_state': locationState,
          'price': price,
          'op': originalPoster,
        });

        imageUrls = [];
        setState(() {
          _uploadProgress = 0.0;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Upload successful'),
          ),
        );
        await Future.delayed(Duration(seconds: 3));

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
                  iconSize: 50.0,
                  onPressed: () {
                    _pickImages();
                  },
                  icon: const Icon(Icons.image),
                ),
              ),
              selectedImages.isNotEmpty
                  ? Column(
                      children: selectedImages.map((selectedImage) {
                        return Image.file(
                          selectedImage,
                          height: 200.0,
                        );
                      }).toList(),
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
