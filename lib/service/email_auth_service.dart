import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_comment/models/user_model.dart';
import 'package:my_comment/screens/landing_screen.dart';

class FirebaseService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  getUserDetails() async {
    User currentUser = _auth.currentUser!;
    return await _firestore
        .collection('users')
        .doc(currentUser.email)
        .get()
        .then((value) {
      //  dynamic data = value.data();
      //  return UserModel.fromMap(data);
    });
  }

  // Future<List<DietModel>> getAllDiets() async {
  //   return await _firestore.collection('diets').get().then((value) {
  //     return value.docs.map((e) => DietModel.fromMap(e.data())).toList();
  //   });
  // }

  // getWorkoutByFilter(String filter) async {
  //   await _firestore
  //       .collection('workouts')
  //       .where('title', isEqualTo: filter)
  //       .get()
  //       .then((value) {
  //     List<WorkoutModel> models =
  //         value.docs.map((e) => WorkoutModel.fromMap(e.data())).toList();
  //     workouts = models;
  //     notifyListeners();
  //   });
  // }

  // updateWorkout({
  //   required UserModel user,
  //   Map<String, dynamic>? map,
  //   int? height,
  //   int? weight,
  //   String? name,
  // }) async {
  //   User currentUser = _auth.currentUser!;
  //   await _firestore.collection('users').doc(currentUser.email).update({
  //     'workoutInfo': map ?? user.workoutInfo,
  //     'height': height ?? user.height,
  //     'weight': weight ?? user.weight,
  //     'name': name ?? user.name,
  //   });
  // }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String repeatedPassword,
    required String name,
    required int height,
    required int weight,
  }) async {
    String res = 'Bilinmeyen Hata!';

    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          repeatedPassword.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        UserModel user = UserModel(id: 'llllllllllllllll');

        await _firestore
            .collection('users')
            .doc(cred.user!.email)
            .set(user.toMap());
        res = 'success';
      } else {
        res = 'Tüm alanları doldurun!';
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

  Future<String> loginUser(
      {required String email, required String password}) async {
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

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut().then((value) {
      _navigate(context);
    });
  }

  _navigate(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LandingScreen(),
        ));
  }
}
