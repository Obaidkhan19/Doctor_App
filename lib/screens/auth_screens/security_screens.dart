import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/controller/auth_controller.dart';
import 'package:doctormobileapplication/data/controller/registration_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
            left: Get.width * 0.05,
            right: Get.width * 0.05,
            top: Get.height * 0.02,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GetBuilder<RegistrationController>(builder: (context) {
                    return AuthTextField(
                      onChangedwidget: (value) {
                        AuthRepo ar = AuthRepo();
                        ar.usernameAvaibility(controller.username.text);
                      },
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'EnterUsername'.tr;
                        }
                        return null;
                      },
                      controller: controller.username,
                      hintText: 'username'.tr,
                    );
                  }),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  GetBuilder<RegistrationController>(builder: (context) {
                    return AuthTextField(
                      obscureText: controller.securitypassword,
                      suffixIcon: InkWell(
                        onTap: () {
                          controller.updatesecuritypassword();
                        },
                        child: controller.securitypassword
                            ? const Icon(CupertinoIcons.eye_slash)
                            : const Icon(CupertinoIcons.eye),
                      ),
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'enteryourpassword'.tr;
                        }
                        return null;
                      },
                      controller: controller.password,
                      hintText: 'password'.tr,
                    );
                  }),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  GetBuilder<RegistrationController>(builder: (context) {
                    return AuthTextField(
                      obscureText: controller.securityconfirmpassword,
                      suffixIcon: InkWell(
                        onTap: () {
                          controller.updateconfirmpassword();
                        },
                        child: controller.securityconfirmpassword
                            ? const Icon(CupertinoIcons.eye_slash)
                            : const Icon(CupertinoIcons.eye),
                      ),
                      validator: (p0) {
                        if (p0!.isEmpty) {
                          return 'enteryourconfirmationpassword'.tr;
                        }
                        return null;
                      },
                      controller: controller.retypePassword,
                      hintText: 'confirmationpassword'.tr,
                    );
                  }),
                  SizedBox(
                    height: Get.height * 0.13,
                  ),
                  GetBuilder<RegistrationController>(
                    builder: (cont) => SizedBox(
                      width: Get.width * 1,
                      height: Get.height * 0.07,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (controller.password.text !=
                              controller.retypePassword.text) {
                            Fluttertoast.showToast(
                                msg:
                                    'PasswordandConfirmPassworddoesnotmatch'.tr,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: ColorManager.kRedColor,
                                textColor: ColorManager.kWhiteColor,
                                fontSize: 14.0);
                          } else if (_formKey.currentState!.validate() &&
                              controller.password.text ==
                                  controller.retypePassword.text) {
                            controller.updateIsSavingPath(true);

                            AuthRepo ar = AuthRepo();

                            String response = "";

                            if (controller.pmcfile == null ||
                                controller.selectedprovince?.id == null ||
                                controller.selectedcity?.id == null ||
                                controller.selectedcountry?.id == null ||
                                controller.selectedpersonalTitle?.id == null ||
                                controller.selectedgender?.id == null ||
                                controller.selectedmaritalStatus?.id == null ||
                                controller.countryfullnumber == '' ||
                                controller.firstname.text == '' ||
                                controller.lastname.text == '' ||
                                (controller.idnumber.text == '' ||
                                    controller.password.text == '') ||
                                controller.imcno.text == '' ||
                                controller.address.text == '' ||
                                controller.email.text == '' ||
                                controller.ontap == false) {
                              controller.updateIsSavingPath(false);
                              Fluttertoast.showToast(
                                  msg: 'pleasesavepersonaldetails'.tr,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: ColorManager.kRedColor,
                                  textColor: ColorManager.kWhiteColor,
                                  fontSize: 14.0);
                            } else {
                              String path = '';
                              if (controller.file != null) {
                                path = await ar.uploadPicture(controller.file!);
                              }

                              String filepath =
                                  await ar.uploadFile(controller.pmcfile!);
                              controller.updatefilepath(filepath);
                              controller.updateimagepath(path);

                              if (controller.selectedRadioValue == "idno") {
                                if (_formKey.currentState!.validate()) {
                                  response = await ar.signupPersonalcnic();
                                  controller.updateIsSavingPath(false);
                                } else {
                                  controller.updateIsSavingPath(true);
                                  Fluttertoast.showToast(
                                      msg: response.toString(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: ColorManager.kRedColor,
                                      textColor: ColorManager.kWhiteColor,
                                      fontSize: 14.0);
                                  // showSnackbar(context, response.toString());
                                }
                              } else if (controller.selectedRadioValue ==
                                  "passport") {
                                if (_formKey.currentState!.validate()) {
                                  response = await ar.signupPersonalpassport();
                                  controller.updateIsSavingPath(false);
                                  Fluttertoast.showToast(
                                      msg: response.toString(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: ColorManager.kRedColor,
                                      textColor: ColorManager.kWhiteColor,
                                      fontSize: 14.0);
                                  //   showSnackbar(context, response.toString());
                                } else {
                                  controller.updateIsSavingPath(false);
                                  Fluttertoast.showToast(
                                      msg: response.toString(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: ColorManager.kRedColor,
                                      textColor: ColorManager.kWhiteColor,
                                      fontSize: 14.0);
                                  // showSnackbar(context, response.toString());
                                }
                              }
                            }
                          }
                        },
                        child: controller.isSavingPath
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'register'.tr,
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.kWhiteColor),
                              ),
                      ),
                    ),
                  ),
                  // PrimaryButton(
                  //     title: 'register'.tr,
                  //     onPressed: () async {
                  //       if (controller.password.text !=
                  //           controller.retypePassword.text) {
                  //         showSnackbar(context,
                  //             "Password and Confirm Password doesnot match");
                  //       } else if (_formKey.currentState!.validate() &&
                  //           controller.password.text ==
                  //               controller.retypePassword.text) {
                  //         controller.updateIsSavingPath(true);

                  //         AuthRepo ar = AuthRepo();

                  //         String response = "";

                  //         if (controller.pmcfile == null ||
                  //             controller.selectedprovince?.id == null ||
                  //             controller.selectedcity?.id == null ||
                  //             controller.selectedcountry?.id == null ||
                  //             controller.selectedpersonalTitle?.id == null ||
                  //             controller.selectedgender?.id == null ||
                  //             controller.selectedmaritalStatus?.id == null ||
                  //             controller.countryfullnumber == '' ||
                  //             controller.firstname.text == '' ||
                  //             controller.lastname.text == '' ||
                  //             (controller.idnumber.text == '' ||
                  //                 controller.password.text == '') ||
                  //             controller.imcno.text == '' ||
                  //             controller.address.text == '' ||
                  //             controller.email.text == '' ||
                  //             controller.ontap == false) {
                  //           controller.updateIsSavingPath(false);
                  //           showSnackbar(
                  //               context, "pleasesavepersonaldetails".tr);
                  //         } else {
                  //           String path = '';
                  //           if (controller.file != null) {
                  //             path = await ar.uploadPicture(controller.file!);
                  //           }

                  //           String filepath =
                  //               await ar.uploadFile(controller.pmcfile!);
                  //           controller.updatefilepath(filepath);
                  //           controller.updateimagepath(path);

                  //           if (controller.selectedRadioValue == "idno") {
                  //             if (_formKey.currentState!.validate()) {
                  //               response = await ar.signupPersonalcnic();
                  //               controller.updateIsSavingPath(false);
                  //             } else {
                  //               controller.updateIsSavingPath(true);
                  //               showSnackbar(context, response.toString());
                  //             }
                  //           } else if (controller.selectedRadioValue ==
                  //               "passport") {
                  //             if (_formKey.currentState!.validate()) {
                  //               response = await ar.signupPersonalpassport();
                  //               controller.updateIsSavingPath(false);
                  //               showSnackbar(context, response.toString());
                  //             } else {
                  //               controller.updateIsSavingPath(false);
                  //               showSnackbar(context, response.toString());
                  //             }
                  //           }
                  //         }
                  //       }
                  //     },
                  //     color: ColorManager.kPrimaryColor,
                  //     textcolor: ColorManager.kWhiteColor),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  SignupOrLoginText(
                    pre: 'alreadyHaveAnAccount'.tr,
                    suffix: 'signin'.tr,
                    onTap: () {
                      Get.to(() => const LoginScreen());
                    },
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
