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

  void hideAllStones() {
    detectTimer = false;
    state = [
      for (final stone in state)
        StoneInformation(
          id: stone.id,
          stoneColor: stone.stoneColor,
          visiblity: false,
          correctCount: false,
          boxColor: Colors.lightGreen,
        )
    ];
  }

  void hideAllStonesWithTimer(time) async {
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
                  correctCount: false,
                  boxColor: Colors.lightGreen,
                )
            ];
            detectTimer = false;
          }
        },
      );
    }
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
            boxColor: Colors.lightGreen,
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

  // Answer時に、非表示になっている石の正誤を確かめる
  void checkUntappedStones(String mode) {
    state = [
      for (final stone in state)
        if (stone.visiblity == false)
          if (mode == 'onlyBlack' && stone.stoneColor == 'white')
            StoneInformation(
              id: stone.id,
              stoneColor: stone.stoneColor,
              visiblity: true,
              correctCount: true,
              boxColor: Colors.lightGreen,
            )
          else if (mode == 'onlyWhite' && stone.stoneColor == 'black')
            StoneInformation(
              id: stone.id,
              stoneColor: stone.stoneColor,
              visiblity: true,
              correctCount: true,
              boxColor: Colors.lightGreen,
            )
          else if (stone.stoneColor == 'empty')
            StoneInformation(
              id: stone.id,
              stoneColor: stone.stoneColor,
              visiblity: true,
              correctCount: true,
              boxColor: Colors.lightGreen,
            )
          else
            stone
        else
          stone
    ];
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

  // 正解数を表示する関数
  int countCorrectStones(mode) {
    int count = 0;
    for (final stone in state) {
      if (stone.correctCount) count++;
    }
    return count;
  }
}

final stoneProvider =
    StateNotifierProvider<StoneNotifier, List<StoneInformation>>(
  (ref) => StoneNotifier(),
);
