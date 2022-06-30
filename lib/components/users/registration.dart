import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../global_components/appbar.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Registration extends ConsumerWidget {
  Registration({
    Key? key,
  }) : super(key: key);
  final _auth = FirebaseAuth.instance;
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  _email = value;
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
                  _password = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                child: const Text('create account'),
                onPressed: () async {
                  try {
                    final credential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _email,
                      password: _password,
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
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
