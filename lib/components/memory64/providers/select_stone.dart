import 'package:hooks_riverpod/hooks_riverpod.dart';

class Selected {
  const Selected({
    required this.black,
    required this.white,
  });
  final bool black;
  final bool white;
}

class SelectStoneNotifier extends StateNotifier<Selected> {
  SelectStoneNotifier() : super(const Selected(black: true, white: false));

  void selectBlack() {
    state = const Selected(black: true, white: false);
  }

  void selectWhite() {
    state = const Selected(black: false, white: true);
  }
}

final selectStoneProvider =
    StateNotifierProvider<SelectStoneNotifier, Selected>(
  (ref) => SelectStoneNotifier(),
);
