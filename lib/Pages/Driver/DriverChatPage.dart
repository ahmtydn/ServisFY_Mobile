import 'package:flutter/material.dart';
import 'package:servisfy_mobile/Pages/Parent/chats/chats_screen.dart';

class DriverChatPage extends StatefulWidget {
  const DriverChatPage({Key? key}) : super(key: key);

  @override
  State<DriverChatPage> createState() => _DriverChatPageState();
}

class _DriverChatPageState extends State<DriverChatPage> {
  @override
  Widget build(BuildContext context) {
    return ChatsScreen();
  }
}
