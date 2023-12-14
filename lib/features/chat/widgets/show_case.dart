// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:creed_gpt/features/chat/widgets/audio_players.dart';
import 'package:creed_gpt/features/chat/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:creed_gpt/core/commons/type_writer.dart';
import 'package:creed_gpt/features/chat/controller/chat_controller.dart';
import 'package:creed_gpt/theme/spectrum.dart';

class ShowCase extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  const ShowCase({
    required this.scrollController,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShowCaseState();
}

class _ShowCaseState extends ConsumerState<ShowCase> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(getAllQuestionsAndAnswersProvider).when(
        data: (data) {
          return ListView.builder(
            controller: widget.scrollController,
            itemCount: data!.question.length,
            itemBuilder: (ctx, i) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 100,
                    ),
                    decoration: const BoxDecoration(
                      color: Spectrum.mablackchatgptColor,
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/pic.png'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(data.question[i]),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 100,
                    ),
                    constraints: const BoxConstraints(
                      maxWidth: double.infinity,
                      maxHeight: 350,
                    ),
                    decoration: const BoxDecoration(
                      color: Spectrum.answergpt,
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/pic.png'),
                        ),
                        const SizedBox(width: 20),
                        data.answer[i]['type'] == 'string'
                            ? TypeWriter(
                                text: data.answer[i]['value'],
                                style: const TextStyle(),
                                speed: const Duration(seconds: 3),
                              )
                            : data.answer[i]['type'] == 'image'
                                ? Expanded(
                                    child: Image.network(
                                      data.answer[i]['value'],
                                      width: double.infinity,
                                      height: 650,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  )
                                : data.answer[i]['type'] == 'audio'
                                    ? AudioPlayers(
                                        audioUrl: data.answer[i]['value'],
                                      )
                                    : TestVideo(
                                        videoUrl: data.answer[i]['value'],
                                      )
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
        error: (error, trace) {
          return Center(
            child: Text(error.toString()),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
