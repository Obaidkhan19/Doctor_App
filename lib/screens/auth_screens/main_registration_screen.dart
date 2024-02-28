import 'dart:io';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/data/controller/registration_controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/register_screens.dart';
import 'package:doctormobileapplication/screens/auth_screens/security_screens.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MainRegistrationScreen extends StatefulWidget {
  const MainRegistrationScreen({super.key});

  @override
  State<MainRegistrationScreen> createState() => _MainRegistrationScreenState();
}

class _MainRegistrationScreenState extends State<MainRegistrationScreen> {
  late List<Widget> pages;
  @override
  void initState() {
    pages = [const RegisterScreens(), const SecurityScreen()];
    //updateDevicetoken();
    super.initState();
  }

  // String deviceToken = '';
  // updateDevicetoken() async {
  //   deviceToken = await LocalDb().getDeviceToken();
  // }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put<RegistrationController>(RegistrationController());
    return Scaffold(
      body: GetBuilder<RegistrationController>(builder: (cont) {
        return SafeArea(
          child: Stack(
            children: [
              // const BackgroundLogoimage(),
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    SizedBox(
                      // height: Get.height * 0.1,
                      child: Center(
                        child: Image.asset(
                          Images.logo,
                          height: Get.height * 0.07,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text(
                      'registerNow'.tr,
                      style: GoogleFonts.raleway(
                          fontSize: 30,
                          color: ColorManager.kPrimaryColor,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    InkWell(
                      onTap: () {
                        controller.pickImage();
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: controller.file != null
                                ? DecorationImage(
                                    image:
                                        FileImage(File(controller.file!.path)),
                                    fit: BoxFit.cover)
                                : DecorationImage(
                                    image: AssetImage(AppImages.doctorlogo),
                                    fit: BoxFit.cover)),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: const Color(0xfff008955),
                              child: IconButton(
                                  onPressed: () {
                                    controller.pickImage();
                                  },
                                  icon: const Icon(Icons.camera_alt_outlined,
                                      size: 15, color: Colors.white)),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Visibility(
                      visible: true,
                      child: SizedBox(
                          width: double.maxFinite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.setPageIndexofDayPersonal(0);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: controller.indexp == 0
                                        ? ColorManager.kPrimaryColor
                                        : ColorManager.kWhiteColor,
                                    border: Border.all(
                                      color: ColorManager.kPrimaryColor,
                                      width: 2, // 2px border width
                                    ), // Set the background color of the container
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                  ),
                                  width: Get.width * 0.45,
                                  height: Get.height * 0.07,
                                  child: Center(
                                      child: Text(
                                    'personal'.tr,
                                    style: GoogleFonts.poppins(
                                        color: controller.indexp == 1
                                            ? ColorManager.kPrimaryColor
                                            : ColorManager.kWhiteColor,
                                        //     color: ColorManager.kWhiteColor,
                                        fontWeight: FontWeight.w600),
                                    //  Theme.of(context)
                                    //     .textTheme
                                    //     .bodyMedium!
                                    //     .copyWith(
                                    //         color: controller.indexp == 1
                                    //             ? const Color(0xfff1272d3)
                                    //             : ColorManager.kWhiteColor,
                                    //         //     color: ColorManager.kWhiteColor,
                                    //         fontWeight:
                                    //             FontWeightManager.bold),
                                  )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.setPageIndexofDayPersonal(1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: controller.indexp == 1
                                        ? ColorManager.kPrimaryColor
                                        : ColorManager.kWhiteColor,
                                    // color: Color(
                                    //     0xfff1272D3), // Set the background color of the container
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    border: Border.all(
                                      color: ColorManager.kPrimaryColor,
                                      width: 2, // 2px border width
                                    ),
                                  ),
                                  width: Get.width * 0.45,
                                  height: Get.height * 0.07,
                                  child: Center(
                                      child: Text(
                                    'security'.tr,
                                    style: GoogleFonts.poppins(
                                        color: controller.indexp == 0
                                            ? ColorManager.kPrimaryColor
                                            : ColorManager.kWhiteColor,
                                        fontWeight: FontWeight.w600),
                                    // style: Theme.of(context)
                                    //     .textTheme
                                    //     .bodyMedium!
                                    //     .copyWith(
                                    //         color: controller.indexp == 0
                                    //             ? const Color(0xfff1272d3)
                                    //             : ColorManager.kWhiteColor,
                                    //         fontWeight:
                                    //             FontWeightManager.bold),
                                  )),
                                ),
                              ),
                            ],
                          )),
                    ),

                    // 400 height
                    Expanded(
                      child: SizedBox(
                          // height: Get.height * 0.55,
                          child: pages[controller.indexp]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
