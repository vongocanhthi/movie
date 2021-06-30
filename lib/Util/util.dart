import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void Toast(BuildContext context, message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}

const divider_white = Divider(color: Colors.white);
const divider_black = Divider(color: Colors.black);
