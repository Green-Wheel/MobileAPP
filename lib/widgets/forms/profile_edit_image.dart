import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/backendServices/user_service.dart';

class SelectImageEdit extends StatefulWidget{
  SelectImageEdit(this.image_url);
  bool fake = false;
  @override
  State<SelectImageEdit> createState() => _SelectImageEdit();
  var image_url;
  ImageProvider<Object>? image_profile;


}

class _SelectImageEdit extends State<SelectImageEdit> {
  File? image;
  var image_provisional;
  @override
  void initState(){
    super.initState();
    print(widget.image_url);
    if(widget.image_url != null)  widget.image_profile = NetworkImage(widget.image_url);
    else widget.image_profile = AssetImage('assets/images/default_user_img.jpg');
  }

  void _pickedImage() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
          content: Text("Choose image source"),
          actions: [
            ElevatedButton(
              child: Text("Camera"),
              onPressed: () => Navigator.pop(context, ImageSource.camera),
            ),
            ElevatedButton(
              child: Text("Gallery"),
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ]
      ),
    ).then((ImageSource? source) async {
      if (source != null) {
        final pickedFile = await ImagePicker().pickImage(source: source);
        setState(() => image = File(pickedFile!.path));
        if(image!= null) {
          UserService.putImage(context, image!);
          setState(() {
            widget.image_profile = Image.file(image!) as ImageProvider<Object>?;
          });
          //setState(() {
           // widget.image_profile = Image.file(image!) as ImageProvider<Object>?;
          //});
        }
        else  print("BBBBBBBBBBBBBBBBBBBBBBBBBBB");
      }else {
        print("AAAAAAAAAAAAAAAAAAAAAAAAA");
      }
    });
  }

  @override
  Widget build(BuildContext context) {


    return Stack(
      children: [
        CircleAvatar(
          radius: 75,
          backgroundColor: Colors.grey.shade200,
          child: CircleAvatar(
            radius: 70,
            backgroundImage:  widget.image_profile,
          ),
        ),
        Positioned(
          bottom: 1,
          right: 1,
          child: Container(
            child: IconButton(icon: Icon(Icons.add_a_photo), color: Colors.black,
              onPressed: () {
                  _pickedImage();
              },
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    30,
                  ),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2, 4),
                    color: Colors.black.withOpacity(
                      0.3,
                    ),
                    blurRadius: 3,
                  ),
                ]),
          ),
        ),
      ],
    );
  }

}
