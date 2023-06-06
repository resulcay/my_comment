import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_comment/components/info_snackbar.dart';
import 'package:my_comment/screens/onboarding_screen.dart';

import '../screens/home_screen.dart';

class AuthStreamController extends StatelessWidget {
  const AuthStreamController({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return const HomeScreen();
          } else if (snapshot.hasError) {
            return InfoSnackBar.showSnackBar("Bilinmeyen Hata!", context);
          } else {
            return const OnboardingScreen();
          }
        },
      ),
    );
  }
}
