// ignore_for_file: must_be_immutable

import 'package:emart/common_widgets/exit_dialog.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/views/cart_screen_view/cart_screen.dart';
import 'package:emart/views/category_screen_view/category_screen.dart';
import 'package:emart/views/home_screen_view/home_screen.dart';
import 'package:emart/controllers/home_controller.dart';
import 'package:emart/views/profile_screen_view/profile_screen.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({super.key});

  // init home controller
  var controller = Get.put(HomeController());

  var navbarItems = [
    BottomNavigationBarItem(icon: Image.asset(icHome, width: 26), label: home),
    BottomNavigationBarItem(
        icon: Image.asset(icCategories, width: 26), label: categories),
    BottomNavigationBarItem(icon: Image.asset(icCart, width: 26), label: cart),
    BottomNavigationBarItem(
        icon: Image.asset(icProfile, width: 26), label: profile),
  ];

  var navBody = const [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => exitDialog(context),
        );
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(
              () => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            selectedItemColor: redColor,
            items: navbarItems,
            backgroundColor: whiteColor,
            onTap: (newIndex) => controller.currentNavIndex.value = newIndex,
          ),
        ),
      ),
    );
  }
}
