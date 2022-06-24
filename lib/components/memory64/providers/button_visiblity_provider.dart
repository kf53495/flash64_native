import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class ButtonStates {
  const ButtonStates({
    required this.startButton,
    required this.memorizedButton,
    required this.answerButton,
  });

  final bool startButton;
  final bool memorizedButton;
  final bool answerButton;
}

class ButtonVisiblityNotifier extends StateNotifier<ButtonStates> {
  ButtonVisiblityNotifier()
      : super(
          const ButtonStates(
            startButton: true,
            memorizedButton: false,
            answerButton: false,
          ),
        );

  bool detectTimer = false;

  void pushStartButton() {
    state = const ButtonStates(
      startButton: false,
      memorizedButton: true,
      answerButton: false,
    );
  }

  void startTimer(time) {
    if (time != 0) {
      detectTimer = true;
      Timer(
        Duration(seconds: time),
        () {
          if (detectTimer) {
            state = const ButtonStates(
              startButton: false,
              memorizedButton: false,
              answerButton: true,
            );
            detectTimer = false;
          }
        },
      );
    }
  }

  void pushMemorizedButton() {
    state = const ButtonStates(
      startButton: false,
      memorizedButton: false,
      answerButton: true,
    );
    detectTimer = false;
  }

  void pushAnswerButton() {
    state = const ButtonStates(
      startButton: false,
      memorizedButton: false,
      answerButton: false,
    );
  }
}

final buttonVisiblityProvider =
    StateNotifierProvider.autoDispose<ButtonVisiblityNotifier, ButtonStates>(
  (ref) => ButtonVisiblityNotifier(),
);
