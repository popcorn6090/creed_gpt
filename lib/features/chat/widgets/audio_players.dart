// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioPlayers extends ConsumerStatefulWidget {
  final String audioUrl;
  const AudioPlayers({
    required this.audioUrl,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AudioPlayersState();
}

class _AudioPlayersState extends ConsumerState<AudioPlayers> {
  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState audioPlayerState = PlayerState.stopped;

  var isPlaying = true;

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        audioPlayerState = state;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (audioPlayerState == PlayerState.playing)
          IconButton(
            icon: isPlaying
                ? const CircularProgressIndicator()
                : const Icon(Icons.pause),
            iconSize: 20.0,
            onPressed: () async {
              setState(() {
                isPlaying = true;
              });
              await audioPlayer.pause();
            },
          )
        else
          IconButton(
            icon: isPlaying
                ? const CircularProgressIndicator()
                : Icon(Icons.play_arrow),
            iconSize: 48.0,
            onPressed: () async {
              AudioCache.instance = AudioCache(prefix: '');
              await audioPlayer.play(UrlSource(widget.audioUrl));
              setState(() {
                isPlaying = true;
              });

              //  await audioPlayer.play(AssetSource('assets/audio/audio.mp3'));
              // await audioPlayer.play(AssetSource('audio/add.wav'));
            },
          ),
        const SizedBox(height: 16.0),
        IconButton(
          icon: Icon(Icons.stop),
          iconSize: 15.0,
          onPressed: () async {
            await audioPlayer.stop();
          },
        ),
      ],
    );
  }
}
