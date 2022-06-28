import 'package:flash64_native/components/memory64/providers/quiz_mode.dart';
import 'package:flash64_native/components/memory64/providers/stone_provider.dart';
import 'package:flash64_native/components/memory64/providers/time_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../global_components/appbar.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Login extends ConsumerWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const GlobalAppBar(),
      body: Column(
        children: [
          SizedBox(
            width: 100,
            height: 50,
            child: TextField(
              maxLength: 2,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                ref.read(timeProvider.notifier).state = value;
                if (value == '') {
                  ref.read(timeProvider.notifier).state = '0';
                }
              },
            ),
          ),
          SizedBox(
            width: 100,
            height: 50,
            child: TextField(
              maxLength: 2,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) {
                ref.read(timeProvider.notifier).state = value;
                if (value == '') {
                  ref.read(timeProvider.notifier).state = '0';
                }
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              child: const Text('answer quiz'),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

// try {
//   final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: emailAddress,
//     password: password
//   );
// } on FirebaseAuthException catch (e) {
//   if (e.code == 'user-not-found') {
//     print('No user found for that email.');
//   } else if (e.code == 'wrong-password') {
//     print('Wrong password provided for that user.');
//   }
// }