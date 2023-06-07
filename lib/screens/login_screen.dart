import 'package:flutter/material.dart';
import 'package:my_comment/components/info_snackbar.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/extensions/media_query_extension.dart';
import 'package:my_comment/screens/register_screen.dart';
import 'package:my_comment/service/email_auth_service.dart';
import 'package:my_comment/service/path_service.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../service/facebook_auth_service.dart';
import '../service/google_auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscured = true;
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
      context: context,
      email: emailController.text,
      password: passwordController.text,
    );

    if (mounted) {
      showSnack(result);
    }
  }

  void showSnack(String res) {
    InfoSnackBar.showSnackBar(res, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: context.height,
            width: context.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                      width: context.width * .8,
                      PathService.imagePathProvider('my_comment.png')),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hesabınız yok mu?',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ),
                                );
                              },
                              child: const Text('ÜYE OL'))
                        ],
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.accessibility),
                          hintText: 'EMAİL',
                          hintStyle: const TextStyle(
                            letterSpacing: 3,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(width: 0)),
                          fillColor: ColorConstants.pureWhite.withOpacity(.7),
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: passwordController,
                        obscureText: isObscured,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscured = !isObscured;
                                });
                              },
                              icon: Icon(isObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          hintText: 'ŞİFRE',
                          hintStyle: const TextStyle(
                            letterSpacing: 3,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(width: 0)),
                          fillColor: ColorConstants.pureWhite.withOpacity(.7),
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            InfoSnackBar.showSnackBar(
                                'Ekran Tasarlanmadı', context);
                          },
                          child: Text(
                            'Şifremi Unuttum',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      MaterialButton(
                          minWidth: double.infinity,
                          height: 55,
                          color: ColorConstants.secondaryColor,
                          onPressed: () => loginUser(),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            'GİRİŞ YAP',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                      Row(
                        children: [
                          Expanded(
                            child: SignInButton(
                              Buttons.google,
                              text: 'Giriş Yap',
                              onPressed: () {
                                GoogleSignInProvider().googleLogin();
                              },
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: SignInButton(
                              Buttons.facebook,
                              text: 'Giriş Yap',
                              onPressed: () {
                                FacebookAuthService().facebookLogin();
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
