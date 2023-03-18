import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash64_native/components/global_components/firebase.dart';
import 'package:flash64_native/components/mental_calc/providers/answer_num.dart';
import 'package:flash64_native/components/mental_calc/providers/manage_num.dart';
import 'package:flash64_native/components/mental_calc/providers/setting.dart';
import 'package:flash64_native/components/mental_calc/providers/visiblity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../global_components/appbar.dart';

class MentalCalcQuiz extends ConsumerWidget {
  const MentalCalcQuiz({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setting = ref.watch(settiingNumProvider);
    final uid = ref.watch(currentUserProvider);
    bool verification =
        ref.watch(numbersProvider).sum == ref.watch(answerNumProvider);

    return Scaffold(
      appBar: const GlobalAppBar(),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.yellow,
            alignment: Alignment.center,
            child: Visibility(
              visible: ref.watch(numbersProvider).num < 9999,
              child: Text(
                ref.watch(numbersProvider).num.toString(),
                style: TextStyle(
                  fontSize: 50,
                  color: ref.watch(numbersProvider).numColor,
                ),
              ),
            ),
          ),
          if (ref.watch(startButtonProvider))
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // settingNumProviderに保存された数値の回数だけ数字を表示する
                  ref
                      .read(numbersProvider.notifier)
                      .timer(ref.read(settiingNumProvider));
                  ref.read(startButtonProvider.notifier).state = false;
                  ref.read(answerFieldProvider.notifier).state = true;
                },
                child: const Text('START'),
              ),
            ),
          if (ref.watch(answerFieldProvider))
            Column(
              children: [
                SizedBox(
                  width: 100,
                  height: 50,
                  child: TextField(
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[-0-9]'))
                    ],
                    onChanged: (value) {
                      if (value.isEmpty || value == '-') {
                        ref.read(answerNumProvider.notifier).state = 0;
                      } else {
                        ref.read(answerNumProvider.notifier).state =
                            int.parse(value);
                      }
                      ref.read(answerFieldProvider.notifier).state = true;
                    },
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      ref.read(numbersProvider.notifier).result();
                      ref.read(answerFieldProvider.notifier).state = false;
                      ref.read(judgeProvider.notifier).state = true;
                      answerProcess(setting.toString(), uid, verification);
                    },
                    child: const Text('答える'),
                  ),
                ),
              ],
            ),
          if (ref.watch(judgeProvider)) // 正誤判定をして、正解と不正解で表示するものを分ける
            Column(
              children: [
                Column(
                  children: [
                    Text(
                      'あなたの答え: ${ref.watch(answerNumProvider)}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const Text(
                      '結果',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      ref.watch(numbersProvider).sum.toString(),
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                if (verification)
                  const Center(
                    child: Text(
                      '正解！',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                if (!verification)
                  const Center(
                    child: Text(
                      '残念！',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(numbersProvider.notifier).retry();
                      ref.read(answerNumProvider.notifier).state = 0;
                      ref.read(startButtonProvider.notifier).state = true;
                      ref.read(judgeProvider.notifier).state = false;
                    },
                    child: const Text('リトライ'),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// FireStoreに保存する記述
void answerProcess(String setting, String? uid, bool verification) async {
  try {
    if (uid != null) {
      await db.doc(uid).collection('mental_calc').doc(setting).set({
        'challenge': FieldValue.increment(1),
      }, SetOptions(merge: true));
      if (verification) {
        await db.doc(uid).collection('mental_calc').doc(setting).set({
          'clear': FieldValue.increment(1),
        }, SetOptions(merge: true));
      }
    }
    if (uid == null) {
      debugPrint('ログアウトちゅ');
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}
