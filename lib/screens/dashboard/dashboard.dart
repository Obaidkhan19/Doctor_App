// // ignore_for_file: use_build_context_synchronously, deprecated_member_use

// import 'package:doctormobileapplication/components/images.dart';
// import 'package:doctormobileapplication/helpers/color_manager.dart';
// import 'package:doctormobileapplication/helpers/values_manager.dart';
// import 'package:doctormobileapplication/screens/ManageAppointments/DailyViewAppointment.dart';
// import 'package:doctormobileapplication/screens/ManageAppointments/TodayAppointments.dart';
// import 'package:doctormobileapplication/screens/dashboard/home.dart';
// import 'package:doctormobileapplication/screens/profile/profile.dart';
// import 'package:doctormobileapplication/screens/wallet_screens/wallet.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';

// class DashBoard extends StatefulWidget {
//   const DashBoard({Key? key}) : super(key: key);

//   @override
//   State<DashBoard> createState() => _DashBoardState();
// }

// class _DashBoardState extends State<DashBoard> with WidgetsBindingObserver {
//   bool isKeyboardVisible = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   final List<Widget> pages = [
//     const HomeScreen(),
//     const Profile(),
//     const TodayAppointments(),
//     WalletScreen(
//       index: 0,
//     ),
//   ];

//   int selectedPage = 0;

//   void navigateToPage(int index) async {
//     setState(() {
//       selectedPage = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: selectedPage,
//         children: pages,
//       ),
//       bottomNavigationBar: bottomAppbar(context),
//     );
//   }

//   bottomAppbar(BuildContext context) {
//     return BottomAppBar(
//       //shadowColor: Colors.red,
//       height: Get.height * 0.11,
//       elevation: 5,
//       notchMargin: 0,
//       shape: const CircularNotchedRectangle(),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           buildBottomNavItem(Images.homeIcon, 'Home', 0, isSvg: true),
//           buildBottomNavItem(Images.user, 'Profile', 1, isSvg: false),
//           buildBottomNavItem(Images.schedule, 'Schedule', 2, isSvg: false),
//           buildBottomNavItem(Images.wallet, 'Wallet', 3, isSvg: false),

//           // buildBottomNavItem(Images.walletIcon, 'Wallet', 3, isSvg: false),
//         ],
//       ),
//     );
//   }

//   buildMenuItem(IconData icon, String label, {Function()? onPressed}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: Material(
//         borderRadius: BorderRadius.circular(20),
//         color: Colors.white,
//         child: InkWell(
//           onTap: onPressed,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
//             height: 60,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(icon),
//                 const SizedBox(width: 10),
//                 Text(label),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   buildBottomNavItem(String imagePath, String label, int index,
//       {bool? isSvg = false}) {
//     final isSelected = selectedPage == index;
//     return InkWell(
//       onTap: () {
//         navigateToPage(index);
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           imagePath.isEmpty
//               ? const SizedBox()
//               : isSvg == false
//                   ? Container(
//                       padding: const EdgeInsets.all(AppPadding.p8)
//                           .copyWith(bottom: 0),
//                       decoration: BoxDecoration(
//                           boxShadow: const [
//                             BoxShadow(
//                               color: ColorManager.kGreyColor,
//                               blurRadius: 1.0,
//                               spreadRadius: 1,
//                               blurStyle: BlurStyle.normal,
//                               offset: Offset(
//                                 1,
//                                 2,
//                               ),
//                             )
//                           ],
//                           shape: BoxShape.circle,
//                           color: isSelected == true
//                               ? ColorManager.kPrimaryColor
//                               : ColorManager.kWhiteColor),
//                       child: Image.asset(
//                         imagePath,
//                         color: isSelected
//                             ? ColorManager.kWhiteColor
//                             : ColorManager.kPrimaryDark,
//                       ),
//                     )
//                   : Container(
//                       padding: const EdgeInsets.all(AppPadding.p8),
//                       decoration: BoxDecoration(
//                           boxShadow: const [
//                             BoxShadow(
//                               color: ColorManager.kGreyColor,
//                               blurRadius: 1.0,
//                               spreadRadius: 1,
//                               blurStyle: BlurStyle.normal,
//                               offset: Offset(
//                                 1,
//                                 2,
//                               ),
//                             )
//                           ],
//                           shape: BoxShape.circle,
//                           color: isSelected == true
//                               ? ColorManager.kPrimaryColor
//                               : ColorManager.kWhiteColor),
//                       child: SvgPicture.asset(
//                         imagePath,
//                         color: isSelected
//                             ? ColorManager.kWhiteColor
//                             : ColorManager.kPrimaryDark,
//                       ),
//                     ),
//           SizedBox(
//             height: Get.height * 0.004,
//           ),
//           Text(
//             label,
//             style: Theme.of(context)
//                 .textTheme
//                 .titleMedium
//                 ?.copyWith(fontSize: 12, color: ColorManager.kPrimaryDark),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/screens/ManageAppointments/TodayAppointments.dart';
import 'package:doctormobileapplication/screens/dashboard/home.dart';
import 'package:doctormobileapplication/screens/profile/profile.dart';
import 'package:doctormobileapplication/screens/wallet_screens/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../data/localDB/local_db.dart';
import '../auth_screens/login.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with WidgetsBindingObserver {
  bool isKeyboardVisible = false;
  final List<Widget> pages = [
    const HomeScreen(),
    const Profile(),
    const TodayAppointments(),
    WalletScreen(
      index: 0,
    ),
  ];
  int selectedPage = 0;

  void navigateToPage(int index) async {
    if (index == 1) {
      bool? isLoggedin = await LocalDb().getLoginStatus();
      if ((isLoggedin ?? false) == false) {
        // Get.off(() => const LoginScreen(
        //       isHerefromSchedule: true,
        //     ));
      } else {
        // ScheduleController.i.clearData();
        // ScheduleController.i.ApplyFilterForAppointments(0);
        // ScheduleController.i.getAppointmentsSummery();
      }
    } else if (index == 2) {
      bool? isLoggedin = await LocalDb().getLoginStatus();
      if ((isLoggedin ?? false) == false) {
        Get.off(() => const LoginScreen());
      }
    } else if (index == 3) {
      bool? isLoggedin = await LocalDb().getLoginStatus();
      if ((isLoggedin ?? false) == false) {
        Get.off(() => const LoginScreen());
      } else {
        //  _launchWhatsApp();
      }
      // Call the method to launch WhatsApp
    }
    setState(() {
      selectedPage = index;
    });
    // await listToLoad();
    // lengthOfList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedPage,
        children: pages,
      ),
      bottomNavigationBar: bottomAppbar(context),
    );
  }

  bottomAppbar(BuildContext context) {
    return BottomAppBar(
      // shadowColor: Colors.red,
      height: Get.height * 0.13,
      elevation: 5,
      color: Colors.white,
      notchMargin: 10.0,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          buildBottomNavItem(Images.homeIcon, "home".tr, 0, isSvg: true),
          buildBottomNavItem(Images.user, "profile".tr, 1, isSvg: false),
          buildBottomNavItem(Images.schedule, "schedule".tr, 2, isSvg: false),
          buildBottomNavItem(Images.wallet, 'wallet'.tr, 3, isSvg: false),
        ],
      ),
    );
  }

  buildMenuItem(IconData icon, String label, {Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon),
                const SizedBox(width: 10),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildBottomNavItem(String imagePath, String label, int index,
      {bool? isSvg = false}) {
    final isSelected = selectedPage == index;
    return InkWell(
      onTap: () {
        navigateToPage(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            imagePath.isEmpty
                ? const SizedBox()
                : isSvg == false
                    ? Container(
                        padding: const EdgeInsets.all(AppPadding.p8),
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
                          color: isSelected
                              ? ColorManager.kWhiteColor
                              : ColorManager.kPrimaryDark,
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(AppPadding.p8),
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
                        child: SvgPicture.asset(
                          imagePath,
                          color: isSelected
                              ? ColorManager.kWhiteColor
                              : ColorManager.kPrimaryDark,
                        ),
                      ),
            SizedBox(
              height: Get.height * 0.002,
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
      ),
    );
  }
}
