import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash64_native/components/global_components/firebase.dart';
import 'package:flash64_native/components/select_quiz.dart';
import 'package:flash64_native/components/users/login.dart';
import 'package:flash64_native/components/users/my_page.dart';
import 'package:flash64_native/components/users/providers/user_info.dart';
import 'package:flash64_native/components/users/registration.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'global_components/appbar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(userInformationProvider);
    return Scaffold(
      appBar: const GlobalAppBar(),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: 200,
            height: 200,
            child: Text('こんにちは、$usernameさん'),
          ),
          SizedBox(
            width: double.infinity,
            child: Center(
              child: ElevatedButton(
                child: const Text('ログイン画面へ'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
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
                child: const Text('ユーザー登録へ'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Registration(),
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
                child: const Text('ログイン画面へ'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
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
                child: const Text('ログアウト'),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  ref.read(currentUserProvider.notifier).state = null;
                  ref.read(userInformationProvider.notifier).state = '';
                  if (context.mounted) {
                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) {
                          return const HomePage();
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Center(
              child: ElevatedButton(
                child: const Text('マイページ'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyPage(),
                    ),
                  );
                },
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              child: const Text('モード選択'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectQuiz(),
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
