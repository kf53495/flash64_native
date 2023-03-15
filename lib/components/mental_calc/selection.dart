import 'package:flash64_native/components/mental_calc/providers/setting.dart';
import 'package:flash64_native/components/mental_calc/quiz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../global_components/appbar.dart';

class MentalCalcSelection extends ConsumerWidget {
  const MentalCalcSelection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const GlobalAppBar(),
      body: Column(
        children: [
          SizedBox(
            width: 200,
            child: DropdownButton<int>(
              items: [
                for (int i = 3; i < 13; i++)
                  DropdownMenuItem(
                    value: i,
                    child: Text('$i'),
                  )
              ],
              value: ref.watch(settiingNumProvider),
              onChanged: (int? value) {
                ref.read(settiingNumProvider.notifier).state = value!;
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              child: const Text('answer quiz'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MentalCalcQuiz(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
