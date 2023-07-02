import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  File? image;

  Future _saveImage() async {
    final String newPath = (await getApplicationDocumentsDirectory()).path;
    final imagePath = '$newPath/image.png';
    if (image != null) {
      image = File(imagePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NextPage'),
      ),
      body: Container(
          color: Colors.white,
          child: FloatingActionButton(
            onPressed: () {
              _saveImage();
            },
            child: const Icon(
              Icons.image,
              size: 50,
            ),
          )),
    );
  }
}
