import 'package:flutter/material.dart';
import '../select_image.dart';

class BasicInfo extends StatefulWidget {
  var data;
  final Function callback;
  final Function nextPage;

  BasicInfo(
      {Key? key,
      required this.data,
      required this.callback,
      required this.nextPage})
      : super(key: key);

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  final _formKey = GlobalKey<FormState>();

  void _getImageData(images) {
    setState(() {
      widget.data['images'] = images;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Title"),
                TextFormField(
                  initialValue: widget.data['title'],
                  onSaved: (value) {
                    widget.data['title'] = value!;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter Title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text("Description"),
                TextFormField(
                  initialValue: widget.data['description'],
                  onSaved: (value) {
                    widget.data['description'] = value!;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text("Price"),
                TextFormField(
                  initialValue: widget.data['price'],
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    widget.data['price'] = value!;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter Price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                SelectImage(
                  multiple: true,
                  getImageData: _getImageData,
                  imageFile: widget.data['images'],
                ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        widget.callback(widget.data);
                        widget.nextPage();
                      }
                    },
                    child: const Text('Next'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
