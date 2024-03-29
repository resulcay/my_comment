import 'package:flutter_svg/svg.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/extensions/media_query_extension.dart';
import 'package:flutter/material.dart';
import 'package:my_comment/service/auth_stream_controller.dart';
import 'package:my_comment/service/path_service.dart';

import '../components/decorated_text_field.dart';
import '../components/info_snackbar.dart';
import '../service/email_auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passRepeatController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passRepeatController.dispose();
  }

  void signUpUser() async {
    String result = await EmailAuthService().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      repeatedPassword: passRepeatController.text,
      name: nameController.text,
    );

    if (result != 'success') {
      showSnack(result);
    } else if (passwordController.text != passRepeatController.text) {
      snackPassword();
    } else {
      navigate();
    }
  }

  navigate() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const AuthStreamController(),
      ),
    );
  }

  snackPassword() {
    if (mounted) {
      InfoSnackBar.showSnackBar('Şifreler Eşleşmiyor!', context);
    }
  }

  showSnack(String res) {
    if (mounted) {
      InfoSnackBar.showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.pureWhite,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                height: context.height,
                width: context.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 200,
                      child: SvgPicture.asset(
                          PathService.imagePathProvider('register.svg')),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        DecoratedTextField(
                          hintField: "Ad Soyad",
                          isObscured: false,
                          textFieldController: nameController,
                        ),
                        const SizedBox(height: 5),
                        DecoratedTextField(
                          hintField: "E-mail",
                          isObscured: false,
                          textFieldController: emailController,
                        ),
                        const SizedBox(height: 5),
                        DecoratedTextField(
                            hintField: "Şifre",
                            isObscured: true,
                            textFieldController: passwordController),
                        const SizedBox(height: 5),
                        DecoratedTextField(
                            hintField: "Şifre Tekrar",
                            isObscured: true,
                            textFieldController: passRepeatController),
                        const SizedBox(height: 5),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: ColorConstants.primaryColor,
                          foregroundColor: ColorConstants.primaryVariant,
                          fixedSize: const Size(double.infinity, 60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          side: const BorderSide(width: 1, color: Colors.grey),
                        ),
                        onPressed: () => signUpUser(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'KAYIT OL',
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
      ),
    );
  }
}
