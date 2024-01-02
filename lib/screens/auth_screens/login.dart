// ignore_for_file: avoid_unnecessary_containers

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/data/controller/auth_controller.dart';
import 'package:doctormobileapplication/data/controller/preference_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/biometric_auth.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
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
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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

  //List<BiometricType>? _availableBiometrics;
  // String _authorized = "Not Authorized";
  // bool _isAuthenticating = false;
  // bool authentication = false;
  // Future<bool> _authenticate() async {
  //   bool authenticated = false;
  //   try {
  //     _isAuthenticating = true;
  //     _authorized = "Authenticating";
  //     authenticated = await auth.authenticate(
  //       localizedReason: "Let OS determine authentication method",
  //       options: const AuthenticationOptions(
  //           stickyAuth: true, biometricOnly: true, useErrorDialogs: true),
  //     );
  //     _isAuthenticating = false;
  //   } on PlatformException catch (e) {
  //     _isAuthenticating = false;
  //     _authorized = "Error - ${e.message}";

  //     return authenticated;
  //   }
  //   () => _authorized = authenticated ? "Authorized" : "Not Authorized";
  //   return authenticated;
  // }

  call() async {
    String? username = await LocalDb().getUsername();
    String? userpassword = await LocalDb().getPassword();

    bool fingerprint = await LocalDb.getfingerprint();
    if (username != null && userpassword != null && fingerprint) {
      // bool auth = await _authenticate();
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

  callQRScanner() async {
    String? username = "";
    String? userpassword = "";

    AuthController.i.updateIsloading(true);
    await AuthRepo.login(cnic: username, password: userpassword);
    AuthController.i.updateIsloading(false);
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
                                          '$appName.',
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
                                        // Visibility(
                                        //   visible: !isfingerprintEnable,
                                        //   child: SizedBox(
                                        //     height: Get.height * 0.08,
                                        //     child: Center(
                                        //         child: InkWell(
                                        //       onTap: () {
                                        //         // callQRScanner();
                                        //         Get.to(const MyHomePage());
                                        //       },
                                        //       child: Image.asset(
                                        //           Images.qrscan_icon),
                                        //     )),
                                        //   ),
                                        // ),
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

class BackgroundLogoimage1 extends StatelessWidget {
  const BackgroundLogoimage1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
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

class Masks {
  var maskFormatter = MaskTextInputFormatter(
      mask: PreferenceController
          .i.preferenceObject.dynamicMaskingForIdentityNumber,
      filter: {"9": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
}

class Masks1 {
  var maskFormatter = MaskTextInputFormatter();
}

class IdNoAuthTextField extends StatefulWidget {
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
  State<IdNoAuthTextField> createState() => _IdNoAuthTextFieldState();
}

class _IdNoAuthTextFieldState extends State<IdNoAuthTextField> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PreferenceController>(
      builder: (cont) => TextFormField(
        style: const TextStyle(
          fontSize: 12,
          color: ColorManager.kGreyColor,
        ),
        keyboardType: TextInputType.number,
        onChanged: widget.onChangedwidget,
        obscureText: widget.obscureText ?? false,
        // inputFormatters: const [],
        inputFormatters: [
          PreferenceController
                          .i.preferenceObject.dynamicMaskingForIdentityNumber !=
                      null ||
                  PreferenceController
                          .i.preferenceObject.dynamicMaskingForIdentityNumber !=
                      "null"
              ? Masks().maskFormatter
              : Masks1().maskFormatter
          // LengthLimitingTextInputFormatter(PreferenceController
          //                 .i
          //                 .preferenceObject
          //                 .dynamicNumberOfDigitsForIdentityNumber ==
          //             null ||
          //         PreferenceController.i.preferenceObject
          //                 .dynamicNumberOfDigitsForIdentityNumber ==
          //             "null"
          //     ? 11
          //     : PreferenceController
          //         .i.preferenceObject.dynamicNumberOfDigitsForIdentityNumber)
        ],
        readOnly: widget.readOnly ?? false,
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
          errorStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ColorManager.kRedColor, fontSize: 12),
          suffixIcon: widget.suffixIcon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: widget.hintText,
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
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   MobileScannerController cameraController = MobileScannerController();
//   bool _screenOpened = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Mobile Scanner"),
//         actions: [
//           IconButton(
//             color: Colors.white,
//             icon: ValueListenableBuilder(
//               valueListenable: cameraController.torchState,
//               builder: (context, state, child) {
//                 switch (state) {
//                   case TorchState.off:
//                     return const Icon(Icons.flash_off, color: Colors.grey);
//                   case TorchState.on:
//                     return const Icon(Icons.flash_on, color: Colors.yellow);
//                 }
//               },
//             ),
//             iconSize: 32.0,
//             onPressed: () => cameraController.toggleTorch(),
//           ),
//           IconButton(
//             color: Colors.white,
//             icon: ValueListenableBuilder(
//               valueListenable: cameraController.cameraFacingState,
//               builder: (context, state, child) {
//                 switch (state) {
//                   case CameraFacing.front:
//                     return const Icon(Icons.camera_front);
//                   case CameraFacing.back:
//                     return const Icon(Icons.camera_rear);
//                 }
//               },
//             ),
//             iconSize: 32.0,
//             onPressed: () => cameraController.switchCamera(),
//           ),
//         ],
//       ),
//       body: MobileScanner(
//         // allowDuplicates: true,
//         controller: cameraController,
//         onDetect: _foundBarcode,
//       ),
//     );
//   }

//   void _foundBarcode(BarcodeCapture barcode) {
//     /// open screen
//     if (!_screenOpened) {
//       final String code = barcode.raw ?? "---";
//       debugPrint('Barcode found! $code');
//       _screenOpened = true;
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>
//                 FoundCodeScreen(screenClosed: _screenWasClosed, value: code),
//           ));
//     }
//   }

//   void _screenWasClosed() {
//     _screenOpened = false;
//   }
// }

// class FoundCodeScreen extends StatefulWidget {
//   final String value;
//   final Function() screenClosed;
//   const FoundCodeScreen({
//     Key? key,
//     required this.value,
//     required this.screenClosed,
//   }) : super(key: key);

//   @override
//   State<FoundCodeScreen> createState() => _FoundCodeScreenState();
// }

// class _FoundCodeScreenState extends State<FoundCodeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Found Code"),
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             widget.screenClosed();
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back_outlined,
//           ),
//         ),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 "Scanned Code:",
//                 style: TextStyle(
//                   fontSize: 20,
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 widget.value,
//                 style: const TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
