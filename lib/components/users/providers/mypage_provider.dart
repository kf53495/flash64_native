import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash64_native/components/global_components/firebase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyPageNotifier extends StateNotifier<String> {
  MyPageNotifier() : super('null');

  void setData(uid) async {
    final refData = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('mental_calc')
        .doc('3')
        .get();
    state = refData.get('challenge').toString();
  }
}

final myPageProvider = StateNotifierProvider<MyPageNotifier, String>(
  (ref) => MyPageNotifier(),
);
