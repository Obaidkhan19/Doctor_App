// ignore_for_file: unused_element

import 'dart:async';

import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:doctormobileapplication/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/localDB/local_db.dart';
import '../dashboard/menu_drawer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 3500), () async {
      bool? isFirstStatus = await LocalDb().getIsFirstTime();
      bool? LoginStatus = await LocalDb().getLoginStatus();
      if (isFirstStatus != null &&
          isFirstStatus != '' &&
          isFirstStatus == false) {
        //Goto Login Screen or dashboard screen
        if (LoginStatus == true) {
          Get.offAll(() => const DrawerScreen());
          //    Get.to(() => const DrawerScreen());
        } else {
          Get.offAll(() => const LoginScreen());
        }
      } else {
        Get.offAll(() => const WelcomeScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          top: 100,
          right: 0,
          child: Container(
            height: Get.height * 0.8,
            width: Get.width,
            alignment: Alignment.centerLeft,
            child: Image.asset(
              Images.logoBackground,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SlideTransitions(
          image: Center(child: Image.asset(Images.logo)),
        )
      ],
    ));
  }
}

class SlideTransitions extends StatefulWidget {
  final Widget? image;
  const SlideTransitions({super.key, this.image});

  @override
  State<SlideTransitions> createState() => _SlideTransitionsState();
}

class _SlideTransitionsState extends State<SlideTransitions>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 30),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Padding(padding: const EdgeInsets.all(8.0), child: widget.image),
    );
  }
}
