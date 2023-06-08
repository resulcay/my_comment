import 'package:flutter/material.dart';
import 'package:my_comment/components/nav_bar.dart';
import 'package:my_comment/screens/book_screen.dart';
import 'package:my_comment/screens/feed_screen.dart';
import 'package:my_comment/screens/login_screen.dart';
import 'package:my_comment/screens/show_screen.dart';
import 'package:my_comment/service/firebase_service.dart';
import 'package:my_comment/screens/movie_screen.dart';
import 'package:my_comment/service/navigation_service.dart';
import 'package:provider/provider.dart';

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
      body: SafeArea(
        child: PageView(
          controller: pageController,
          onPageChanged: (value) =>
              Provider.of<NavigationService>(context, listen: false)
                  .changePageIndex(value),
          children: const [
            FeedScreen(),
            MovieScreen(),
            ShowScreen(),
            BookScreen(),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavBar(pageController: pageController),
    );
  }
}
