import 'dart:async';
import 'dart:developer';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/data/repositories/preferences_repo.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:doctormobileapplication/screens/welcome_screen/welcome_screen.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
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
  // instance() async {
  //   final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  //   await remoteConfig.setConfigSettings(
  //     RemoteConfigSettings(
  //       fetchTimeout: const Duration(seconds: 10),
  //       minimumFetchInterval: const Duration(minutes: 2),
  //     ),
  //   );
  //   await remoteConfig.fetchAndActivate().then((value) {
  //     if (value == true) {
  //       baseURL = remoteConfig.getString('URLQA');
  //       // baseURL = remoteConfig.getString('URL');
  //     } else {
  //       baseURL = 'http://192.168.88.254:324/';
  //       // baseURL = 'https://patient.helpful.ihealthcure.com/';
  //     }
  //   }).onError((error, stackTrace) {
  //     baseURL = 'http://192.168.88.254:324/';
  //     // baseURL = 'https://patient.helpful.ihealthcure.com/';
  //   });
  //   String? doctorid = await LocalDb().getDoctorId();
  //   log(doctorid ?? "");
  // }

  instance() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 10),
      ),
    );
    // .then((value) async {
    await remoteConfig.fetchAndActivate().then((value) {
      // if (value == true) {
      baseURL = remoteConfig.getString('URL');
      contactnumber = remoteConfig.getString('Phone');
      // baseURL = remoteConfig.getString('URL');
      if (baseURL == "") {
        // baseURL = 'http://192.168.88.254:324/';
        baseURL = 'https://patient.helpful.ihealthcure.com/';
      }
      // } else {
      //   // baseURL = 'http://192.168.88.254:324/';
      //   baseURL = 'https://patient.helpful.ihealthcure.com/';
      // }
      callPreferenece();
    }).onError((error, stackTrace) {
      log(error.toString());
      callPreferenece();
      // baseURL = 'http://192.168.88.254:324/';

      baseURL = 'https://patient.helpful.ihealthcure.com/';
    });
    // }).onError((error, stackTrace) {
    //   baseURL = 'https://patient.helpful.ihealthcure.com/';
    // });

    bool? isFirstStatus;
    LocalDb().getIsFirstTime()?.then((value) => isFirstStatus = value);
    bool? loginStatus;
    LocalDb().getLoginStatus()?.then((value) => loginStatus = value);
    Future.delayed(const Duration(milliseconds: 2000)).then((value) async {
      if (isFirstStatus != null &&
          // isFirstStatus != '' &&
          isFirstStatus == false) {
        //Goto Login Screen or dashboard screen
        if (loginStatus == true) {
          Get.offAll(() => const DrawerScreen());
          //    Get.to(() => const DrawerScreen());
        } else {
          Get.offAll(() => const LoginScreen());
        }
      } else {
        Get.offAll(() => const WelcomeScreen());
      }
    });

    // String? savedBaseURL = await LocalDb().getBaseURL();
    // if (savedBaseURL != baseURL) {
    //   LocalDb().saveLoginStatus(false);
    //   LocalDb().saveDoctorId(null);
    //   LocalDb().saveToken(null);
    //   // await AuthRepo.logout();

    //   ProfileController.i.updatedDoctorInfo(BasicInfo());
    //   AuthController.i.emailController.clear();
    //   AuthController.i.passwordController.clear();

    //   String? id = await LocalDb().getDoctorId();
    //   String? token = await LocalDb().getToken();
    //   bool? loginStatus = await LocalDb().getLoginStatus();
    //   String? DeviceToken = await LocalDb().getDeviceToken();
    //   if (loginStatus ?? true) {
    //     AuthRepo.logout(
    //         DoctorId: id,
    //         token: token,
    //         DeviceToken: DeviceToken,
    //         IsLogOffAllDevice: 'false');
    //   }
    //   Get.offAll(() => const LoginScreen());
    // }
    // LocalDb().setBaseURL(baseURL);
  }

  callPreferenece() async {
    PreferenceRepo pr = PreferenceRepo();
    await pr.getPreference();
  }

  @override
  void initState() {
    instance();

    // Timer(const Duration(milliseconds: 3500), () async {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // Positioned(
        //   top: 100,
        //   right: 0,
        //   child: Container(
        //     height: Get.height * 0.8,
        //     width: Get.width,
        //     alignment: Alignment.centerLeft,
        //     child: Image.asset(
        //       Images.logoBackground,
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        const BackgroundLogoimage(),
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
    duration: const Duration(milliseconds: 4000),
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
