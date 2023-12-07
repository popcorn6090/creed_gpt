// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TypeWriter extends ConsumerStatefulWidget {
  final String text;
  final TextStyle style;
  final Duration speed;
  const TypeWriter({
    super.key,
    required this.text,
    required this.style,
    this.speed = const Duration(milliseconds: 100),
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TypeWriterState();
}

class _TypeWriterState extends ConsumerState<TypeWriter>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<int> _textAnimation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: widget.speed);
    _textAnimation = IntTween(begin: 0, end: widget.text.length)
        .animate(animationController);
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _textAnimation,
      builder: (context, child) {
        String animatedText = widget.text.substring(0, _textAnimation.value);
        return Text(
          animatedText,
          style: widget.style,
        );
      },
    );
  }
}
