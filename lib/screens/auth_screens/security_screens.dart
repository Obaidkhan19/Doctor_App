import 'dart:io';

import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/controller/auth_controller.dart';
import 'package:doctormobileapplication/data/controller/registration_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/font_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:doctormobileapplication/screens/auth_screens/register_screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  int selectedIndex = 1;

  void selectScreen(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var controller = Get.put<RegistrationController>(RegistrationController());
    return Scaffold(
      body: GetBuilder<AuthController>(builder: (cont) {
        return Padding(
          padding: EdgeInsets.only(
            left: Get.width * 0.06,
            right: Get.width * 0.06,
            top: Get.height * 0.05,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AuthTextField(
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'enteryourfullname'.tr;
                      }
                      return null;
                    },
                    controller: controller.username,
                    hintText: 'username'.tr,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  AuthTextField(
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'enteryourpassword'.tr;
                      }
                      return null;
                    },
                    controller: controller.password,
                    hintText: 'password'.tr,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  AuthTextField(
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'enteryourconfirmationpassword'.tr;
                      }
                      return null;
                    },
                    controller: controller.retypePassword,
                    hintText: 'confirmationpassword'.tr,
                  ),
                  SizedBox(
                    height: Get.height * 0.13,
                  ),
                  PrimaryButton(
                      title: 'register'.tr,
                      onPressed: () async {
                        AuthRepo ar = AuthRepo();

                        String response = "";

                        if (controller.file != null &&
                            controller.pmcfile != null &&
                            controller.selectedcity?.id != null &&
                            controller.selectedprovince?.id != null &&
                            controller.selectedcountry?.id != null &&
                            controller.selectedpersonalTitle?.id != null &&
                            controller.selectedgender?.id != null &&
                            controller.selectedmaritalStatus?.id != null &&
                            controller.countryfullnumber == '') {}
                        if (controller.filepath == null ||
                            controller.imagepath == null) {
                          showSnackbar(context, "pleasesavepersonaldetails".tr);
                        }
                        if (controller.selectedRadioValue == "idno") {
                          if (_formKey.currentState!.validate()) {
                            response = await ar.signupPersonalcnic();
                          } else {
                            showSnackbar(context, response.toString());
                          }
                        } else if (controller.selectedRadioValue ==
                            "passport") {
                          if (_formKey.currentState!.validate()) {
                            response = await ar.signupPersonalpassport();

                            showSnackbar(context, response.toString());
                          } else {
                            showSnackbar(context, response.toString());
                          }
                        }
                      },
                      color: ColorManager.kPrimaryColor,
                      textcolor: ColorManager.kWhiteColor),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  SignupOrLoginText(
                    pre: 'alreadyHaveAnAccount'.tr,
                    suffix: 'signin'.tr,
                    onTap: () {
                      Get.to(() => const LoginScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
