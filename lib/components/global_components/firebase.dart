import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final uid = FirebaseAuth.instance.currentUser?.uid;
final db = FirebaseFirestore.instance.collection('users').doc(uid);
