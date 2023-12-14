// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

class TestVideo extends StatefulWidget {
  final String videoUrl;
  const TestVideo({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<TestVideo> createState() => _TestVideoState();
}

class _TestVideoState extends State<TestVideo> {
  late CustomVideoPlayerWebController _customVideoPlayerWebController;

  final CustomVideoPlayerWebSettings _customVideoPlayerWebSettings =
      CustomVideoPlayerWebSettings(
    src: videoUrl,
  );

  @override
  void initState() {
    super.initState();
    _customVideoPlayerWebController = CustomVideoPlayerWebController(
      webVideoPlayerSettings: _customVideoPlayerWebSettings,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomVideoPlayerWeb(
          customVideoPlayerWebController: _customVideoPlayerWebController),
    );
  }
}

final videoUrl =
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
