import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';
import '../widgets/signed_in_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserController _controller = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    _controller.usr.isLogin.value = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(238, 174, 202, 1),
          Color.fromRGBO(148, 187, 233, 1)
        ])),
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: _controller.usr.isLogin,
            builder: (context, counterValue,child){
              return counterValue ? const SignedInWidget()
                  : Container(
                padding: const EdgeInsets.all(20),
                width: Get.width * 0.7,
                height: Get.height * 0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromRGBO(
                        244, 107, 167, 0.24413515406162467)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/logo.png"))),
                    ),
                    Column(
                      children: const [
                        Text(
                          "Twitify",
                          style: TextStyle(fontSize: 22, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Spotify'da çalmakta olan müziğinizi Twitter biyografinizde gösterir.",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _controller.login();
                        });
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
                              FontAwesome5.twitter,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Twitter ile giriş yap",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          )
              ,
        ),
      ),
    );
  }
}
