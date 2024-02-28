import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/data/controller/auth_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:flutter/material.dart';
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
      body: GetBuilder<AuthController>(
        builder: (cont) => Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'forgottenpassword'.tr,
                  style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: ColorManager.kblackColor,
                      fontWeight: FontWeight.w500),
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
                      child: controller.isotpLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Center(
                              child: Text(
                                'verifycode'.tr,
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
    );
  }
}
