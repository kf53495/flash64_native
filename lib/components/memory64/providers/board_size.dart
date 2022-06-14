import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// class BoardSizeNotifier extends StateNotifier<int> {
//   BoardSizeNotifier() : super(0);

//   void size() => state;
// }

final boardSizeProvider = StateProvider<int>((ref) => 3);
