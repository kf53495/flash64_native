import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash64_native/components/users/login.dart';
import 'package:flash64_native/components/users/registration.dart';
import 'package:flutter/material.dart';
import 'global_components/appbar.dart';
import 'memory64/selection.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(),
      body: Column(
        children: [
          const SizedBox(
            width: 100,
            height: 50,
            child: Placeholder(
              color: Colors.blueAccent,
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
                child: const Text('ユーザー登録へ'),
                onPressed: () {
                  final uid = FirebaseAuth.instance.currentUser?.uid.toString();
                  if (uid != null) {
                    debugPrint(uid);
                    debugPrint('ok');
                  } else {
                    debugPrint('userなし');
                  }
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
