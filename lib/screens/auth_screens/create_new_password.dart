import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/data/controller/auth_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var login = Get.put<AuthController>(AuthController());
    return Scaffold(
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
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
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
                            fontWeight: FontWeight.w500),
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
                      height: Get.height * 0.01,
                    ),
                    AuthTextField(
                      obscureText: login.newpassword,
                      suffixIcon: InkWell(
                        onTap: () {
                          login.updatenewpassword(!login.newpassword);
                        },
                        child: login.newpassword
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
                      obscureText: login.newconfirmpassword,
                      suffixIcon: InkWell(
                        onTap: () {
                          login.updatenewconfirmpassword(
                              !login.newconfirmpassword);
                        },
                        child: login.newconfirmpassword
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
                                  fontWeight: FontWeight.w600),
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
        ),
      ),
    );
  }
}
