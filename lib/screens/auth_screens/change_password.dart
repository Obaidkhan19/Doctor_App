import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/controller/auth_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController oldpasswordController = TextEditingController();
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
                      obscureText: login.oldpassword,
                      suffixIcon: InkWell(
                        onTap: () {
                          login.updateoldpassword(!login.oldpassword);
                        },
                        child: login.oldpassword
                            ? const Icon(CupertinoIcons.eye)
                            : const Icon(CupertinoIcons.eye_slash),
                      ),
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'enteryouroldpassword'.tr;
                        }
                        return null;
                      },
                      controller: oldpasswordController,
                      hintText: 'oldpassword'.tr,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    AuthTextField(
                      obscureText: login.changepassword,
                      suffixIcon: InkWell(
                        onTap: () {
                          login.updatechangepassword(!login.changepassword);
                        },
                        child: login.changepassword
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
                      obscureText: login.changeconfirmpassword,
                      suffixIcon: InkWell(
                        onTap: () {
                          login.updatechangeconfirmpassword(
                              !login.changeconfirmpassword);
                        },
                        child: login.changeconfirmpassword
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
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              showSnackbar(
                                  context, 'newpasswordsshouldmatch'.tr);
                            } else {
                              AuthRepo ar = AuthRepo();
                              await ar.changePassword(
                                  oldpasswordController.text,
                                  passwordController.text);
                            }
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
