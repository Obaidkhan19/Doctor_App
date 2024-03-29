import 'dart:io';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/ManageAppointments/TodayAppointments.dart';
import 'package:doctormobileapplication/screens/dashboard/home.dart';
import 'package:doctormobileapplication/screens/profile/detail_profile_main.dart';
import 'package:doctormobileapplication/screens/wallet_screens/wallet.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../data/localDB/local_db.dart';
import '../auth_screens/login.dart';
import 'package:url_launcher/url_launcher.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with WidgetsBindingObserver {
  _launchWhatsApp() async {
    String androidUrl = "whatsapp://send?phone=" "&text=Hi, I need some help";
    String iosUrl = "https://wa.me/" "?text=Hi,%20I%20need%20some%20help";
    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl),
            mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(Uri.parse(androidUrl),
            mode: LaunchMode.externalApplication);
      }
    } on Exception {
      Fluttertoast.showToast(
          msg: 'WhatsAppisnotinstalledonyourdevice.'.tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
    }
  }

  bool isKeyboardVisible = false;
  final List<Widget> pages = [
    const HomeScreen(),
    const ProfileDetailMain(),
    const TodayAppointments(),
    WalletScreen(
      index: 0,
    ),
  ];

  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  void navigateToPage(int index) async {
    if (index == 1) {
      bool? isLoggedin = await LocalDb().getLoginStatus();
      if ((isLoggedin ?? false) == false) {
      } else {}
    } else if (index == 2) {
      bool? isLoggedin = await LocalDb().getLoginStatus();
      if ((isLoggedin ?? false) == false) {
        Get.off(() => const LoginScreen());
      }
    } else if (index == 3) {
      bool? isLoggedin = await LocalDb().getLoginStatus();
      if ((isLoggedin ?? false) == false) {
        Get.off(() => const LoginScreen());
      } else if (index == 0) {
        await _getDoctorBasicInfo();
      }
    }
    setState(() {
      ProfileController.i.updateselectedPage(index);
    });
  }

  int tap = 0;
  Future<bool> showExitPopup() async {
    if (ZoomDrawer.of(context)!.isOpen()) {
      ZoomDrawer.of(context)!.close();
    } else if (tap == 0) {
      tap++;
      return false;
    } else if (tap == 1) {
      tap = 0;
      return true;
    }
    return false;
  }

  Future<bool> homeScreenPopup() async {
    ProfileController.i.updateselectedPage(0);
    setState(() {});

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: ProfileController.i.selectedPage,
        children: pages,
      ),
      bottomNavigationBar: bottomAppbar(context),
    );
  }

  bottomAppbar(BuildContext context) {
    return WillPopScope(
      onWillPop: ProfileController.i.selectedPage == 0 &&
              ZoomDrawer.of(context)!.isOpen() == false
          ? showExitPopup
          : homeScreenPopup,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(
                  int.parse('#1E1E1E'.substring(1, 7), radix: 16) + 0xFF000000),
              blurRadius: 6.0,
              spreadRadius: 0.4,
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Get.width * 0.08),
            topRight: Radius.circular(Get.width * 0.08),
          ),
        ),
        height: Get.height * 0.11,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            buildBottomNavItem(Images.homeIcon, "home".tr, 0, isSvg: false),
            buildBottomNavItem(Images.user, "profile".tr, 1, isSvg: false),
            buildBottomNavItem(Images.schedule, "schedule".tr, 2, isSvg: false),
            buildBottomNavItem(Images.wallet, 'help'.tr, 3, isSvg: false),
          ],
        ),
      ),
    );
  }

  buildBottomNavItem(String imagePath, String label, int index,
      {bool? isSvg = false}) {
    final isSelected = ProfileController.i.selectedPage == index;
    return InkWell(
      onTap: () {
        if (index == 3) {
          _launchWhatsApp();
        } else {
          navigateToPage(index);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          imagePath.isEmpty
              ? const SizedBox()
              : isSvg == false
                  ? Container(
                      padding: EdgeInsets.all(Get.width * 0.022),
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: ColorManager.kGreyColor,
                              blurRadius: 1.0,
                              spreadRadius: 1,
                              blurStyle: BlurStyle.normal,
                              offset: Offset(
                                1,
                                2,
                              ),
                            )
                          ],
                          shape: BoxShape.circle,
                          color: isSelected == true
                              ? ColorManager.kPrimaryColor
                              : ColorManager.kWhiteColor),
                      child: Image.asset(
                        imagePath,
                        height: Get.height * 0.03,
                        color: isSelected
                            ? ColorManager.kWhiteColor
                            : ColorManager.kPrimaryDark,
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(Get.width * 0.022),
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: ColorManager.kWhiteColor,
                              blurRadius: 1.0,
                              spreadRadius: 1,
                              blurStyle: BlurStyle.normal,
                              offset: Offset(
                                1,
                                3,
                              ),
                            )
                          ],
                          shape: BoxShape.circle,
                          color: isSelected == true
                              ? ColorManager.kPrimaryColor
                              : ColorManager.kWhiteColor),
                      child: SvgPicture.asset(
                        height: Get.height * 0.03,
                        imagePath,
                        color: isSelected
                            ? ColorManager.kWhiteColor
                            : ColorManager.kPrimaryDark,
                      ),
                    ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 10, color: ColorManager.kPrimaryDark),
          )
        ],
      ),
    );
  }
}
