import 'package:flash64_native/components/memory64/providers/board_size.dart';
import 'package:flash64_native/components/memory64/providers/quiz_mode.dart';
import 'package:flash64_native/components/memory64/providers/stone_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final verificationProvider = StateProvider<bool>((ref) {
  final boardSize = ref.watch(boardSizeProvider);
  if (ref
          .watch(stoneProvider.notifier)
          .countCorrectStones(ref.watch(quizModeProvider)) ==
      boardSize * boardSize) {
    return true;
  } else {
    return false;
  }
});

final correctNumProvider = StateProvider<String>((ref) {
  final boardSize = ref.watch(boardSizeProvider);
  return '${ref.watch(stoneProvider.notifier).countCorrectStones(ref.watch(quizModeProvider))} / ${boardSize * boardSize}';
});
