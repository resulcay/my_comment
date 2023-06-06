import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_comment/models/user_model.dart';
import 'package:my_comment/screens/login_screen.dart';
import 'package:my_comment/service/email_auth_service.dart';
import 'package:my_comment/service/navigation_service.dart';
import 'package:provider/provider.dart';

import '../components/nav_bar.dart';
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
              return const Center(child: CircularProgressIndicator());
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
    UserModel? user = Provider.of<UserService>(context).user;

    if (user != null) {
      return Center(
        child: Column(
          children: [
            Text(user.id),
            Text(user.name),
            Text(user.email),
            Text(user.movieComments.toString()),
            Text(user.showComments.toString()),
            Text(user.bookComments.toString()),
          ],
        ),
      );
    } else {
      return Center(
          child: Container(
        height: 100,
        width: 100,
        color: Colors.lightGreenAccent,
      ));
    }
  }
}

class Third extends StatelessWidget {
  const Third({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Provider.of<NavigationService>(context, listen: false)
                .changePageIndex(0);
          },
          child: const Text('EXIT')),
    );
  }
}
