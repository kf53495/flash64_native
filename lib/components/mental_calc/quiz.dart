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
    return Scaffold(
      appBar: const GlobalAppBar(),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.yellow,
            alignment: Alignment.center,
            child: Text(
              ref.watch(numbersProvider).num.toString(),
              style: const TextStyle(fontSize: 50),
            ),
          ),
          if (ref.watch(judgeProvider))
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
                  style: const TextStyle(fontSize: 30),
                ),
              ],
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
            SizedBox(
              width: 100,
              height: 50,
              child: TextField(
                maxLength: 3,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[-0-9]'))
                ],
                onChanged: (value) {
                  ref.read(answerNumProvider.notifier).state = int.parse(value);
                  if (value == '') {
                    ref.read(answerNumProvider.notifier).state = 0;
                  }
                  ref.read(answerFieldProvider.notifier).state = true;
                },
              ),
            ),
          if (ref.watch(answerFieldProvider))
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ref.read(numbersProvider.notifier).result();
                  ref.read(answerFieldProvider.notifier).state = false;
                  ref.read(judgeProvider.notifier).state = true;
                },
                child: const Text('答える'),
              ),
            ),
          if (ref.watch(judgeProvider)) // 正誤判定をして、正解と不正解で表示するものを分ける
            Column(
              children: [
                if (ref.watch(numbersProvider).sum ==
                    ref.watch(answerNumProvider))
                  const Center(
                    child: Text(
                      '正解！',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                if (ref.watch(numbersProvider).sum !=
                    ref.watch(answerNumProvider))
                  const Center(
                    child: Text(
                      '残念！',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
              ],
            ),

          // 答えの値を監視して更新するための非表示のwidget
          Visibility(
            visible: false,
            child: Center(
              child: Text(ref.watch(answerNumProvider).toString()),
            ),
          ),
        ],
      ),
    );
  }
}
