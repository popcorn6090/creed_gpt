import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/main_chat.dart';
import '../widgets/previous_chat.dart';

class ChatScreen extends ConsumerStatefulWidget {
  static const routeName = '/chat-screen';
  const ChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(children: [
        Expanded(
            child: Row(
          children: [
            PreviousChat(),
            MainChat(),
          ],
        ))
      ]),
    );
  }
}
