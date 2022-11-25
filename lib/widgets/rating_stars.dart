import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingStars extends StatefulWidget {
  String rating;

  RatingStars({required this.rating, super.key});

  @override
  State<StatefulWidget> createState() => _RatingStarsWidget();
}

class _RatingStarsWidget extends State<RatingStars> {
  @override
  Widget build(BuildContext context) {
    return _buildRatingStars(widget.rating);
  }

  Widget _buildRatingStars(String rating) {
    return Row(
      children: [
        RatingBar.builder(
          initialRating: double.parse(rating),
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 20,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) =>
          const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(rating.toString(),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
