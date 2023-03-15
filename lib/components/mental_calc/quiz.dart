import 'package:flash64_native/components/mental_calc/providers/answer.dart';
import 'package:flash64_native/components/mental_calc/providers/manage_num.dart';
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
    bool startButton = true;

    return Scaffold(
      appBar: const GlobalAppBar(),
      body: Column(
        children: [
          Center(
            child: Text(
              ref.watch(numbersProvider).num.toString(),
              style: const TextStyle(fontSize: 30),
            ),
          ),
          const Center(
            child: Text(
              '結果',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Center(
            child: Text(
              ref.watch(numbersProvider).sum.toString(),
              style: const TextStyle(fontSize: 30),
            ),
          ),
          if (startButton)
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ref.read(numbersProvider.notifier).timer();
                  startButton = false;
                },
                child: const Text('START'),
              ),
            ),
          SizedBox(
            width: 100,
            height: 50,
            child: TextField(
              maxLength: 3,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                if (value != '') {
                  ref.read(answerProvider.notifier).state = int.parse(value);
                } else {
                  ref.read(answerProvider.notifier).state = 0;
                }
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                ref.read(numbersProvider.notifier).result();
              },
              child: const Text('結果を見る'),
            ),
          ),
          if (ref.watch(numbersProvider).sum == ref.watch(answerProvider))
            const Center(
              child: Text(
                '正解！',
                style: TextStyle(fontSize: 30),
              ),
            ),
          if (ref.watch(numbersProvider).sum != ref.watch(answerProvider))
            const Center(
              child: Text(
                '残念！',
                style: TextStyle(fontSize: 30),
              ),
            ),
        ],
      ),
    );
  }
}
