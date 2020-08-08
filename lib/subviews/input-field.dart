
import 'package:NikIRC/model/style.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {

  final String hintText;

  InputField(this.hintText);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: false,
      style: Style.text,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    );
  }
}