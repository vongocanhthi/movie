import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void Toast(BuildContext context, message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}