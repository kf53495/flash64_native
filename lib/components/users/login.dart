import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash64_native/components/home.dart';
import 'package:flash64_native/components/users/providers/user_info.dart';
import 'package:flash64_native/components/users/providers/user_input.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../global_components/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends ConsumerWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                decoration: const InputDecoration(labelText: 'email'),
                onChanged: (String value) {
                  email = value;
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
                  password = value;
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
                child: const Text('Login'),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    final uid =
                        FirebaseAuth.instance.currentUser?.uid.toString();
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .get()
                        .then(
                      (DocumentSnapshot snapshot) {
                        ref.read(userInformationProvider.notifier).state =
                            snapshot.get('username');
                      },
                    );
                    if (context.mounted) {
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return const HomePage();
                          },
                        ),
                      );
                    }
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
