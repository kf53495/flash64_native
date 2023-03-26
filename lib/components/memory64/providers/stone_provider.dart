import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math';

@immutable
class StoneInformation {
  const StoneInformation({
    required this.id,
    required this.stoneColor,
    required this.visiblity,
    required this.correctCount,
    required this.boxColor,
  });

  final int id;
  final String stoneColor;
  final bool visiblity;
  final bool correctCount;
  final Color boxColor;
}

List<String> stoneColorType = [
  'black',
  'white',
  'empty',
];

class StoneNotifier extends StateNotifier<List<StoneInformation>> {
  StoneNotifier() : super([]);
  bool detectTimer = false;
  int displayResultCount = 0;

  void initStones(int size, String mode) {
    int placementId = 0;
    state = [];
    for (int i = 0; i < size; i++) {
      state = [
        ...state,
        StoneInformation(
          id: placementId,
          stoneColor: mode == 'empty'
              ? stoneColorType[Random().nextInt(3)] // 空白あり
              : stoneColorType[Random().nextInt(2)], // onlyBlack、onlyWhite
          visiblity: false,
          correctCount: false,
          boxColor: Colors.lightGreen,
        )
      ];
      placementId++;
    }
    displayResultCount = 0;
  }

  void displayAllStones() {
    state = [
      for (final stone in state)
        StoneInformation(
          id: stone.id,
          stoneColor: stone.stoneColor,
          visiblity: true,
          correctCount: false,
          boxColor: Colors.lightGreen,
        )
    ];
  }

  void hideAllStones(String mode) {
    detectTimer = false;
    state = [
      for (final stone in state)
        StoneInformation(
          id: stone.id,
          stoneColor: stone.stoneColor,
          visiblity: false,
          correctCount: checkBlackOrWhite(mode, stone.stoneColor),
          boxColor: Colors.lightGreen,
        )
    ];
  }

  void hideAllStonesWithTimer(String mode, int time) async {
    if (time != 0) {
      detectTimer = true;
      await Future.delayed(
        Duration(seconds: time),
        () {
          if (detectTimer) {
            state = [
              for (final stone in state)
                StoneInformation(
                  id: stone.id,
                  stoneColor: stone.stoneColor,
                  visiblity: false,
                  correctCount: checkBlackOrWhite(mode, stone.stoneColor),
                  boxColor: Colors.lightGreen,
                )
            ];
            detectTimer = false;
          }
        },
      );
    }
  }

  // 石を非表示にする際に、タップなしで正解になるものをあらかじめ正解としてカウントするための関数
  bool checkBlackOrWhite(String mode, String stoneColor) {
    if (mode == 'onlyBlack' && stoneColor == 'white') {
      return true;
    } else if (mode == 'onlyWhite' && stoneColor == 'black') {
      return true;
    } else if (mode == 'empty' && stoneColor == 'empty') {
      return true;
    }
    return false;
  }

  void displayStone(String mode, String emptyMode, int stoneId) {
    state = [
      for (final stone in state)
        if (stone.id == stoneId && stone.visiblity == false)
          StoneInformation(
            id: stone.id,
            stoneColor: stone.stoneColor,
            visiblity: true,
            correctCount: checkTappedStone(mode, emptyMode, stone.stoneColor),
            boxColor: Colors.green,
          )
        else
          stone
    ];
  }

  bool checkTappedStone(String mode, String emptyMode, String color) {
    if (mode == 'onlyBlack' && color == 'black') {
      return true;
    } else if (mode == 'onlyWhite' && color == 'white') {
      return true;
    } else if (emptyMode == 'black' && color == 'black' ||
        emptyMode == 'white' && color == 'white') {
      return true;
    }
    return false;
  }

  void displayResult() {
    state = [
      for (final stone in state)
        if (stone.correctCount)
          StoneInformation(
            id: stone.id,
            stoneColor: stone.stoneColor,
            visiblity: true,
            correctCount: true,
            boxColor: Colors.lightGreen,
          )
        else
          StoneInformation(
            id: stone.id,
            stoneColor: stone.stoneColor,
            visiblity: true,
            correctCount: false,
            boxColor: Colors.red,
          ),
    ];
  }
}

final stoneProvider =
    StateNotifierProvider<StoneNotifier, List<StoneInformation>>(
  (ref) => StoneNotifier(),
);

// 正解数を監視するプロバイダー
final correctCountProvider = StateProvider<int>(
  (ref) {
    int countX = 0;
    final stoneInformation = ref.watch(stoneProvider);
    for (final stone in stoneInformation) {
      if (stone.correctCount == true) {
        countX++;
      }
    }
    return countX;
  },
);
