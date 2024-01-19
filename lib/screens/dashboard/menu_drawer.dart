import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/dashboard/dashboard.dart';
import 'package:doctormobileapplication/screens/dashboard/menu_screen.dart';
import 'package:get/get.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      dragOffset: 40,
      controller: ProfileController.i.zoomDrawerController,
      showShadow: true,
      shadowLayer2Color: ColorManager.kPrimaryColor,
      menuBackgroundColor: ColorManager.kPrimaryColor,
      angle: 0,
      slideWidth: Get.width * 0.9,
      drawerShadowsBackgroundColor: ColorManager.kPrimaryColor,
      menuScreen: const MenuScreen(),
      mainScreen: const DashBoard(),
    );
  }
}
