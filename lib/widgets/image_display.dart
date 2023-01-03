import 'package:flutter/material.dart';

//TODO refactor coger imagenes de s3 no de assets (Image.asset to Image.network)
//TODO if needed to make expandable, fer que vaigi dins de un container(heigth and with different a null) o en un expanded ((heigth and with different a null)
class ImageDisplay extends StatefulWidget {
  final double height;
  final double width;

  final List<dynamic> images;

  const ImageDisplay(
      {Key? key, required this.images, this.height = 150, this.width = 150})
      : super(key: key);

  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: InkWell(

        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Expanded(
                    child: AlertDialog(
                  content: ImagesDisplay(images: widget.images),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ));
              });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Stack(
            children: [
              Row(children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    child: widget.images.length >= 1
                        ? Image.network(
                            widget.images[0],
                            height: widget.height,
                            width: widget.width / 2,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/no_image.png',
                            height: widget.height,
                            width: widget.width / 2,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                  top:
                                      BorderSide(width: 1, color: Colors.black),
                                  right: BorderSide(
                                      width: 1, color: Colors.black)),
                            ),
                            child: widget.images.length >= 2
                                ? Image.network(
                                    widget.images[1],
                                    height: widget.height / 2,
                                    width: widget.width / 2,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/no_image.png',
                                    height: widget.height / 2,
                                    width: widget.width / 2,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(width: 1, color: Colors.black),
                              right: BorderSide(width: 1, color: Colors.black),
                              bottom: BorderSide(width: 1, color: Colors.black),
                            ),
                          ),
                          child: widget.images.length >= 3
                              ? Image.network(
                                  widget.images[2],
                                  height: widget.height / 2,
                                  width: widget.width / 2,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/no_image.png',
                                  height: widget.height / 2,
                                  width: widget.width / 2,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
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

class ImagesDisplay extends StatefulWidget {
  final List<dynamic> images;

  const ImagesDisplay({Key? key, required this.images}) : super(key: key);

  @override
  State<ImagesDisplay> createState() => _ImagesDisplayState();
}

class _ImagesDisplayState extends State<ImagesDisplay> {
  int _selected_image = 0;

  void selectImg(int index) {
    setState(() {
      _selected_image = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3 * MediaQuery.of(context).size.height / 5,
      child: widget.images.isNotEmpty ? Column(
        children: [
          Expanded(
            child: Image.network(
              widget.images[_selected_image],
              //TODO select contain, fill or cover,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 100,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.images
                    .map((image) => InkWell(
                  onTap: () => selectImg(widget.images.indexOf(image)),
                      child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.network(image, fit: BoxFit.contain),
                          ),
                    ))
                    .toList()),
          )
        ],
      ): const Center(child: Text('No images'),),
    );
  }
}
