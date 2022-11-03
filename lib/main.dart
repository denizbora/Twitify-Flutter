import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitify/screens/home_page.dart';

void main() {
  runApp(GetMaterialApp(
    home: const HomePage(),
    debugShowCheckedModeBanner: false,
    title: "Twitify",
    theme: ThemeData(
      fontFamily: "Jost",
    ),
  ));
}
