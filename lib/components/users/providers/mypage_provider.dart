import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash64_native/components/global_components/firebase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyPageMentalCalcNotifier extends StateNotifier<List> {
  MyPageMentalCalcNotifier() : super([]);

  void setData(uid) async {
    final refData = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('mental_calc')
        .doc('3')
        .get();
    state = [refData.get('challenge'), refData.get('clear')];
  }
}

final mentalCalcProvider =
    StateNotifierProvider<MyPageMentalCalcNotifier, List>(
  (ref) => MyPageMentalCalcNotifier(),
);

class MyPageMemory64Notifier extends StateNotifier<List> {
  MyPageMemory64Notifier() : super([]);

  void setData(uid) async {
    final refData = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('memory64')
        .doc('empty')
        .get();
    state = [refData, 2];
  }
}

final memory64Provider = StateNotifierProvider<MyPageMemory64Notifier, List>(
  (ref) => MyPageMemory64Notifier(),
);
