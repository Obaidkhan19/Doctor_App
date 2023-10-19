import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/controller/auth_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/create_new_password.dart';
import 'package:doctormobileapplication/screens/auth_screens/forget_password.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var login = Get.put<AuthController>(AuthController());
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
        builder: (contr) => Stack(
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
            Padding(
              padding: EdgeInsets.only(
                  left: Get.width * 0.08, right: Get.width * 0.08),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'createnewpassword'.tr,
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    Center(
                      child: Text(
                        'kindlyenterauniquepassword'.tr,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    AuthTextField(
                      obscureText: login.newpassword,
                      suffixIcon: InkWell(
                        onTap: () {
                          login.updatenewpassword(!login.newpassword);
                        },
                        child: login.newpassword
                            ? const Icon(CupertinoIcons.eye)
                            : const Icon(CupertinoIcons.eye_slash),
                      ),
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'enteryourpassword'.tr;
                        }
                        return null;
                      },
                      controller: passwordController,
                      hintText: 'password'.tr,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    AuthTextField(
                      obscureText: login.newconfirmpassword,
                      suffixIcon: InkWell(
                        onTap: () {
                          login.updatenewconfirmpassword(
                              !login.newconfirmpassword);
                        },
                        child: login.newconfirmpassword
                            ? const Icon(CupertinoIcons.eye)
                            : const Icon(CupertinoIcons.eye_slash),
                      ),
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'enteryourconfirmationpassword'.tr;
                        }
                        return null;
                      },
                      controller: confirmPasswordController,
                      hintText: 'confirmationpassword'.tr,
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            // CALL API HERE
                            AuthRepo ar = AuthRepo();
                            ar.newPassword(
                                passwordController.text,
                                confirmPasswordController.text,
                                AuthController.i.otpusername,
                                AuthController.i.otpemail,
                                AuthController.i.verificationcode);
                          }
                        },
                        child: Container(
                          height: Get.height * 0.07,
                          width: Get.width * 0.75,
                          decoration: BoxDecoration(
                            color: ColorManager.kPrimaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'changepassword'.tr,
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
          ],
        ),
      ),
    );
  }
}
