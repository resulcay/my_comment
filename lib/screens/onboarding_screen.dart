import 'package:flutter/material.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/extensions/media_query_extension.dart';
import 'package:my_comment/service/path_service.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../service/facebook_auth_service.dart';
import '../service/google_auth_service.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

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
                mainAxisSize: MainAxisSize.max,
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
                              onPressed: () {}, child: const Text('ÜYE OL'))
                        ],
                      ),
                      TextField(
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
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
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
                          onPressed: () {},
                          child: Text(
                            'Şifremi Unuttum',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      MaterialButton(
                          minWidth: double.infinity,
                          height: 45,
                          color: ColorConstants.warningColor,
                          onPressed: () {},
                          shape: const StadiumBorder(),
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
                                Provider.of<GoogleSignInProvider>(context,
                                        listen: false)
                                    .googleLogin();
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
