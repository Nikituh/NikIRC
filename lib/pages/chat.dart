
import 'package:NikIRC/model/irc-client.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {

  final String title;

  ChatPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChatPageState();

}
class ChatPageState extends State<ChatPage> {

  List<ChatMessage> messages = new List();

  ChatPageState() {
    messages = IrcClient.instance.messages;
    IrcClient.instance.chat = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
            child: Container(
              color: Colors.white,
              child: DashChat(
                  user: ChatUser(
                    name: "Jhon Doe",
                    uid: "xxxxxxxxx",
                    avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
                  ),
                  messages: messages,
              ),
            )
        )
    );
  }

  void update(List<ChatMessage> messages) {
    this.messages = messages;
    setState(() {

    });
  }

}