
import 'package:NikIRC/pages/chat.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:firn/FirnClient.dart';
import 'package:firn/datatypes/FirnConfig.dart';
import 'package:firn/datatypes/Message.dart';
import 'package:firn/events/MessageRecievedEvent.dart';
import 'package:flutter/material.dart';

import 'config.dart';

class IrcClient {

  static IrcClient instance = new IrcClient();

  String server = "irc.quakenet.org";
  String channel = "#õlimobile";
  String nick = "NikiMobile";
  String name = "NikiMobile";

  List<ChatMessage> messages = new List();

  // TODO circular dependency.
  // How the fuck do delegates or callbacks work in dart!?
  ChatPageState chat;

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

      if (event.eventName == "privMsgRecieved") {

        Message message = (event as MessageRecievedEvent).message;
        messages.add(new ChatMessage(text: message.parameters[1], user: new ChatUser(uid: "123451", name: "Niki")));
        chat.update(messages);
      }
    });

    client.connectToServer(config);
  }
}