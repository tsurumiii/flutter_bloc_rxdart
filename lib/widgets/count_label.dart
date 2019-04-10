import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CountLabel extends StatefulWidget {
  final int favoriteCount;

  CountLabel({
    Key key,
    @required this.favoriteCount,
  })  : assert(favoriteCount >= 0),
        super(key: key);
  @override
  _CountLabelState createState() => _CountLabelState();
}

class _CountLabelState extends State<CountLabel> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.favoriteCount.toString(),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 35,
        color: Colors.pink,
      ),
    );
  }
}
