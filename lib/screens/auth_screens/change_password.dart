import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/controller/auth_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: ColorManager.kPrimaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: Get.height * 0.12,
        title: Image.asset(
          Images.logo,
          height: Get.height * 0.07,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: GetBuilder<AuthController>(
            builder: (contr) => Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'ChangePassword'.tr,
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
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
                      height: Get.height * 0.025,
                    ),
                    AuthTextField(
                      obscureText: login.oldpassword,
                      suffixIcon: InkWell(
                        onTap: () {
                          login.updateoldpassword(!login.oldpassword);
                        },
                        child: login.oldpassword
                            ? const Icon(CupertinoIcons.eye_slash)
                            : const Icon(CupertinoIcons.eye),
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
                            ? const Icon(CupertinoIcons.eye_slash)
                            : const Icon(CupertinoIcons.eye),
                      ),
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'enteryourpassword'.tr;
                        }
                        return null;
                      },
                      controller: passwordController,
                      hintText: 'newpassword'.tr,
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
                            ? const Icon(CupertinoIcons.eye_slash)
                            : const Icon(CupertinoIcons.eye),
                      ),
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'enteryourconfirmationpassword'.tr;
                        }
                        return null;
                      },
                      controller: confirmPasswordController,
                      hintText: 'confirmationnewpassword'.tr,
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                            Fluttertoast.showToast(
                                msg: "newpasswordsshouldmatch".tr,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: ColorManager.kRedColor,
                                textColor: ColorManager.kWhiteColor,
                                fontSize: 14.0);
                          } else {
                            AuthRepo ar = AuthRepo();
                            await ar.changePassword(oldpasswordController.text,
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
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
