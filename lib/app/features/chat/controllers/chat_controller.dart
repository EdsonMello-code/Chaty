import 'dart:async';

import 'package:socket/app/features/chat/models/chat_model.dart';
import 'package:socket/app/features/shared/state/message_state.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatController {
  late final Socket socket;
  final List<ChatModel> chatMessages = [];
  final _socketResponse = StreamController<List<ChatModel>>();

  ChatController() {
    socket = io('http://localhost:3000',
        OptionBuilder().setTransports(['websocket']).build());
  }

  void sendMessage({required ChatModel chatModel}) {
    socket.emit('message', chatModel.toJson());
  }

  void openConnectionWithSocketAndListener() {
    // socket = io('http://localhost:3000',
    //     OptionBuilder().setTransports(['websocket']).build());

    socket.onConnect((_) {
      print('connect');
    });

    listenSocket();

    socket.onDisconnect((_) => print('disconnect'));
  }

  void listenSocket() {
    socket.emit('join', {'from': Message.message.from});

    socket.on('message', (data) {
      chatMessages.add(ChatModel.fromMap(data));
      print(chatMessages);
      addResponse(chatMessages);
    });
  }

  void Function(List<ChatModel>) get addResponse => _socketResponse.sink.add;

  Stream<List<ChatModel>> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}
