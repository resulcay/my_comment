import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/models/user_model.dart';
import 'package:my_comment/screens/login_screen.dart';
import 'package:my_comment/service/email_auth_service.dart';
import 'package:my_comment/service/navigation_service.dart';
import 'package:provider/provider.dart';

import '../components/nav_bar.dart';
import '../service/path_service.dart';
import '../service/user_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: FirebaseService().getUserDetails(context),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LinearProgressIndicator();
            } else if (snapshot.hasData) {
              return const _ViewWidget();
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}

class _ViewWidget extends StatelessWidget {
  const _ViewWidget();

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return Scaffold(
      //     backgroundColor: ColorConstants.primaryVariant,
      body: SafeArea(
        child: PageView(
          controller: pageController,
          onPageChanged: (value) =>
              Provider.of<NavigationService>(context, listen: false)
                  .changePageIndex(value),
          children: const [
            First(),
            FlutterLogo(),
            Third(),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavBar(pageController: pageController),
    );
  }
}

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserService>(context).user!;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: SvgPicture.asset(
                    alignment: Alignment.centerLeft,
                    PathService.imagePathProvider('welcome.svg')),
              ),
              const Text(
                'Merhaba, ',
                style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Flexible(
                child: Text(
                  user.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 200,
            width: double.infinity,
            child: Card(
                color: ColorConstants.secondaryColor,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Bu ay; 10 film, 5 dizi ve 12 kitap bitirdiniz.',
                      style: TextStyle(
                          color: ColorConstants.pureWhite,
                          fontSize: 25,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}

class Third extends StatelessWidget {
  const Third({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserService>(context).user!;

    return Column(
      children: [
        Text(user.email),
        Text(user.id),
        ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Provider.of<NavigationService>(context, listen: false)
                  .changePageIndex(0);
            },
            child: const Text('EXIT')),
      ],
    );
  }
}
