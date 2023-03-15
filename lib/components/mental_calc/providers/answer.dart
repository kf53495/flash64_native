import 'package:hooks_riverpod/hooks_riverpod.dart';

final answerProvider = StateProvider.autoDispose<int>((ref) => 0);
