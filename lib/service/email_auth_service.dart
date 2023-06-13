import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_comment/models/user_model.dart';
import 'package:my_comment/service/auth_stream_controller.dart';

class EmailAuthService {
  // Firebase Authentication nesnesidir.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Firebase Firestore nesnesidir.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Kullanıcıyı verilen parametreleri kullanarak kayıt eder.
  Future<String> signUpUser({
    required String email,
    required String password,
    required String repeatedPassword,
    required String name,
  }) async {
    String res = 'Bilinmeyen Hata!';

    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          repeatedPassword.isNotEmpty &&
          name.isNotEmpty &&
          (password == repeatedPassword)) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        UserModel user = UserModel(
          id: cred.user!.uid,
          name: name,
          email: email,
          movieComments: [],
          showComments: [],
          bookComments: [],
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.email)
            .set(user.toMap());
        res = 'success';
      } else {
        if (password != repeatedPassword) {
          res = 'Şifreler Eşleşmiyor';
        } else {
          res = 'Tüm alanları doldurun!';
        }
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'Email formatı hatalı!';
      } else if (err.code == 'weak-password') {
        res = 'Şifre en az 6 karakterden oluşmalı!';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

// Oturum açar.
  Future<String> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    String res = "Bilinmeyen Hata";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Tüm alanları doldurun!";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        res = 'Kullanıcı bulunamadı!';
      } else if (err.code == 'wrong-password') {
        res = 'Hatalı Şifre';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

// Çıkış yapar.
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut().then((value) {
      _navigate(context);
    });
  }

// Kullanıcı oturum durumu için bu yapıya yönlendirir.
  _navigate(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthStreamController(),
        ));
  }
}
