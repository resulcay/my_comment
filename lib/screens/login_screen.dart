import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/extensions/media_query_extension.dart';
import 'package:flutter/material.dart';

import '../components/decorated_text_field.dart';
import '../components/info_snackbar.dart';
import '../service/email_auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    String result = await FirebaseService().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    if (result == 'success') {
      navigateToMain();
    } else {
      showSnack(result);
    }
  }

  void navigateToMain() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  void showSnack(String res) {
    InfoSnackBar.showSnackBar(res, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(.9),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              width: context.width,
              height: context.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DecoratedTextField(
                    hintField: "E-mail",
                    isObscured: false,
                    textFieldController: emailController,
                  ),
                  const SizedBox(height: 20),
                  DecoratedTextField(
                    hintField: "Şifre",
                    isObscured: true,
                    textFieldController: passwordController,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: ColorConstants.primaryColor,
                        foregroundColor: ColorConstants.primaryVariant,
                        fixedSize: const Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        side: const BorderSide(width: 1, color: Colors.grey),
                      ),
                      onPressed: () => loginUser(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'OTURUM AÇ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .apply(
                                      color: ColorConstants.pureWhite,
                                      fontWeightDelta: 1,
                                      fontSizeDelta: 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
