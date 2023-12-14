// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:creed_gpt/features/chat/repository/chat_repository.dart';
import 'package:creed_gpt/models/question.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user_model.dart';

final getAllQuestionsAndAnswersProvider = StreamProvider((ref) {
  final chatController = ref.watch(chatControllerProvider.notifier);
  return chatController.getAllQuestionsAndAnswers(ref);
});

final chatControllerProvider =
    StateNotifierProvider<ChatController, bool>((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository);
});

class ChatController extends StateNotifier<bool> {
  final ChatRepository chatRepository;
  ChatController({
    required this.chatRepository,
  }) : super(false);

  getSearchResults(String askedQuestion) async {
    state = true;
    final res = await chatRepository.getSearchResults(askedQuestion);
    state = false;
    res.fold((l) => print(l.message), (r) => r);
  }

  Stream<Question?> getAllQuestionsAndAnswers(Ref ref) {
    return chatRepository.getAllQuestionsAndAnswers(ref);
  }

  premiumLimit(UserModel user) async {
    return chatRepository.premiumLimit(user);
  }
}
