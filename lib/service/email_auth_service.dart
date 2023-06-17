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
    // Varsayılan hata bilgilendirme mesajıdır.
    String res = 'Bilinmeyen Hata!';

    try {
      // Parametrelerin boş olmama ve şifrelerim aynı olması şartlarını koştuğumuz yerdir.
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          repeatedPassword.isNotEmpty &&
          name.isNotEmpty &&
          (password == repeatedPassword)) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Varsayılan kullanıcı modelidir.
        UserModel user = UserModel(
          id: cred.user!.uid,
          name: name,
          email: email,
          movieComments: [],
          showComments: [],
          bookComments: [],
        );

        // Bu kullanıcıyı olduğu değerlerle veritabanına kaydeder.
        await _firestore
            .collection('users')
            .doc(cred.user!.email)
            .set(user.toMap());
        // Durum başarılı demektir.
        res = 'success';
      } else {
        if (password != repeatedPassword) {
          res = 'Şifreler Eşleşmiyor';
        } else {
          res = 'Tüm alanları doldurun!';
        }
      }

      // Bu istisna ortaya çıktığında bilgilendirme mesajını düzenlediğimiz yerdir.
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'Email formatı hatalı!';
      } else if (err.code == 'weak-password') {
        res = 'Şifre en az 6 karakterden oluşmalı!';
      }
    } catch (err) {
      res = err.toString();
    }
    // Bilgilendirme mesajını döndürür.
    return res;
  }

// Oturum açar.
  Future<String> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    // Varsayılan hata bildirme metnidir.
    String res = "Bilinmeyen Hata";

    try {
      // Metinler boş değilse bu koşul sağlanır.
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Tüm alanları doldurun!";
      }
      // Bu istisna ortaya çıktığında bilgilendirme mesajını düzenlediğimiz yerdir.
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        res = 'Kullanıcı bulunamadı!';
      } else if (err.code == 'wrong-password') {
        res = 'Hatalı Şifre';
      }
    } catch (err) {
      res = err.toString();
    }

    // Bilgilendirme mesajını döndürür.
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
