
import 'package:NikIRC/model/irc-client.dart';
import 'package:NikIRC/model/style.dart';
import 'package:NikIRC/pages/chat.dart';
import 'package:NikIRC/subviews/input-field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset("assets/logo.png", fit: BoxFit.contain),
                ),
                SizedBox(height: 20.0),
                new InputField("Server"),
                SizedBox(height: 20.0),
                new InputField("Channel"),
                SizedBox(height: 30.0),
                createLoginButton(context),
                SizedBox(height: 15.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  createLoginButton(BuildContext context) {
    this.context = context;
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5.0),
      color: Color.fromARGB(255, 255, 50, 50),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: onConnectPress,
        child: Text("Connect",
            textAlign: TextAlign.center,
            style: Style.text.copyWith(color: Colors.white, fontWeight: FontWeight.bold)
        ),
      ),
    );
  }

  onConnectPress() {
    Navigator.push(context, createRoute(context, ChatPage(title: IrcClient.instance.channel)));
  }

  createRoute(BuildContext context, Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}