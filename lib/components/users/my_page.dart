import 'package:flash64_native/components/users/providers/user_info.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../global_components/appbar.dart';

class MyPage extends ConsumerWidget {
  const MyPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(userInformationProvider);
    return Scaffold(
      appBar: const GlobalAppBar(),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.amber,
            ),
            child: Text(
              username,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.cyan,
              ),
            ),
          ),
          const SizedBox(
            height: 200,
            width: 200,
          )
        ],
      ),
    );
  }
}
