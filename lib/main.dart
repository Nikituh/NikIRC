import 'package:NikIRC/model/irc-client.dart';
import 'package:NikIRC/pages/connect.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(NikIRC());
}

class NikIRC extends StatelessWidget {

  NikIRC() {
    IrcClient.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NikiRC',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ConnectPage(title: 'NikIRC'),
    );
  }
}


