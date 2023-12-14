import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/main_chat.dart';

class MobileChatScreen extends ConsumerStatefulWidget {
  const MobileChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MobileChatScreenState();
}

class _MobileChatScreenState extends ConsumerState<MobileChatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(children: [
        MainChat(),
      ]),
    );
  }
}
