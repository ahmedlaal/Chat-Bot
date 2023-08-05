import 'dart:async';

import 'package:chatbot/resuable_widget.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  StreamSubscription? _subscription;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  final TextEditingController _controller = TextEditingController();
  List<ChatMessage> _message = [];
  void sendmessage() {
    ChatMessage chat = ChatMessage(text: _controller.text, sender: "user");
    setState(() {
      _message.insert(0, chat);
    });
    _controller.clear();
  }

  Widget chatview() {
    return Row(
      children: [
        Expanded(
            child: TextField(
          controller: _controller,
          onSubmitted: (value) => sendmessage(),
          decoration:
              const InputDecoration.collapsed(hintText: "Enter Message"),
        )),
        IconButton(
            onPressed: () {
              sendmessage();
            },
            icon: const Icon(Icons.send))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Bot"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    padding: Vx.m8,
                    itemCount: _message.length,
                    itemBuilder: ((context, index) {
                      return _message[index];
                    }))),
            Container(
              decoration: BoxDecoration(
                color: context.cardColor,
              ),
              child: chatview(),
            )
          ],
        ),
      ),
    );
  }
}
