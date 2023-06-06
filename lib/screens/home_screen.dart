import 'package:flutter/material.dart';
import 'package:my_comment/models/user_model.dart';
import 'package:my_comment/screens/onboarding_screen.dart';
import 'package:my_comment/service/email_auth_service.dart';
import 'package:my_comment/service/navigation_service.dart';
import 'package:provider/provider.dart';

import '../components/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => {
          FirebaseService().getUserDetails().then((value) => {
                Provider.of<UserModel>(context, listen: false)
                    .copyWith(id: 'aaaaaaaaaaaaaaa')
              })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: FirebaseService().getUserDetails(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return const _ViewWidget();
            } else {
              return const OnboardingScreen();
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
            FlutterLogo(),
            FlutterLogo(),
            FlutterLogo(),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavBar(pageController: pageController),
    );
  }
}
