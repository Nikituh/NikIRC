
import 'package:NikIRC/model/style.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {

  final String hintText;
  final String text;
  final TextEditingController controller;

  InputField(this.hintText, this.text, this.controller);

  @override
  Widget build(BuildContext context) {
    controller.text = text;
    return TextField(
      controller: controller,
      obscureText: false,
      style: Style.text,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    );
  }
}