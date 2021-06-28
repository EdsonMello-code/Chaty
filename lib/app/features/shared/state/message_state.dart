import 'package:flutter/material.dart';

class Message extends ChangeNotifier {
  String _from = '';
  String _to = '';

  static Message message = Message();

  String get from => _from;
  String get to => _to;

  void storeHostEmail({required String from, required String to}) {
    _from = from;
    _to = to;
    notifyListeners();
  }
}
