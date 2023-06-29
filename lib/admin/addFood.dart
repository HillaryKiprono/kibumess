// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class AddFood extends StatefulWidget {
//   @override
//   _AddFoodState createState() => _AddFoodState();
// }
//
// class _AddFoodState extends State<AddFood> {
//   XFile? _selectedImage;
//   final _foodNameController = TextEditingController();
//   final _foodDescriptionController = TextEditingController();
//   final _foodPriceController = TextEditingController();
//   final _database = FirebaseDatabase.instance.reference();
//
//   Future<void> _pickImage() async {
//     final imagePicker = ImagePicker();
//     final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = pickedImage;
//       });
//     }
//   }
//
//   Future<void> _addFood() async {
//     final String foodName = _foodNameController.text.trim();
//     final String foodDescription = _foodDescriptionController.text.trim();
//     final String foodPrice = _foodPriceController.text.trim();
//
//     if (foodName.isEmpty || foodDescription.isEmpty || foodPrice.isEmpty) {
//       // Display an error message if any of the fields are empty
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Error"),
//             content: Text("Please fill in all the fields."),
//             actions: [
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//       return;
//     }
//
//     if (_selectedImage == null) {
//       // Display an error message if no image is selected
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Error"),
//             content: Text("Please select a food image."),
//             actions: [
//               ElevatedButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//       return;
//     }
//
//     // Upload the image to Firebase Storage and get the download URL
//     final File imageFile = File(_selectedImage!.path);
//     final String imagePath = "food_images/${DateTime.now().millisecondsSinceEpoch}.jpg";
//     final Reference storageReference = FirebaseStorage.instance.ref().child(imagePath);
//     final UploadTask uploadTask = storageReference.putFile(imageFile);
//     final TaskSnapshot downloadTask = await uploadTask.whenComplete(() {});
//     final String imageUrl = await downloadTask.ref.getDownloadURL();
//
//     // Save the food item to Firebase Realtime Database
//     final DatabaseReference foodRef = _database.child("foods").push();
//     final Map<String, dynamic> foodData = {
//       "name": foodName,
//       "description": foodDescription,
//       "price": foodPrice,
//       "image_url": imageUrl,
//     };
//     await foodRef.set(foodData);
//
//     // Clear the input fields and selected image
//     _foodNameController.clear();
//     _foodDescriptionController.clear();
//     _foodPriceController.clear();
//     setState(() {
//       _selectedImage = null;
//     });
//
//     // Display a success message
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Success"),
//           content: Text("Food item added successfully."),
//           actions: [
//             ElevatedButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _foodNameController.dispose();
//     _foodDescriptionController.dispose();
//     _foodPriceController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add New Food"),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.grey,
//                   ),
//                   width: 350,
//                   height: 200,
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: InkWell(
//                           onTap: _pickImage,
//                           child: _selectedImage != null
//                               ? Image.file(
//                             File(_selectedImage!.path),
//                             fit: BoxFit.cover,
//                           )
//                               : const Icon(
//                             Icons.camera_alt_sharp,
//                             size: 70,
//                           ),
//                         ),
//                       ),
//                       const Text("Click the camera to select food Image")
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: _foodNameController,
//                   decoration: const InputDecoration(
//                     hintText: "Food Name...",
//                     border: OutlineInputBorder(),
//                     contentPadding: EdgeInsets.all(20),
//                   ),
//                   maxLines: null,
//                 ),
//                 SizedBox(height: 6),
//                 TextFormField(
//                   controller: _foodDescriptionController,
//                   decoration: const InputDecoration(
//                     hintText: "Food Description...",
//                     border: OutlineInputBorder(),
//                     contentPadding: EdgeInsets.all(20),
//                   ),
//                   maxLines: null,
//                 ),
//                 SizedBox(height: 6),
//                 TextFormField(
//                   controller: _foodPriceController,
//                   decoration: const InputDecoration(
//                     hintText: "Food Price...",
//                     border: OutlineInputBorder(),
//                     contentPadding: EdgeInsets.all(20),
//                   ),
//                   maxLines: null,
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: _addFood,
//                   child: Text("Add Food"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';

class AddFood extends StatefulWidget {
  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  XFile? _selectedImage;
  final _foodNameController = TextEditingController();
  final _foodDescriptionController = TextEditingController();
  final _foodPriceController = TextEditingController();
  final _database = FirebaseDatabase.instance.reference();

  bool _uploading = false; // Track upload status

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage;
      });
    }
  }

  Future<void> _addFood() async {
    final String foodName = _foodNameController.text.trim();
    final String foodDescription = _foodDescriptionController.text.trim();
    final String foodPrice = _foodPriceController.text.trim();

    if (foodName.isEmpty || foodDescription.isEmpty || foodPrice.isEmpty) {
      // Display an error message if any of the fields are empty
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please fill in all the fields."),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    if (_selectedImage == null) {
      // Display an error message if no image is selected
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Please select a food image."),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      _uploading = true; // Start the upload process
    });

    try {
      // Upload the image to Firebase Storage and get the download URL
      final File imageFile = File(_selectedImage!.path);
      final String imagePath = "food_images/${DateTime.now().millisecondsSinceEpoch}.jpg";
      final Reference storageReference = FirebaseStorage.instance.ref().child(imagePath);
      final UploadTask uploadTask = storageReference.putFile(imageFile);
      final TaskSnapshot downloadTask = await uploadTask.whenComplete(() {});
      final String imageUrl = await downloadTask.ref.getDownloadURL();

      // Save the food item to Firebase Realtime Database
      final DatabaseReference foodRef = _database.child("foods").push();
      final Map<String, dynamic> foodData = {
        "name": foodName,
        "description": foodDescription,
        "price": foodPrice,
        "image_url": imageUrl,
      };
      await foodRef.set(foodData);

      // Clear the input fields and selected image
      _foodNameController.clear();
      _foodDescriptionController.clear();
      _foodPriceController.clear();
      setState(() {
        _selectedImage = null;
        _uploading = false; // Upload complete
      });

      // Display a success message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Food item added successfully."),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } catch (error) {
      setState(() {
        _uploading = false; // Upload failed
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to upload food item. Please try again."),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _foodDescriptionController.dispose();
    _foodPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Food"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  width: 350,
                  height: 200,
                  child: Column(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: _pickImage,
                          child: _selectedImage != null
                              ? Image.file(
                            File(_selectedImage!.path),
                            fit: BoxFit.cover,
                          )
                              : const Icon(
                            Icons.camera_alt_sharp,
                            size: 70,
                          ),
                        ),
                      ),
                      const Text("Click the camera to select food Image")
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _foodNameController,
                  decoration: const InputDecoration(
                    hintText: "Food Name...",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(20),
                  ),
                  maxLines: null,
                ),
                SizedBox(height: 6),
                TextFormField(
                  controller: _foodDescriptionController,
                  decoration: const InputDecoration(
                    hintText: "Food Description...",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(20),
                  ),
                  maxLines: null,
                ),
                SizedBox(height: 6),
                TextFormField(
                  controller: _foodPriceController,
                  decoration: const InputDecoration(
                    hintText: "Food Price...",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(20),
                  ),
                  maxLines: null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _uploading ? null : _addFood, // Disable button during upload
                  child: _uploading
                      ? CircularProgressIndicator() // Show progress indicator during upload
                      : Text("Add Food"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
