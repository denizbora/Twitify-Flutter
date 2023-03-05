import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitify/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) =>
        Get.off(() => const HomePage()));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(238, 174, 202, 1),
            Color.fromRGBO(148, 187, 233, 1)
          ])),
      child: const Center(child: Image(image: AssetImage("assets/images/logo.png"),width: 250,),),
    );
  }
}
