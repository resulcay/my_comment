import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../models/user_model.dart';

class FacebookAuthService {
  // Firebase Authentication nesnesidir.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Firebase Firestore nesnesidir.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Oturum açar.
  facebookLogin() async {
    final LoginResult loginResult = await FacebookAuth.instance.login(
      permissions: [
        'email',
        'public_profile',
      ],
    );
    if (loginResult.status == LoginStatus.success) {
      final OAuthCredential credential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Oturum başarılı ise verilen mail adresi firestore'da mevcut değilse oluşturur.
      await _auth.signInWithCredential(credential).then((cred) async {
        if (cred.user != null) {
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
        }
      });
    }
  }
}
