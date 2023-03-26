import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// final uid = FirebaseAuth.instance.currentUser?.uid;
final db = FirebaseFirestore.instance.collection('users');

final currentUserProvider =
    StateProvider((ref) => FirebaseAuth.instance.currentUser?.uid);
final dbProvider =
    StateProvider((ref) => FirebaseFirestore.instance.collection('users'));
