import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_comment/screens/register_screen.dart';
import 'package:my_comment/service/auth_stream_controller.dart';
import 'package:my_comment/service/email_auth_service.dart';
import 'package:my_comment/service/theme_service.dart';
import 'package:my_comment/service/user_service.dart';
import 'package:provider/provider.dart';

import 'service/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
    (_) {
      runApp(const MyApp());
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationService()),
        ChangeNotifierProvider(create: (_) => UserService()),
        ChangeNotifierProvider(create: (_) => FirebaseService()),
      ],
      child: MaterialApp(
        title: 'My Comment',
        debugShowCheckedModeBanner: false,
        theme: ThemeService.themeConfiguration(context),
        //  home: const AuthStreamController(),
        home: const RegisterScreen(),
      ),
    );
  }
}
