
import 'package:dash_chat/dash_chat.dart';
import 'package:firn/FirnClient.dart';
import 'package:firn/datatypes/FirnConfig.dart';
import 'package:firn/datatypes/Message.dart';
import 'package:firn/events/MessageRecievedEvent.dart';

import 'config.dart';

enum IrcConnectionState {
  NOT_CONNECTED,
  CONNECTING,
  CONNECTED
}

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

  static const String DEFAULT_SERVER = "irc.quakenet.org";
  static const String DEFAULT_NICK = "NikiMobile";
  static const String DEFAULT_NAME = "NikiMobile";

  List<ChatMessage> messages = new List();

  FirnConfig config;
  FirnClient client;

  IrcConnectionState state;

  IrcClient() {

    state = IrcConnectionState.NOT_CONNECTED;

    client = new FirnClient();
    client.printDebug = true;
    config = new FirnConfig();

    config.server = DEFAULT_SERVER;
    config.nickname = DEFAULT_NICK;
    config.realname = DEFAULT_NAME;
    config.port = 6667;
    client.addConfig(config);

    client.globalEventController.stream.listen((event) async {
      this.config = event.config;
      if (event.eventName == "ready") {
        state = IrcConnectionState.CONNECTED;
        delegate?.connected();
      }
      if (event.eventName == "authenticated") {
        delegate?.authenticated();
      }
      if (event.eventName == "privMsgRecieved") {
        Message message = parseMessage(event as MessageRecievedEvent);
        delegate?.messageReceived(message);
      }
    });
  }

  connect(String server, String nick, String name) {
    state = IrcConnectionState.CONNECTING;
    config.server = server;
    config.nickname = nick;
    config.realname = name;
    client.connectToServer(config);
  }

  authenticate(String user, String password) {
    client.authenticate(config, Config.IRC_USER, Config.IRC_PASSWORD);
  }

  join(String channel) {
    client.joinChannel(config, channel);
  }

  send(String text) {
    client.sendLine(config, text);
  }

  parseMessage(MessageRecievedEvent event) {
    Message message = event.message;
    ChatUser user = new ChatUser(uid: message.prefix.user, name: message.prefix.nick);
    messages.add(new ChatMessage(text: message.parameters[1], user: user));
    return message;
  }
}