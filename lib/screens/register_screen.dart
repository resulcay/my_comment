import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/extensions/media_query_extension.dart';
import 'package:flutter/material.dart';

import '../components/decorated_text_field.dart';
import '../components/info_snackbar.dart';
import '../service/email_auth_service.dart';
import '../service/auth_stream_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passRepeatController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    heightController.dispose();
    weightController.dispose();
    passwordController.dispose();
    passRepeatController.dispose();
  }

  void signUpUser() async {
    String result = await FirebaseService().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      height: int.tryParse(heightController.text) ?? 180,
      weight: int.tryParse(weightController.text) ?? 90,
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
    InfoSnackBar.showSnackBar('Şifreler Eşleşmiyor!', context);
  }

  showSnack(String res) {
    InfoSnackBar.showSnackBar(res, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(.9),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                width: context.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DecoratedTextField(
                      hintField: "Ad Soyad",
                      isObscured: false,
                      textFieldController: nameController,
                    ),
                    const SizedBox(height: 5),
                    DecoratedTextField(
                      hintField: "Boy(cm)",
                      isObscured: false,
                      textFieldController: heightController,
                      type: TextInputType.number,
                    ),
                    const SizedBox(height: 5),
                    DecoratedTextField(
                      hintField: "Kilo(kg)",
                      isObscured: false,
                      textFieldController: weightController,
                      type: TextInputType.number,
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
