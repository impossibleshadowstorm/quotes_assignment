import 'package:aim2excel/Controllers/home_screen_controller.dart';
import 'package:aim2excel/Screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox("fav_quotes");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Aim 2 Excel',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
