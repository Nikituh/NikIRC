import 'package:NikIRC/pages/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(NikIRC());
}

class NikIRC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NikiRC',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(title: 'NikIRC'),
    );
  }
}


