
import 'package:NikIRC/model/irc-client.dart';
import 'package:NikIRC/model/style.dart';
import 'package:NikIRC/pages/chat.dart';
import 'package:NikIRC/subviews/input-field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  BuildContext context;

  final TextEditingController serverTextController = new TextEditingController();
  final TextEditingController nickTextController = new TextEditingController();
  final TextEditingController nameTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
//            new Container(width: 58.0, height: 30.0, padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            new Container(width: 20.0, height: 20.0, padding: EdgeInsets.fromLTRB(15, 15, 30, 15), margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
//              child: new CircularProgressIndicator(backgroundColor: Colors.blue)
              decoration: new BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,

              ),
              )]
      ),
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
                new InputField("Server", IrcClient.DEFAULT_SERVER, serverTextController),
                SizedBox(height: 20.0),
                new InputField("Nickname", IrcClient.DEFAULT_NICK, nickTextController),
                SizedBox(height: 20.0),
                new InputField("Real name", IrcClient.DEFAULT_NAME, nameTextController),
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
      color: Colors.amberAccent,
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
    IrcClient.instance.connect(
        serverTextController.text,
        nickTextController.text,
        nameTextController.text
    );

//    Navigator.push(context, createRoute(context, ChatPage(title: IrcClient.instance.channel)));
  }

  createRoute(BuildContext context, Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}