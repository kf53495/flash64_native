import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash64_native/components/global_components/firebase.dart';
import 'package:flash64_native/components/users/providers/mypage_provider.dart';
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
    final uid = ref.watch(currentUserProvider);
    final username = ref.watch(userInformationProvider);
    final db = ref.watch(dbProvider);
    final querySnapshot = db.doc(uid).collection('mental_calc').doc('3').get();
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
          Center(
            child: Text('挑戦数: ${ref.watch(mentalCalcProvider)[0]}'),
          ),
          Center(
            child: Text('クリア${ref.watch(mentalCalcProvider)[1]}'),
          )
        ],
      ),
    );
  }
}

void a(uid) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('mental_calc')
      .doc('3')
      .get();
  debugPrint(querySnapshot.toString());
}

// users memory64(colle) onlyBlack(doc) 16(colle) 2(doc){challenge, clear}