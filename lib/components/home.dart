import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash64_native/components/users/login.dart';
import 'package:flash64_native/components/users/providers/user_info.dart';
import 'package:flash64_native/components/users/registration.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'global_components/appbar.dart';
import 'memory64/selection.dart';

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
                      builder: (context) => Login(),
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
                      builder: (context) => Registration(),
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
                      builder: (context) => Login(),
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
          Center(
            child: ElevatedButton(
              child: const Text('デザイン練習へ'),
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
        ],
      ),
    );
  }
}

Text _username() {
  final uid = FirebaseAuth.instance.currentUser?.email.toString();
  String useraaa = 'a';
  if (uid != null) {
    FirebaseFirestore.instance.collection('users').doc(uid).get().then(
      (DocumentSnapshot snapshot) {
        debugPrint(snapshot.get('username'));
        debugPrint(useraaa);
        useraaa = snapshot.get('username');
      },
    );
  }
  return Text('こんにちは、$useraaa');
}
