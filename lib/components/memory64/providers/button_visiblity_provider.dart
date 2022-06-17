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

  // 以下の記述、不要(?)
  // 最後まで実装してエラーが起こらなければそのまま削除
  // ButtonStates copyWith({bool? id, bool? stoneColor, bool? visiblity}) {
  //   return ButtonStates(
  //     startButton: startButton,
  //     memorizedButton: memorizedButton,
  //     answerButton: answerButton,
  //   );
  // }
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

  void pushStartButton() {
    state = const ButtonStates(
      startButton: false,
      memorizedButton: true,
      answerButton: false,
    );
  }

  void startTimer(time) {
    if (time != 0) {
      Timer(
        Duration(seconds: time),
        () {
          state = const ButtonStates(
            startButton: false,
            memorizedButton: false,
            answerButton: true,
          );
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
