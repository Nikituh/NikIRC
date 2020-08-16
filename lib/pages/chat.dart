
import 'package:NikIRC/model/irc-client.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:firn/datatypes/Message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {

  final String title;

  ChatPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChatPageState();

}
class ChatPageState extends State<ChatPage> with IrcDelegate {

  List<ChatMessage> messages = new List();

  ChatPageState() {
    IrcClient.instance.delegate = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Center(
            child: Container(
              color: Colors.white,
              child: DashChat(
                user: ChatUser(uid: "asklfsdkg", name: IrcClient.instance.config.nickname),
                messages: messages,
                onSend: (ChatMessage message) {
                    IrcClient.instance.send(message.text);
                },
              ),
            )
        )
    );
  }

  void update(List<ChatMessage> messages) {
    this.messages = messages;
    setState(() { });
  }

  @override
  void authenticated() {
    print("authenticated");
  }

  @override
  void connected() {
    print("connected");
  }

  @override
  void messageReceived(Message message) {
    update(IrcClient.instance.messages);
  }

}