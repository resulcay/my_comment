import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_comment/service/auth_stream_controller.dart';
import 'package:my_comment/service/theme_service.dart';
import 'package:my_comment/service/user_service.dart';
import 'package:provider/provider.dart';

import 'service/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Uygulamanın firebase ile iletişimini kurar.
  await Firebase.initializeApp();

  // Cihazı dik konuma getirir(portre modu).
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
    // Provider paketinin sağladığı classlar.
    return MultiProvider(
      providers: [
        // Navbar da her sayfa değiştiğinde bu class veriyi tutar.
        ChangeNotifierProvider(create: (_) => NavigationService()),
        // Uygulamanın tamamında kullanılacak kullanıcı nesnesini tutar.
        ChangeNotifierProvider(create: (_) => UserService()),
      ],
      child: MaterialApp(
        title: 'My Comment',
        debugShowCheckedModeBanner: false,
        theme: ThemeService.themeConfiguration(context),
        // Kullanıcı giriş ve çıkış yaptığında bu yapı devreye girer.
        home: const AuthStreamController(),
      ),
    );
  }
}
