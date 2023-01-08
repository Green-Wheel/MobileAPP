import 'package:flutter/material.dart';
import 'package:greenwheel/services/backendServices/ratings.dart';

class CommentBasicInfo extends StatefulWidget {
  final comment_id;

  const CommentBasicInfo({Key? key, required this.comment_id}) : super(key: key);

  @override
  State<CommentBasicInfo> createState() => _CommentBasicInfoState();
}

class _CommentBasicInfoState extends State<CommentBasicInfo> {
  var _comment;

  void _getComment() async {
    var aux = await RatingService.getRating(widget.comment_id);
    setState(() {
      _comment = aux;
    });
  }

  @override
  initState() {
    super.initState();
    _getComment();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Colors.black, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'username: ${_comment?.user.username ?? ""}',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text('rating: ${_comment?.rate ?? ""}', style: const TextStyle(fontSize: 20),),
                      Text('comment: ${_comment?.comment ?? ""}' "", style: const TextStyle(fontSize: 20),),
                    ],
                  )),
            ]),
          )),
    );
  }
}
