import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_comment/models/user_model.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

  Future<void> googleLogin() async {
    await googleSignIn.signIn().then((value) async {
      if (value == null) return;

      await _firestore
          .collection('users')
          .doc(value.email)
          .get()
          .then((snap) async {
        if (snap.data() == null) {
          UserModel user = UserModel(id: 'llllllllllllll');

          await _firestore
              .collection('users')
              .doc(value.email)
              .set(user.toMap());
        }

        _user = value;
        final googleAuth = await value.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        notifyListeners();
      });
    });
  }

  Future<void> googleLogout() async => FirebaseAuth.instance.signOut();
}
