import 'package:creed_gpt/theme/spectrum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreviousChat extends ConsumerStatefulWidget {
  const PreviousChat({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PreviousChatState();
}

class _PreviousChatState extends ConsumerState<PreviousChat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 642,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Column(children: [
        Container(
          height: 100,
          child: Row(
            children: [
              Container(
                width: 200,
                height: 40,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Spectrum.whiteColor,
                    width: 1,
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Spectrum.whiteColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'New Chat',
                      style: TextStyle(color: Spectrum.whiteColor),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 50,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Spectrum.whiteColor, width: 1)),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.segment,
                      color: Spectrum.whiteColor,
                    )),
              )
            ],
          ),
        )
      ]),
    );
  }
}
