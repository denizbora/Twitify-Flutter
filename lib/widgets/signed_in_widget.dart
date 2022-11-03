import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class SignedInWidget extends StatefulWidget {
  const SignedInWidget({Key? key}) : super(key: key);

  @override
  State<SignedInWidget> createState() => _SignedInWidgetState();
}

class _SignedInWidgetState extends State<SignedInWidget> {
  final UserController _controller = Get.put(UserController());
  var tick = 10;
  @override
  void initState() {
    super.initState();
    countdown();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: Get.width * 0.7,
      height: Get.height * 0.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromRGBO(244, 107, 167, 0.24413515406162467)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                    image: NetworkImage(_controller.usr.profileImage!))),
          ),
          Column(
            children: [
              Text(
                _controller.usr.username!,
                style: const TextStyle(fontSize: 22, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                _controller.usr.newBio!,
                style: const TextStyle(fontSize: 15, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Text(
            '$tick Saniye sonra biyografiniz değişecek.',
            style: const TextStyle(fontSize: 15, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          InkWell(
            onTap: () {
              _controller.logout();
              _controller.usr.isLogin.value = false;
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: const Color(0XFF1da0f1),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Entypo.logout,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Çıkış yap",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  countdown() async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_controller.usr.isLogin.value == false) {
        timer.cancel();
      }
      if (tick == 0) {
        _controller.changeBio();
        setState(() {
          tick = 10;
        });
      }
      setState(() {
        tick--;
      });
    });
  }
}
