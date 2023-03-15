import 'package:hooks_riverpod/hooks_riverpod.dart';

final startButtonProvider = StateProvider.autoDispose<bool>((ref) => true);
final answerFieldProvider = StateProvider.autoDispose<bool>((ref) => false);
final judgeProvider = StateProvider.autoDispose<bool>((ref) => false);


// start button  　一回押したら消える
// 答えfield　      startを押したら出現　答えるを押したら消える 
// answer button 　start押したら出現　答える押したら消える  →答えfieldと同じproviderで管理
// 答え表示        　答えるを押したら出現 
