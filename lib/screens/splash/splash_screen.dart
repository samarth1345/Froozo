// import 'dart:js_util';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:froozo/screens/auth/sign_in_page.dart';
import 'package:froozo/screens/home/home_page.dart';
import 'package:froozo/utils/dimensions.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(Duration(seconds: 2), () => {Get.to(SignInPage())});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: animation,
              child: Center(
                  child: Image.asset(
                "assets/Images/logo1.png",
                width: Dimensions.splashImg,
              )),
            ),
            Center(
                child: Image.asset(
              "assets/Images/logo2.jpg",
              width: Dimensions.splashImg,
            )),
          ],
        ));
  }
}
