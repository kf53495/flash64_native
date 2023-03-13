import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash64_native/components/home.dart';
import 'package:flash64_native/components/users/providers/user_info.dart';
import 'package:flash64_native/components/users/providers/user_input.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../global_components/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyPage extends ConsumerWidget {
  MyPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const GlobalAppBar(),
      body: Container(
        child: Text('ユーザー画面です'),
      ),
    );
  }
}
