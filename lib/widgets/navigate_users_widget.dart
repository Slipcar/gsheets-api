import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigateUsersWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClickPrevious;
  final VoidCallback onClickNext;

  const NavigateUsersWidget({
    Key? key,
    required this.text, 
    required this.onClickNext, 
    required this.onClickPrevious, 
    }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(
        iconSize: 48,
        onPressed: onClickPrevious, 
        icon: Icon(Icons.navigate_before)
      ),
      Text(
        text,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      IconButton(
        iconSize: 48,
        onPressed: onClickNext, 
        icon: Icon(Icons.navigate_next)
      ),
    ],
  );
}