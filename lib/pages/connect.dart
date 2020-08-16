
import 'package:NikIRC/model/irc-client.dart';
import 'package:NikIRC/model/style.dart';
import 'package:NikIRC/subviews/input-field.dart';
import 'package:firn/datatypes/Message.dart';
import 'package:flutter/material.dart';

class ConnectPage extends StatefulWidget {

  ConnectPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => ConnectPageState();
}

class ConnectPageState extends State<ConnectPage> with IrcDelegate {

  ConnectPageState() {
    IrcClient.instance.delegate = this;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[ createAppBarContent() ]
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

  BuildContext context;

  final TextEditingController serverTextController = new TextEditingController();
  final TextEditingController nickTextController = new TextEditingController();
  final TextEditingController nameTextController = new TextEditingController();

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

  createAppBarContent() {
    if (IrcClient.instance.state == IrcConnectionState.CONNECTING) {
      return new Container(width: 58.0, height: 30.0,
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: new CircularProgressIndicator(backgroundColor: Colors.blue));
    }

    return new Container(
        width: 20.0, height: 20.0, margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
        decoration: new BoxDecoration(
          color: IrcClient.instance.state == IrcConnectionState.CONNECTED ? Colors.green : Colors.red,
          shape: BoxShape.circle,
        ));
  }

  onConnectPress() {
    IrcClient.instance.connect(
        serverTextController.text,
        nickTextController.text,
        nameTextController.text
    );

    setState(() {});

//    Navigator.push(context, createRoute(context, ChatPage(title: IrcClient.instance.channel)));
  }

  createRoute(BuildContext context, Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }

  @override
  void authenticated() {
    // TODO: implement authenticated
  }

  @override
  void connected() {
    setState(() {});
  }

  @override
  void messageReceived(Message message) {
    // TODO: implement messageReceived
  }

}