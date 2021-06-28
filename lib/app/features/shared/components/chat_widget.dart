import 'package:flutter/material.dart';

class ChatWidget extends StatefulWidget {
  final String message;

  final Color? textColor;

  bool isHost;

  ChatWidget(
      {Key? key, required this.message, this.textColor, this.isHost = true})
      : super(key: key);

  @override
  ChatWidgetState createState() => ChatWidgetState();
}

class ChatWidgetState extends State<ChatWidget> {
  double _padding = 30.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 30, left: widget.isHost ? _padding : 50, bottom: 20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: widget.message.length * 10,
          height: 50,
          decoration: BoxDecoration(
              color: widget.isHost ? Colors.redAccent : Colors.grey,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.message,
              style: TextStyle(
                  color: widget.textColor == null
                      ? Colors.white
                      : widget.textColor,
                  fontSize: 15),
            ),
          )),
        ),
      ),
    );
  }
}
