import 'package:flutter/material.dart';

class MatchWithCarWidget extends StatefulWidget {
  final bool match;
  const MatchWithCarWidget({required this.match, super.key});

  @override
  State<StatefulWidget> createState() => _MatchWithCarWidget();
}

class _MatchWithCarWidget extends State<MatchWithCarWidget>{
  late bool match = false;

  @override
  Widget build(BuildContext context) {
    return _matchCarWithCharger(match);
  }
}

//funcion para determinar la compatibilidad cargador con el coche
Widget _matchCarWithCharger(bool match){
  if (match){
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Row(
        children: const [
          Icon (
            Icons.check_circle_outline_rounded,
            size: 20,
            color: Colors.green,
          ),
          Padding(
            padding:EdgeInsets.only(left: 5.0),
            child: Text('Matching with your car charger',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
  else{
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Row(
        children: const [
          Icon (
            Icons.do_not_disturb_on_outlined,
            size: 20,
            color: Colors.red,
          ),
          Padding(
            padding:EdgeInsets.only(left: 5.0),
            child: Text('Not match with your car charger',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}