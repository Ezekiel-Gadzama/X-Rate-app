import 'package:flutter/material.dart';
import 'package:x_rate_app/features/profile/models/chat_model.dart';

class ChatProvider extends ChangeNotifier {
  ChatModel _chatModel = ChatModel(
    id: "",
    chatName: '',
    sender: '',
    receiver: '',
  );

  //creating getter for user
  ChatModel get chat => _chatModel;

  void setChatModel(String chat) {
    //data fromjson coming from models/user.dart
    _chatModel = ChatModel.fromJson(chat);
    notifyListeners();
  }
}
