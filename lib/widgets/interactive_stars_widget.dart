import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class InteractiveStarsWidget extends StatefulWidget {
  double rate;
  InteractiveStarsWidget({required this.rate, super.key});

  @override
  State<StatefulWidget> createState() => _InteractiveStarsWidget();
}

class _InteractiveStarsWidget extends State<InteractiveStarsWidget>{
  @override
  Widget build(BuildContext context) {
    return _interactiveStarsWidget(widget.rate);
  }
}

main() {
  runApp(MaterialApp(
    home: _interactiveStarsWidget(0.0),
  ));
}

//funcion para mostrar las estrellas
Widget _interactiveStarsWidget(double rate){
  return Row(
    children: [
      RatingBar(
        initialRating: rate,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        itemSize: 20,
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
            Icons.star_outline,
            color: Colors.grey,
          ),
        ),
        onRatingUpdate: (rate)  {
          //gestionar el evento de click en la estrella al actualizar el rating
          print(rate);
          },
      ),
    ],
  );
}