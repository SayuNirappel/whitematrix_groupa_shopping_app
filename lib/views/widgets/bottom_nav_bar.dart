import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/bottom_nav_bar_controller.dart';
import 'package:whitematrix_groupa_shopping_app/views/home/home_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/splash/splash_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bnavController = Provider.of<BottomNavBarController>(context);

    List screens = [
      HomeScreen(),
      SplashScreen(),
      HomeScreen(),
      SplashScreen(),
      HomeScreen()
    ];

    return Scaffold(
      body: screens[bnavController.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: bnavController.currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            bnavController.setIndex(value);
          },
          items: [
            _bNavBarItems(passedIcon: Icons.home),
            _bNavBarItems(passedIcon: Icons.search),
            _bNavBarItems(passedIcon: Icons.library_add),
            _bNavBarItems(passedIcon: Icons.reset_tv),
            _bNavBarItems(passedIcon: Icons.logout),
          ]),
    );
  }

  BottomNavigationBarItem _bNavBarItems({required IconData passedIcon}) {
    return BottomNavigationBarItem(
        icon: Icon(
          passedIcon,
          size: 30,
        ),
        label: "",
        activeIcon: Icon(
          passedIcon,
          size: 50,
        ));
  }
}
