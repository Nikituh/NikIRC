
import 'package:dash_chat/dash_chat.dart';
import 'package:firn/FirnClient.dart';
import 'package:firn/datatypes/FirnConfig.dart';

import 'config.dart';

class IrcClient {

  static IrcClient instance = new IrcClient();

  String server = "irc.quakenet.org";
  String channel = "#õlidnd";
  String nick = "NikiMobile";
  String name = "NikiMobile";

  List<ChatMessage> messages = new List();

  IrcClient() {

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

    messages.add(new ChatMessage(text: "1", user: new ChatUser(uid: "123456", name: "Tiit")));
    messages.add(new ChatMessage(text: "2", user: new ChatUser(uid: "123451", name: "Niki")));
    messages.add(new ChatMessage(text: "3", user: new ChatUser(uid: "123452", name: "ffy")));
    messages.add(new ChatMessage(text: "4", user: new ChatUser(uid: "123459", name: "Jass")));

  }


}