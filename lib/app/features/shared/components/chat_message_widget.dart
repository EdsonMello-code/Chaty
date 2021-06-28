import 'package:flutter/material.dart';
import 'package:socket/app/features/chat/controllers/chat_controller.dart';
import 'package:socket/app/features/chat/models/chat_model.dart';
import 'package:socket/app/features/shared/state/message_state.dart';

class ChatMessageWidget extends StatefulWidget {
  const ChatMessageWidget({Key? key}) : super(key: key);

  @override
  _ChatMessageWidgetState createState() => _ChatMessageWidgetState();
}

class _ChatMessageWidgetState extends State<ChatMessageWidget> {
  late final ChatController chatController;
  late final TextEditingController chatInputController;

  @override
  void initState() {
    chatInputController = TextEditingController();
    chatController = ChatController();
    super.initState();
  }

  @override
  void dispose() {
    chatController.dispose();
    chatInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: IconButton(
                    onPressed: () {
                      // Colocar o text input no estado centralizado
                      chatController.sendMessage(
                        chatModel: ChatModel(
                            to: Message.message.from,
                            msg: chatInputController.text,
                            from: Message.message.from),
                      );
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    )),
              ),
              SizedBox(
                width: 30,
              ),
              Expanded(
                flex: 6,
                child: Container(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: chatInputController,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
