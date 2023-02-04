import 'package:aim2excel/Controllers/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeScreenController homeScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xffDCDDE0),
        body: IndexedStack(
          index: homeScreenController.currentIndex.value,
          children: homeScreenController.bottomBarScreenList,
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 30.0,
          currentIndex: homeScreenController.currentIndex.value,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Constants.redColor,
          onTap: (index) {
            homeScreenController.currentIndex.value = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Author",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorite",
            ),
          ],
        ),
      );
    });
  }
}
