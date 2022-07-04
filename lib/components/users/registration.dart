import 'package:flash64_native/components/home.dart';
import 'package:flash64_native/components/users/providers/user_input.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../global_components/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registration extends ConsumerWidget {
  Registration({
    Key? key,
  }) : super(key: key);
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String email = ref.watch(inputEmailProvider);
    String password = ref.watch(inputPasswordProvider);
    String errorMessage = ref.watch(errorMessagePrivider);
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
                    final credential =
                        await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) {
                        return const HomePage();
                      }),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      errorMessage = 'No user found for that email.';
                    } else if (e.code == 'wrong-password') {
                      errorMessage = 'Wrong password provided for that user.';
                    } else {
                      errorMessage = e.code;
                    }
                  } catch (e) {
                    errorMessage = e.toString();
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
