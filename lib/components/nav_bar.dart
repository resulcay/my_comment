import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../service/navigation_service.dart';
import '../service/path_service.dart';

class NavBar extends StatelessWidget {
  final PageController pageController;
  const NavBar({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle: const TextStyle(fontSize: 17),
      type: BottomNavigationBarType.fixed,
      currentIndex: Provider.of<NavigationService>(context).pageIndex,
      onTap: (index) {
        Provider.of<NavigationService>(context, listen: false)
            .changePageIndex(index);

        pageController.animateToPage(index,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut);
      },
      items: [
        navBarItem('home', 'Akış'),
        navBarItem('fitness', 'Fitness'),
        navBarItem('diet', 'Diyet'),
        navBarItem('chart', 'İstatistik'),
        navBarItem('user', 'Profil'),
      ],
    );
  }
}

BottomNavigationBarItem navBarItem(String imagePath, String label) {
  return BottomNavigationBarItem(
    label: label,
    activeIcon: SizedBox(
      height: 45,
      child: Image.asset(PathService.imagePathProvider('$imagePath.png'),
          color: ColorConstants.primaryVariant),
    ),
    icon: SizedBox(
        height: 40,
        child: Image.asset(PathService.imagePathProvider('$imagePath.png'))),
  );
}
