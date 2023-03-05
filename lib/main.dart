import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitify/controllers/user_controller.dart';
import 'package:twitify/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UserController());
  runApp(GetMaterialApp(
    home: const SplashScreen(),
    debugShowCheckedModeBanner: false,
    title: "Twitify",
    theme: ThemeData(
      fontFamily: "Jost",
    ),
  ));
}
