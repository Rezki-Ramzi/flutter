import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageScanner(),
    );
  }
}

class ImageScanner extends StatefulWidget {
  @override
  _ImageScannerState createState() => _ImageScannerState();
}

class _ImageScannerState extends State<ImageScanner> {
  XFile? _image;
  File? _blackAndWhiteImage;
  bool _desactive=false;

  void initState() {
    _desactive = false;
  }
  Future<void> _takePicture() async {
  final imagePicker = ImagePicker();
  final image = await imagePicker.pickImage(source: ImageSource.gallery);

  if (image != null) {
    final imageFile = File(image.path);

    // Load the image using the 'image' library.
    final decodedImage = img.decodeImage(await imageFile.readAsBytes());

    // Convert the image to grayscale.
    final blackAndWhiteImage = img.grayscale(decodedImage!);

    // Get the temporary directory using 'path_provider'.
    final tempDir = await getTemporaryDirectory();
    final tempFilePath = '${tempDir.path}/bw_image.jpg';

    // Create a file for the black and white image.
    final tempFile = File(tempFilePath);
    tempFile.writeAsBytes(img.encodeJpg(blackAndWhiteImage));

    setState(() {
      _image = image;
      _blackAndWhiteImage = tempFile;
      _desactive=true;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner d\'image et N&B'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_image != null)
              Column(
                children: <Widget>[
                  // Image.file(
                  //   File(_image!.path),
                  //   width: 300,
                  //   height: 300,
                  // ),
                  // SizedBox(height: 20),
                  if (_blackAndWhiteImage != null)
                    Image.file(
                      _blackAndWhiteImage!,
                      width: 500,
                      height: 300,
                    ),
                ],
              )
            else
              Text('Aucune image sélectionnée'),
            // SizedBox(height: 20),

             
            // ElevatedButton(
            //   onPressed: _takePicture,
            //   child: Text('Prendre une photo et convertir en N&B'),
            // ),

          ],
        ),
      ),
    

      floatingActionButton: FloatingActionButton(onPressed: _takePicture,
              child: 
              
        _desactive ?   ElevatedButton(onPressed: _takePicture,child:Icon(Icons.data_saver_on)) : const Icon(Icons.camera_alt)
        // const Icon(Icons.camera_alt),Icon(Icons.data_saver_on)
              ),
    );
  }
}
