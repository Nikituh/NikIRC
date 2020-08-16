
import 'dart:async';

import 'package:NikIRC/pages/chat.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:firn/FirnClient.dart';
import 'package:firn/datatypes/FirnConfig.dart';
import 'package:firn/datatypes/Message.dart';
import 'package:firn/events/MessageRecievedEvent.dart';
import 'package:flutter/material.dart';

import 'config.dart';

mixin IrcDelegate {

  void connected();

  void authenticated();

  void messageReceived(Message message);
}

class IrcClient {

  static IrcClient instance;

  IrcDelegate delegate;

  static initialize() {
    instance = new IrcClient();
  }

  String server = "irc.quakenet.org";
  String channel = "#õlimobile";
  String nick = "NikiMobile";
  String name = "NikiMobile";

  List<ChatMessage> messages = new List();

  FirnConfig config;
  FirnClient client;

  IrcClient() {

    client = new FirnClient();
    client.printDebug = true;
    config = new FirnConfig();

    config.server = server;
    config.nickname = nick;
    config.realname = name;
    config.port = 6667;
    client.addConfig(config);

    client.globalEventController.stream.listen((event) async {

      print("Event fired: " + event.eventName);
      if (event.eventName == "ready") {
        client.authenticate(event.config, Config.IRC_USER, Config.IRC_PASSWORD);
        delegate?.connected();
      }

      if (event.eventName == "authenticated") {
        client.joinChannel(event.config, channel);
        delegate?.authenticated();
      }

      if (event.eventName == "privMsgRecieved") {
        Message message = (event as MessageRecievedEvent).message;
        ChatUser user = new ChatUser(uid: message.prefix.user, name: message.prefix.nick);
        messages.add(new ChatMessage(text: message.parameters[1], user: user));
        delegate?.messageReceived(message);
      }

    });

    client.connectToServer(config);
  }

  send(String text) {
    client.sendLine(config, text);
  }

}