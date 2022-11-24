import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarsStaticRateWidget extends StatefulWidget {
  double rate;
  StarsStaticRateWidget({required this.rate, super.key});

  @override
  State<StatefulWidget> createState() => _StarsStaticRateWidget();
}

class _StarsStaticRateWidget extends State<StarsStaticRateWidget>{
  @override
  Widget build(BuildContext context) {
    return _starsStaticCard(widget.rate);
  }
}

//funcion para mostrar las estrellas
Widget _starsStaticCard(double rate){
  return Padding(
    padding: const EdgeInsets.only(left: 0.0, bottom: 5.0),
    child: Row(
      children: [
        RatingBar(
          initialRating: rate,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemSize: 15,
          ratingWidget: RatingWidget(
            full: const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            half: const Icon(
              Icons.star_half,
              color: Colors.amber,
            ),
            empty: const Icon(
              Icons.star,
              color: Colors.grey,
            ),
          ),
          ignoreGestures: true,
          onRatingUpdate: (rate) { print(rate); },
        ),
        Padding(
          padding: EdgeInsets.only(left: 5.0),
          child:Text(
            rate.toString(),
            style: const TextStyle(fontWeight: FontWeight.w500, color: Color.fromRGBO(69, 69, 69, 1)),
          ),
        ),
      ],
    ),
  );
}