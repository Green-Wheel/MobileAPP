import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';

class SelectImage extends StatefulWidget {
  const SelectImage({Key? key}) : super(key: key);

  @override
  State<SelectImage> createState() => _SelectImageState();
}

class _SelectImageState extends State<SelectImage> {
  List<File> imageFile =  [];

  _getFromGallery() async {
    List<XFile> files = await ImagePicker().pickMultiImage(
      imageQuality: 5,
    );
    List<File> pikedImg = files.map((e) => File(e.path)).toList();
    if (pikedImg.isNotEmpty) {
      setState(() => {
        pikedImg.map((e) => imageFile.add(e)).toList(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _getFromGallery();
      },
      child: Container(
        height: 100,
        width: 100,
        child: imageFile == null || imageFile!.isEmpty
            ? const Icon(Icons.add)
            : Row(children: imageFile.map((file) => Image.file(file)).toList(),
        ),
      ),
    );
  }
}

/*

 */