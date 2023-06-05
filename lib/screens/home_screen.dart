import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:my_comment/constants/color_constants.dart';
import 'package:my_comment/models/user_model.dart';
import 'package:my_comment/screens/onboarding_screen.dart';
import 'package:my_comment/service/email_auth_service.dart';
import 'package:my_comment/service/navigation_service.dart';
import 'package:provider/provider.dart';

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
              return const ViewWidget();
            } else {
              return const OnboardingScreen();
            }
          },
        ),
      ),
    );
  }
}

class ViewWidget extends StatelessWidget {
  const ViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Scaffold(
        backgroundColor: ColorConstants.primaryVariant,
        body: SafeArea(
          child: PageView(
            controller: pageController,
            onPageChanged: (value) =>
                Provider.of<NavigationService>(context, listen: false)
                    .changePageIndex(value),
            children: const [
              OnboardingScreen(),
              FlutterLogo(),
              FlutterLogo(),
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          color: ColorConstants.primaryColor,
          backgroundColor: ColorConstants.primaryVariant,
          index: Provider.of<NavigationService>(context).pageIndex,
          onTap: (index) {
            Provider.of<NavigationService>(context, listen: false)
                .changePageIndex(index);

            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut);
          },
          items: const [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.feed,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              color: Colors.white,
            ),
          ],
        )

        // NavBar(pageController: pageController),
        );
  }
}
