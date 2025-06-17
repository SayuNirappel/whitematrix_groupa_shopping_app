import 'package:flutter/material.dart';
//import 'package:iconsax/iconsax.dart';
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
          selectedItemColor: bnavController.currentIndex == 3
              ? Colors.amber.shade500
              : bnavController.currentIndex == 1
                  ? Colors.green
                  : Color(0xFFE91E63), // Myntra pink
          unselectedItemColor: Colors.grey[600],
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 11,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            bnavController.setIndex(value);
          },
          items: [
            _bNavBarItems(
                passedlabel: "Home",
                passedIcon: Text(
                  "   M   ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE91E63),
                      fontSize: 20),
                )),
            _bNavBarItems(
                passedlabel: "Under#999",
                passedIcon: Text(
                  "  fwd  ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                      fontSize: 20),
                )),
            _bNavBarItems(
                passedlabel: "in 30 min",
                passedIcon: Text(
                  "MNow",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE91E63),
                      fontSize: 18),
                )),
            _bNavBarItems(
                passedlabel: "Luxuary",
                passedIcon: Text(
                  "  LUX  ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.amber.shade500,
                      fontSize: 20),
                )),
            _bNavBarItems(
                passedlabel: "Bag",
                passedIcon: Icon(
                  Icons.shopping_bag_outlined,
                  size: 30,
                )),
          ]),
    );
  }

  BottomNavigationBarItem _bNavBarItems(
      {required String passedlabel, required Widget passedIcon}) {
    return BottomNavigationBarItem(
        icon: passedIcon,
        label: passedlabel,
        activeIcon: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              passedlabel == "Under#999"
                  ? Colors.green.shade900
                  : passedlabel == "Luxuary"
                      ? Colors.amber.shade500
                      : Color(0xFFE91E63),
              Colors.white
            ], stops: [
              0.1,
              0.3
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: passedIcon));
  }
}
