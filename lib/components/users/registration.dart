import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash64_native/components/home.dart';
import 'package:flash64_native/components/users/providers/user_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../global_components/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registration extends ConsumerWidget {
  Registration({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String username = ref.watch(inputUsernameProvider);
    String email = ref.watch(inputEmailProvider);
    String password = ref.watch(inputPasswordProvider);
    String errorMessage = ref.watch(errorMessageProvider);
    return Scaffold(
      appBar: const GlobalAppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: const InputDecoration(labelText: 'username'),
                onChanged: (String value) {
                  ref.read(inputUsernameProvider.notifier).state = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: const InputDecoration(labelText: 'email'),
                onChanged: (String value) {
                  ref.read(inputEmailProvider.notifier).state = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: const InputDecoration(labelText: 'password'),
                obscureText: true,
                maxLength: 20,
                onChanged: (String value) {
                  ref.read(inputPasswordProvider.notifier).state = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(errorMessage),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                child: const Text('create account'),
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc()
                        .set({
                      'username': username,
                      'email': email,
                      'password': password
                    });

                    await Future.delayed(const Duration(seconds: 1));
                    if (context.mounted) return; //表記が正しいかわからないため後日検討(3/11)
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return const HomePage();
                      }),
                    );
                  } on FirebaseAuthException catch (e) {
                    ref.read(errorMessageProvider.notifier).state = e.message!;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
