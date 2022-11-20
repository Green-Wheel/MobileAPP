import 'package:flutter/material.dart';

class ImageDisplay extends StatefulWidget {
  final double height;
  final double width;
  const ImageDisplay({Key? key, this.height = 150, this.width=150}) : super(key: key);

  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: OutlinedButton(
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Stack(
            children: [
              Row(children: [
                Expanded(
                    child: Image.asset(
                      'assets/images/img1.jpg',
                      height: widget.height,
                      width: widget.width/2,
                      fit: BoxFit.cover,
                    )),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                          child: Image.asset(
                            'assets/images/img2.png',
                            height: widget.height/2,
                            width: widget.width/2,
                            fit: BoxFit.cover,
                          )),
                      Expanded(
                          child: Image.asset(
                            'assets/images/img3.jpg',
                            height: widget.height/2,
                            width: widget.width/2,
                            fit: BoxFit.cover,
                          )),
                    ],
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

