import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_groupa_shopping_app/controllers/bottom_nav_bar_controller.dart';
import 'package:whitematrix_groupa_shopping_app/services/api/api_constants.dart';
import 'package:whitematrix_groupa_shopping_app/utils/constants/color_constants.dart';
import 'package:whitematrix_groupa_shopping_app/views/home/home_screen.dart';
import 'package:whitematrix_groupa_shopping_app/views/shoppingbag/shoppingbag.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bnavController = Provider.of<BottomNavBarController>(context);

    List<Widget> screens = [
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
      HomeScreen(),
      Shoppingbag2(
        userIdddd: ApiConstants.userID.toString(),
        BearerToken: ApiConstants.token.toString(),
      )
    ];

    return Scaffold(
      body: screens[bnavController.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorConstants.bnavpink,
        currentIndex: bnavController.currentIndex,
        onTap: bnavController.setIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        selectedItemColor: _getColor(bnavController.currentIndex),
        unselectedItemColor: Colors.black,
        items: [
          _navItem(
              "Home",
              0,
              bnavController.currentIndex,
              Text("M",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: ColorConstants.mynthraPink))),
          _navItem("Under₹999", 1, bnavController.currentIndex,
              Icon(Icons.local_offer_outlined, size: 22)),
          _navItem("in 30 min", 2, bnavController.currentIndex,
              Icon(Icons.flash_on_rounded, size: 22)),
          _navItem("Luxuary", 3, bnavController.currentIndex,
              Icon(Icons.workspace_premium, size: 24)),
          _navItem("Bag", 4, bnavController.currentIndex,
              Icon(Icons.shopping_bag_outlined, size: 30)),
        ],
      ),
    );
  }

  /// Returns correct color based on index
  static Color _getColor(int index) {
    if (index == 1) return Colors.green.shade900;
    if (index == 3) return Colors.amber.shade400;
    return Color(0xFFE91E63); // Myntra Pink
  }

  /// Builds custom BottomNavigationBarItem with top indicator bar
  BottomNavigationBarItem _navItem(
      String label, int index, int currentIndex, Widget iconWidget) {
    final bool isSelected = currentIndex == index;
    final Color iconColor = isSelected ? _getColor(index) : Colors.black;

    return BottomNavigationBarItem(
      label: label,
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Top Indicator Bar
          Container(
            height: 4,
            width: 50,
            decoration: BoxDecoration(
              color: isSelected ? iconColor : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 4),

          /// Icon Widget
          IconTheme(
            data: IconThemeData(color: iconColor),
            child: iconWidget,
          ),
        ],
      ),
    );
  }
}
