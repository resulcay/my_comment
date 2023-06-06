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
    );
  }
}
