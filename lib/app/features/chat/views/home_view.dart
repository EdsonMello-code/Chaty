import 'package:flutter/material.dart';
import 'package:socket/app/features/chat/controllers/chat_controller.dart';
import 'package:socket/app/features/chat/models/chat_model.dart';
import 'package:socket/app/features/shared/components/chat_message_widget.dart';
import 'package:socket/app/features/shared/components/chat_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late final ChatController chatController;

  @override
  void initState() {
    chatController = ChatController();

    chatController.openConnectionWithSocketAndListener();
    super.initState();
  }

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ChatModel>>(
          stream: chatController.getResponse,
          initialData: [ChatModel(to: '', msg: '', from: '')],
          builder: (context, snapshot) {
            final chats = snapshot.data;
            if (chats == null || chats.isEmpty) {
              return CircularProgressIndicator();
            }
            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    children: chats
                        .map((data) => ChatWidget(message: data.msg))
                        .toList(),
                  ),
                ),
                ChatMessageWidget()
              ],
            );
          }),
    );
  }
}
