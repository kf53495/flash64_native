import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math';

@immutable
class StoneInformation {
  const StoneInformation({
    required this.id,
    required this.stoneColor,
    required this.visiblity,
  });

  final int id;
  final bool stoneColor;
  final bool visiblity;

  // 以下の記述、不要(?)
  // 最後まで実装してエラーが起こらなければそのまま削除
  // StoneInformation copyWith({int? id, bool? stoneColor, bool? visiblity}) {
  //   return StoneInformation(
  //     id: id ?? this.id,
  //     stoneColor: stoneColor ?? this.stoneColor,
  //     visiblity: visiblity ?? this.visiblity,
  //   );
  // }
}

class StoneNotifier extends StateNotifier<List<StoneInformation>> {
  StoneNotifier() : super([]);
  int placementId = 1;

  void addStone() {
    for (int i = 0; i < 16; i++) {
      state = [
        ...state,
        StoneInformation(
          id: placementId,
          stoneColor: Random().nextBool(),
          visiblity: true,
        )
      ];
      placementId++;
    }
  }
}

final stoneProvider =
    StateNotifierProvider<StoneNotifier, List<StoneInformation>>(
  (ref) => StoneNotifier(),
);
