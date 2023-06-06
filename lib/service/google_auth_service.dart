import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_comment/models/user_model.dart';

class GoogleSignInProvider {
  final googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> googleLogin() async {
    await googleSignIn.signIn().then((value) async {
      if (value == null) return;

      final googleAuth = await value.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential cred =
          await FirebaseAuth.instance.signInWithCredential(credential);

      await _firestore
          .collection('users')
          .doc(value.email)
          .get()
          .then((snap) async {
        if (snap.data() == null) {
          UserModel user = UserModel(
            id: cred.user!.uid,
            name: value.displayName ?? 'Default Google Name',
            email: value.email,
            movieComments: [],
            showComments: [],
            bookComments: [],
          );
          await _firestore
              .collection('users')
              .doc(value.email)
              .set(user.toMap());
        }
      });
    });
  }
}
