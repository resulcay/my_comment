import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_comment/service/navigation_service.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';

class CurvedNavBar extends StatelessWidget {
  const CurvedNavBar({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 60,
      color: ColorConstants.secondaryColor,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      index: Provider.of<NavigationService>(context).pageIndex,
      onTap: (index) {
        Provider.of<NavigationService>(context, listen: false)
            .changePageIndex(index);

        pageController.animateToPage(index,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut);
      },
      items: const [
        // Navigasyon kısmında gösterdiğimiz Widget yapılarıdır.
        Icon(
          Icons.home,
          color: Colors.white,
        ),
        Icon(
          Icons.movie,
          color: Colors.white,
        ),
        Icon(
          Icons.tv,
          color: Colors.white,
        ),
        Icon(
          Icons.menu_book,
          color: Colors.white,
        ),
      ],
    );
  }
}
