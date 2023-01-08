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
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                const SizedBox(height: 10),
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
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: widget.data['price'].toString() != '0.0' ? widget.data['price'].toString() : '',
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    widget.data['price'] = double.parse(value!);
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
                const SizedBox(height: 10),
                SelectImage(
                  multiple: true,
                  getImageData: _getImageData,
                  imageFile: widget.data['images'],
                ),
                const SizedBox(height: 10),
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
