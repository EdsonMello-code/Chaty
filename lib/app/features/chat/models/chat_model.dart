class ChatModel {
  final String from;
  final String to;
  final String msg;

  ChatModel({required this.to, required this.msg, required this.from});

  factory ChatModel.fromMap(Map<String, dynamic> json) {
    return ChatModel(to: json['to'], msg: json['msg'], from: json['from']);
  }

  Map<String, dynamic> toJson() {
    return {'to': to, 'from': from, 'msg': msg};
  }
}
