import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_comment/components/info_snackbar.dart';
import 'package:my_comment/screens/login_screen.dart';
import '../screens/home_screen.dart';

class AuthStreamController extends StatelessWidget {
  const AuthStreamController({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Bekleme durumunda ekranın ortasında gösterilir.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            // Başarılı bir oturumda anasayfa ya yönlendirir.
            return const HomeScreen();
          } else if (snapshot.hasError) {
            // Hata durumunda altta gösterilir.
            return InfoSnackBar.showSnackBar("Bilinmeyen Hata!", context);
          } else {
            // Aksi bir durumda giriş yapma ekranına yönlendirir.
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
