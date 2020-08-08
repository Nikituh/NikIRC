
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {

  final String title;

  ChatPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChatPageState();

}
class ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
            child: Container(
              color: Colors.white,
            )
        )
    );
  }

}