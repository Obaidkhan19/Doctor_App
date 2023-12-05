// ignore_for_file: avoid_unnecessary_containers

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/data/controller/auth_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/biometric_auth.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/forget_password.dart';
import 'package:doctormobileapplication/screens/auth_screens/main_registration_screen.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // call();
    getfingerprint();
    super.initState();
  }

  getfingerprint() async {
    isfingerprintEnable = await LocalDb.getfingerprint();
    setState(() {
      isfingerprintEnable;
    });
  }

  bool isfingerprintEnable = false;
  // bool isBiometric = false;
  final LocalAuthentication auth = LocalAuthentication();
  List<BiometricType>? _availableBiometrics;
  String _authorized = "Not Authorized";
  bool _isAuthenticating = false;
  bool authentication = false;
  Future<bool> _authenticate() async {
    bool authenticated = false;
    try {
      _isAuthenticating = true;
      _authorized = "Authenticating";
      authenticated = await auth.authenticate(
        localizedReason: "Let OS determine authentication method",
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      _isAuthenticating = false;
    } on PlatformException catch (e) {
      _isAuthenticating = false;
      _authorized = "Error - ${e.message}";

      return authenticated;
    }
    () => _authorized = authenticated ? "Authorized" : "Not Authorized";
    return authenticated;
  }

  call() async {
    // SharedPreferences sharedpref = await SharedPreferences.getInstance();

    String? username = await LocalDb().getUsername();
    String? userpassword = await LocalDb().getPassword();

    bool fingerprint = await LocalDb.getfingerprint();
    if (username != null && userpassword != null && fingerprint) {
      // await _authenticate();
      bool auth = await Authentication.authentication();

      if (auth) {
        if (auth) {
          fingerprint = auth;
        }
        if (fingerprint) {
          if (auth) {
            if (ProfileController.i.selectedbasicInfo?.id != null) {
              Fluttertoast.showToast(
                  msg: 'You are already Logged in',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: ColorManager.kRedColor,
                  textColor: ColorManager.kWhiteColor,
                  fontSize: 14.0);
              setState(() {
                fingerprint = true;
              });
            } else {
              AuthController.i.updateIsloading(true);
              await AuthRepo.login(cnic: username, password: userpassword);
              AuthController.i.updateIsloading(false);
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var login = Get.put<AuthController>(AuthController());
    return GetBuilder<AuthController>(builder: (cnt) {
      return BlurryModalProgressHUD(
          inAsyncCall: AuthController.i.isLoading,
          blurEffectIntensity: 4,
          progressIndicator: const SpinKitSpinningLines(
            color: Color(0xfff1272d3),
            size: 60,
          ),
          dismissible: false,
          opacity: 0.4,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: GetBuilder<AuthController>(builder: (cnt) {
            return Scaffold(
                resizeToAvoidBottomInset: false,
                body: Form(
                  key: _formKey,
                  child: SafeArea(
                    child: Stack(
                      children: [
                        const BackgroundLogoimage(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.05),
                          child: SizedBox(
                            height: Get.height,
                            width: Get.width,
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.03,
                                  ),
                                  SizedBox(
                                    child: Center(
                                      child: Image.asset(
                                        Images.logo,
                                        height: Get.height * 0.07,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.14,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.64,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'welcometo'.tr,
                                          style: GoogleFonts.raleway(
                                            textStyle: GoogleFonts.poppins(
                                                fontSize: 40,
                                                color:
                                                    ColorManager.kPrimaryColor,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                        Text(
                                          '${AppConstants.appName}.',
                                          style: GoogleFonts.raleway(
                                            textStyle: GoogleFonts.poppins(
                                                fontSize: 25,
                                                color:
                                                    ColorManager.kPrimaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.04,
                                        ),
                                        AuthTextField(
                                          validator: (p0) {
                                            if (p0!.isEmpty) {
                                              return 'EnterUsername'.tr;
                                            }
                                            return null;
                                          },
                                          controller: login.emailController,
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
                                          obscureText: login.obsecure,
                                          suffixIcon: InkWell(
                                              onTap: () {
                                                login.updateobsecurepassword(
                                                    !login.obsecure);
                                              },
                                              child: login.obsecure
                                                  ? const Icon(
                                                      CupertinoIcons.eye_slash)
                                                  : const Icon(
                                                      CupertinoIcons.eye)),
                                          controller: login.passwordController,
                                          hintText: 'password'.tr,
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    const ForgetPassword());
                                              },
                                              child: Text(
                                                'forgotPassword'.tr,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: ColorManager
                                                        .kPrimaryColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        PrimaryButton(
                                            title: 'login'.tr,
                                            fontSize: 15,
                                            fontweight: FontWeight.bold,
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                FocusScope.of(context)
                                                    .unfocus();

                                                try {
                                                  await AuthRepo.login(
                                                      cnic: login
                                                          .emailController.text,
                                                      password: login
                                                          .passwordController
                                                          .text);
                                                } catch (e) {}
                                              }
                                            },
                                            color: ColorManager.kPrimaryColor,
                                            textcolor:
                                                ColorManager.kWhiteColor),
                                        SizedBox(
                                          height: Get.height * 0.05,
                                        ),
                                        Visibility(
                                          visible: isfingerprintEnable,
                                          child: SizedBox(
                                            height: Get.height * 0.08,
                                            child: Center(
                                                child: InkWell(
                                              onTap: () {
                                                call();
                                              },
                                              child: Image.asset(
                                                  Images.fingerprint_icon),
                                            )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  SignupOrLoginText(
                                    pre: 'donthaveanAccount'.tr,
                                    suffix: 'register'.tr,
                                    onTap: () {
                                      //Get.to(() => const RegisterScreens());
                                      AuthController.i.disposefields();
                                      Get.to(const MainRegistrationScreen());
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          }));
    });
  }
}

class BackgroundLogoimage extends StatelessWidget {
  const BackgroundLogoimage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
    );
  }
}

class SignupOrLoginText extends StatelessWidget {
  final Function()? onTap;
  final String? pre;
  final String? suffix;
  const SignupOrLoginText({
    super.key,
    this.pre,
    this.suffix,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$pre',
          //  style: Theme.of(context).textTheme.bodyMedium,
          style: GoogleFonts.poppins(
              fontSize: 15, color: ColorManager.kblackColor),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            '$suffix',
            // style: Theme.of(context)
            //     .textTheme
            //     .bodySmall!
            //     .copyWith(color: ColorManager.kPrimaryColor),
            style: GoogleFonts.poppins(
                fontSize: 15,
                color: ColorManager.kPrimaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class AuthTextField extends StatelessWidget {
  final bool? obscureText;
  final List<TextInputFormatter>? formatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? readOnly;
  final ValueChanged<String>? onChangedwidget;

  const AuthTextField({
    super.key,
    this.hintText,
    this.onChangedwidget,
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
      style: const TextStyle(
        fontSize: 12,
        color: ColorManager.kGreyColor,
      ),
      onChanged: onChangedwidget,
      obscureText: obscureText ?? false,
      inputFormatters: formatters,
      readOnly: readOnly ?? false,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        errorStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: ColorManager.kRedColor, fontSize: 12),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        hintText: hintText,
        hintStyle:
            GoogleFonts.poppins(color: ColorManager.kGreyColor, fontSize: 12),
        disabledBorder: const OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.kRedColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: ColorManager.kGreyColor)),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.kGreyColor),
        ),
      ),
    );
  }
}

class IdNoAuthTextField extends StatelessWidget {
  final bool? obscureText;
  final List<TextInputFormatter>? formatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? readOnly;
  final ValueChanged<String>? onChangedwidget;

  const IdNoAuthTextField({
    super.key,
    this.hintText,
    this.onChangedwidget,
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
      style: const TextStyle(
        fontSize: 12,
        color: ColorManager.kGreyColor,
      ),
      keyboardType: TextInputType.number,
      onChanged: onChangedwidget,
      obscureText: obscureText ?? false,
      inputFormatters: [LengthLimitingTextInputFormatter(15)],
      readOnly: readOnly ?? false,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        errorStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: ColorManager.kRedColor, fontSize: 12),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        hintText: hintText,
        hintStyle:
            GoogleFonts.poppins(color: ColorManager.kGreyColor, fontSize: 12),
        disabledBorder: const OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.kRedColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: ColorManager.kGreyColor)),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.kGreyColor),
        ),
      ),
    );
  }
}
