import 'package:hooks_riverpod/hooks_riverpod.dart';

final inputUsernameProvider = StateProvider.autoDispose<String>((ref) => '');
final inputEmailProvider = StateProvider.autoDispose<String>((ref) => '');
final inputPasswordProvider = StateProvider.autoDispose<String>((ref) => '');
final errorMessageProvider = StateProvider.autoDispose<String>((ref) => '');
