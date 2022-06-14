import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../global_components/appbar.dart';
import 'providers/board_size.dart';
import 'quiz.dart';

class Memory64Selection extends ConsumerWidget {
  const Memory64Selection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: GlobalAppBar(),
      body: Column(
        children: [
          Container(
            width: 200,
            child: DropdownButton(
              items: [
                for (int i = 1; i <= 5; i++)
                  DropdownMenuItem(
                    value: i * 4,
                    child: Text('${i + 4} × ${i + 4}'),
                  )
              ],
              onChanged: (int? value) {
                if (value != null) {
                  ref.watch(boardSizeProvider.notifier).state = value;
                }
              },
            ),
          ),
          const SizedBox(
            width: 100,
            height: 50,
            child: Placeholder(
              color: Colors.blueAccent,
            ),
          ),
          Center(
            child: ElevatedButton(
              child: const Text('answer quiz'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Memory64Quiz(boardSize: 16),
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
