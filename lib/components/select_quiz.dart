import 'package:flash64_native/components/memory64/selection.dart';
import 'package:flash64_native/components/mental_calc/selection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'global_components/appbar.dart';

class SelectQuiz extends ConsumerWidget {
  const SelectQuiz({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: const GlobalAppBar(),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Center(
                child: ElevatedButton(
                  child: const Text('Memory64'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Memory64Selection(),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: ElevatedButton(
                  child: const Text('フラッシュカウント'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MentalCalcSelection(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
