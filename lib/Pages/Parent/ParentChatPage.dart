import 'package:flutter/material.dart';
import 'package:servisfy_mobile/Pages/Parent/chats/chats_screen.dart';


class ParentChatPage extends StatefulWidget {
  const ParentChatPage({Key? key}) : super(key: key);

  @override
  State<ParentChatPage> createState() => _ParentChatPageState();
}

class _ParentChatPageState extends State<ParentChatPage> {
  @override
  Widget build(BuildContext context) {
    return const ChatsScreen();
  }
}
