import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/dashboard/dashboard.dart';
import 'package:doctormobileapplication/screens/dashboard/menu_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return const ZoomDrawer(
        dragOffset: 40,
        
        showShadow: true,
        shadowLayer2Color: Color(0xFF2157B2),
        menuBackgroundColor: ColorManager.kPrimaryColor,
        angle: 0,
        slideWidth: 300,
        drawerShadowsBackgroundColor: ColorManager.kPrimaryColor,
        menuScreen: MenuScreen(),
        mainScreen: DashBoard());
  }
}
