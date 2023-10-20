import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:document_scanner_flutter/document_scanner_flutter.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageScannerApp(),
    );
  }
}

class ImageScannerApp extends StatefulWidget {
  @override
  _ImageScannerAppState createState() => _ImageScannerAppState();
}

class _ImageScannerAppState extends State<ImageScannerApp> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      // Compress the image to reduce file size (optional)
      // final compressedImage = await FlutterImageCompress.compressAndGetFile(
      //   pickedImage.path,
      //   pickedImage.path,
      //   quality: 50, // You can adjust the quality
      // );

      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acceuil | ARCHIVI '),
        
      ),
      body: Center(
  
            child : _image == null ? Text('Aucune image sélectionnée') : Image.file(_image!)
            ),
    
            floatingActionButton: FloatingActionButton(onPressed: () => _pickImage(ImageSource.camera),
              child: const Icon(Icons.camera_alt),
              ),
         
      
    );
  }
}
