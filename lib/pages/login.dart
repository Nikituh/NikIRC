import 'package:NikIRC/model/config.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:firn/FirnClient.dart';
import 'package:firn/datatypes/FirnConfig.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  LoginPage({Key key, this.title}) : super(key: key) {

    print("constructing MyHomePage");
    String server = "irc.quakenet.org";
    String channel = "#õlidnd";
    String nick = "NikiMobile";
    String name = "NikiMobile";

    FirnClient client = new FirnClient();
    client.printDebug = true;
    FirnConfig config = new FirnConfig();

    config.server = server;
    config.nickname = nick;
    config.realname = name;
    config.port = 6667;
    client.addConfig(config);

    client.globalEventController.stream.listen((event) async {

      print("Event fired: " + event.eventName);
      if (event.eventName == "ready") {
        client.authenticate(event.config, Config.IRC_USER, Config.IRC_PASSWORD);
      }

      if (event.eventName == "authenticated") {
        client.joinChannel(event.config, channel);
      }

    });

//    client.connectToServer(config);
  }

  final String title;

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  
  List<ChatMessage> messages = new List();

  void onFabClick() {
    setState(() {
      messages.add(new ChatMessage(text: "1", user: new ChatUser(uid: "123456", name: "Tiit")));
      messages.add(new ChatMessage(text: "2", user: new ChatUser(uid: "123451", name: "Niki")));
      messages.add(new ChatMessage(text: "3", user: new ChatUser(uid: "123452", name: "ffy")));
      messages.add(new ChatMessage(text: "4", user: new ChatUser(uid: "123459", name: "Jass")));
    });
  }

  @override
  Widget build(BuildContext context) {

    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

    final serverField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Server",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    );
    final channelField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Channel",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
    );
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5.0),
      color: Color.fromARGB(255, 255, 70, 50),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Connect",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
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
                serverField,
                SizedBox(height: 20.0),
                channelField,
                SizedBox(height: 30.0),
                loginButton,
                SizedBox(height: 15.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}