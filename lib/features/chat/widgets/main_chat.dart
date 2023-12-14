import 'package:creed_gpt/core/utils.dart';
import 'package:creed_gpt/features/auth/controller/auth_controller.dart';
import 'package:creed_gpt/features/chat/controller/chat_controller.dart';
import 'package:creed_gpt/features/chat/widgets/show_case.dart';
import 'package:creed_gpt/models/user_model.dart';
import 'package:creed_gpt/theme/spectrum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainChat extends ConsumerStatefulWidget {
  const MainChat({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainChatState();
}

class _MainChatState extends ConsumerState<MainChat> {
  final TextEditingController questionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    questionController.dispose();
  }

  getSearchResults() {
    ref
        .watch(chatControllerProvider.notifier)
        .getSearchResults(questionController.text.trim());
  }

  final ScrollController scrollController = ScrollController();

  void scrollToCurrentAnswer() {
    if (scrollController.hasClients) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 1), curve: Curves.easeInCirc);
    }
  }

  void premiumLimit(UserModel user) {
    ref.read(chatControllerProvider.notifier).premiumLimit(user);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final isLoading = ref.watch(chatControllerProvider);
    return Expanded(
      child: Scaffold(
        backgroundColor: Spectrum.mablackchatgptColor,
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 500,
              child: ShowCase(
                scrollController: scrollController,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
                width: 600,
                child: TextFormField(
                  controller: questionController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Spectrum.mablackchatgptColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintText: 'Ask me anything, I will do it.',
                    hintStyle: TextStyle(
                      color: Colors.grey[900],
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        user!.limit > 10
                            ? showSnackBar(context,
                                'You have reached your daily limit, why don\'t you come back tomorrow')
                            : getSearchResults();
                        scrollToCurrentAnswer();
                        premiumLimit(user);
                        questionController.text = '';
                      },
                      icon: isLoading
                          ? const CircularProgressIndicator()
                          : const Icon(
                              Icons.send,
                            ),
                    ),
                  ),
                ))
          ]),
        ),
      ),
    );
  }
}
