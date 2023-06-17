import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:my_comment/components/info_snackbar.dart';
import '../models/user_model.dart';

class FacebookAuthService {
  // Firebase Authentication nesnesidir.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Firebase Firestore nesnesidir.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Oturum açar.
  Future facebookLogin(BuildContext context) async {
    try {
      // Facebook oturum pop up'ı kapandığında verilen sonucu döndürür.
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: [
          'email',
          'public_profile',
        ],
      );
      // Sonuç başarılı ise bu koşula girer.
      if (loginResult.status == LoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        // Verilen mail adresi veritabanında mevcut değilse oluşturur.
        await _auth.signInWithCredential(credential).then((cred) async {
          await _firestore
              .collection('users')
              .doc(cred.user!.email)
              .get()
              .then((snap) async {
            if (snap.data() == null) {
              UserModel user = UserModel(
                id: cred.user!.uid,
                name: cred.user!.displayName ?? 'Default Facebook User',
                email: cred.user!.email!,
                movieComments: [],
                showComments: [],
                bookComments: [],
              );

              await _firestore
                  .collection('users')
                  .doc(cred.user!.email)
                  .set(user.toMap());
            }
          });
        });
      }
    } catch (e) {
      InfoSnackBar.showSnackBar(
          'Bu mail ile oturum açarken bir hata oluştu', context);
    }
  }
}
