import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/controller/auth_controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/create_new_password.dart';
import 'package:doctormobileapplication/screens/auth_screens/forget_password.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    // TODO: implement initState
    AuthController.i.timer = 300.obs;
    AuthController.i.startTimer(context);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    AuthController.i.resettimerupdate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put<AuthController>(AuthController());
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
        toolbarHeight: 50,
        title: Image.asset(
          Images.logo,
          height: Get.height * 0.07,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'entercode'.tr,
              style: GoogleFonts.poppins(
                  fontSize: 25,
                  color: ColorManager.kblackColor,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Text(
              'kindlyenterthecodesenttoyournumber'.tr,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: ColorManager.kblackColor,
                  fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            OtpTextField(
              numberOfFields: 6,
              enabledBorderColor: ColorManager.kblackColor,
              focusedBorderColor: ColorManager.kPrimaryColor,
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) {
                AuthController.i.updatecode(verificationCode);
              },
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  String usercode = AuthController.i.code;
                  String verificationcode = AuthController.i.verificationcode;
                  if (usercode == verificationcode) {
                    Get.to(() => const CreateNewPasswordScreen());
                  } else {
                    showSnackbar(context, 'wrongcode'.tr);
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
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Obx(
              () => Center(
                child: Text(
                  "${'expirein'.tr} ${controller.timer ~/ 60}:${controller.timer % 60}",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: ColorManager.kblackColor,
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

class OTPTextField extends StatelessWidget {
  final bool? obscureText;
  final List<TextInputFormatter>? formatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? readOnly;
  const OTPTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.readOnly,
    this.formatters,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 1,
      keyboardType: TextInputType.number,
      style: GoogleFonts.poppins(
        fontSize: 12,
        color: ColorManager.kblackColor,
      ),
      obscureText: obscureText ?? false,
      inputFormatters: formatters,
      readOnly: readOnly ?? false,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        counterText: "",
        errorStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: ColorManager.kRedColor, fontSize: 12),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 13),
        hintText: hintText,
        hintStyle:
            const TextStyle(color: ColorManager.kGreyColor, fontSize: 12),
        disabledBorder: const OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.kRedColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: ColorManager.kblackColor)),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.kblackColor, width: 1),
        ),
      ),
    );
  }
}
