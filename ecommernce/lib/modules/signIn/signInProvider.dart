import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommernce/cache/sharedPreferences.dart';
import 'package:provider/provider.dart';

class signInProvider extends ChangeNotifier {
  static signInProvider getWatch(BuildContext context) {
    //print("watch");
    return context.watch<signInProvider>();
  }

  static signInProvider getRead(BuildContext context) {
    //print("read");
    return context.read<signInProvider>();
  }

  final FirebaseAuth firebaseAuth;

  signInProvider(this.firebaseAuth);

  Stream<User?> get authStateChenges {
    return firebaseAuth.authStateChanges();
  }

  Future<String> signIn({String? email, String? password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email!, password: password!);
      sharedPreferences.setEmail(email);
      sharedPreferences.setPassword(password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<String> signUp({String? email, String? password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      CollectionReference ref = FirebaseFirestore.instance.collection("users");
      ref.doc(email).set({"email": email, "password": password});
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }
}
