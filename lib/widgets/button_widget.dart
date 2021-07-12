import 'package:flutter/material.dart';

class Butttonwidget extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  const Butttonwidget({
    Key? key,
    required this.text,
    required this.onClick,
  }) : super(key: key);


  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(50),
      shape: StadiumBorder(),
    ),
    child: FittedBox(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white
        ),
      ),
    ),
    onPressed: onClick,  
  );
}