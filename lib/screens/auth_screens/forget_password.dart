import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/controller/auth_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:doctormobileapplication/screens/auth_screens/otp_screen.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();
  var controller = Get.put<AuthController>(AuthController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 50,
        title: Image.asset(
          Images.logo,
          height: Get.height * 0.08,
        ),
      ),
      body: GetBuilder<AuthController>(
        builder: (cont) => Stack(
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
            BlurryModalProgressHUD(
              inAsyncCall: controller.isotpLoading,
              blurEffectIntensity: 4,
              progressIndicator: const SpinKitSpinningLines(
                color: Color(0xfff1272d3),
                size: 60,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: Get.width * 0.08, right: Get.width * 0.08),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => const LoginScreen());
                            },
                            child: Image.asset(
                              AppImages.arrowback,
                              color: ColorManager.kblackColor,
                              width: Get.width * 0.1,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          Text(
                            'forgottenpassword'.tr,
                            style: GoogleFonts.poppins(
                                fontSize: 25,
                                color: ColorManager.kblackColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Text(
                        'ithappenkindlyenterthemobilenumberassociatedwithyouraccount'
                            .tr,
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      AuthTextField(
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return 'pleaseenteryouremail'.tr;
                          }
                          return null;
                        },
                        controller: emailController,
                        hintText: 'email'.tr,
                      ),
                      SizedBox(
                        height: Get.height * 0.03,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              AuthRepo ar = AuthRepo();
                              ar.otpCode(emailController.text);
                            }
                          },
                          child: Container(
                            height: Get.height * 0.07,
                            width: Get.width * 0.65,
                            decoration: BoxDecoration(
                              color: ColorManager.kPrimaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                'verifycode'.tr,
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: ColorManager.kWhiteColor,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
