import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';

class SelectImage extends StatefulWidget {
  final Function getImageData;
  final bool multiple;
  List<File> imageFile =  [];


  SelectImage({Key? key, required this.getImageData, this.multiple = false, required this.imageFile}) : super(key: key);

  @override
  State<SelectImage> createState() => _SelectImageState();
}


class _SelectImageState extends State<SelectImage> {

  _getFromGallery() async {
    List<XFile> files = await ImagePicker().pickMultiImage(
      imageQuality: 5,
    );
    List<File> pikedImg = files.map((e) => File(e.path)).toList();
    if (pikedImg.isNotEmpty) {
      setState(() => {
        pikedImg.map((e) => widget.imageFile.add(e)).toList(),
      });
      widget.getImageData(widget.imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            _getFromGallery();
          },
          child: Text('Select Image'),
        ),
        Container(
          height: 100,
          child: widget.imageFile == null || widget.imageFile!.isEmpty
              ? const Icon(Icons.add)
              : ListView(
            scrollDirection: Axis.horizontal,
            children: widget.imageFile.map((file) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
              child: Image.file(file),
            )).toList(),
          ),
        ),
      ],
    );
  }
}

/*
 */