import 'package:flash64_native/components/home.dart';
import 'package:flash64_native/components/users/providers/user_info.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../global_components/appbar.dart';
import 'package:flash64_native/components/memory64/providers/quiz_mode.dart';
import 'package:flash64_native/components/memory64/providers/stone_provider.dart';
import 'package:flash64_native/components/memory64/providers/time_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                    child: Text('$i個'),
                  )
              ],
              value: 12,
              onChanged: (int? value) {},
            ),
          ),
          Center(
            child: ElevatedButton(
              child: const Text('answer quiz'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
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
