import 'package:flutter/material.dart';

Widget oneColumn(label, info, alignment){
  return Column(
    crossAxisAlignment: alignment,
    children: [
      labelText(label),
      SizedBox(height: 5),
      oneRow(info),
    ],
  );
}


Widget oneRow(content) {
  return Text(
    content,
    style: TextStyle(
        fontSize: 23,
        color: Colors.amberAccent[200],
        fontWeight: FontWeight.bold
    ),
  );
}

Widget labelText(label) {
  return Text(
    label,
    style: TextStyle(
        color: Colors.grey[400],
        letterSpacing: 2,
        fontWeight: FontWeight.bold,
        fontSize: 14
    ),
  );
}