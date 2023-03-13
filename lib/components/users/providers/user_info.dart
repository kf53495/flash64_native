import 'package:hooks_riverpod/hooks_riverpod.dart';

final userInformationProvider = StateProvider.autoDispose<String>((ref) => '');
