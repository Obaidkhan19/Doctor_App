import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/biometric_auth.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/change_password.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:doctormobileapplication/utils/DialogBoxes/language_dialog.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fluttertoast/fluttertoast.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String UserName = '';
  String PMDCNumber = '';
  _getUserName() async {
    String? userName = await LocalDb().getDoctorFullName();
    String? PMDCNumberS = await LocalDb().getDoctorPMDCNumber();
    UserName = userName ?? '';
    PMDCNumber = PMDCNumberS ?? '';
    setState(() {});
  }

  @override
  void initState() {
    _getUserName();
    _getimagepath();
    super.initState();
  }

  String imagepath = '';
  String? path;

  _getimagepath() async {
    path = (await LocalDb().getDoctorUserImagePath())!;
    String baseurl = baseURL;
    if (path != null) {
      imagepath = baseurl + path!;
    }
  }

  bool isBiometric = false;
  @override
  Widget build(BuildContext context) {
    var profile = Get.put<ProfileController>(ProfileController());
    return Scaffold(
      backgroundColor: ColorManager.kPrimaryColor,
      body: GetBuilder<ProfileController>(builder: (cntS) {
        return SafeArea(
          minimum: const EdgeInsets.all(AppPadding.p20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.01,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  color: ColorManager.kWhiteColor,
                  onPressed: () {
                    ZoomDrawer.of(context)!.close();
                  },
                ),
                // InkWell(
                //   splashColor: Colors.transparent,
                //   highlightColor: Colors.transparent,
                //   onTap: () {
                //     ZoomDrawer.of(context)!.close();
                //   },
                //   child: Image.asset(
                //     AppImages.back,
                //     color: ColorManager.kWhiteColor,
                //   ),
                // ),

                SizedBox(
                  height: Get.height * 0.04,
                ),
                GetBuilder<ProfileController>(builder: (context) {
                  return CircleAvatar(
                    backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
                    radius: 30,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: ProfileController
                                    .i.selectedbasicInfo?.picturePath !=
                                null
                            ? baseURL +
                                ProfileController
                                    .i.selectedbasicInfo?.picturePath
                            : "",
                        width: Get.width * 0.16,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) =>
                            Image.asset(AppImages.doctorlogo),
                      ),
                    ),
                  );
                  // CircleAvatar(
                  //     backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
                  //     radius: 30,
                  //     child: ClipRRect(
                  //         borderRadius: BorderRadius.circular(30),
                  //         child: CachedNetworkImage(
                  //           height: Get.width * 0.16,
                  //           imageUrl: ProfileController
                  //                       .i.selectedbasicInfo?.picturePath !=
                  //                   null
                  //               ? baseURL +
                  //                   ProfileController
                  //                       .i.selectedbasicInfo?.picturePath
                  //               : "",
                  //           fit: BoxFit.fill,
                  //           errorWidget: (context, url, error) =>
                  //               Image.asset(AppImages.doctorlogo),
                  //         )));
                }),

                SizedBox(
                  height: Get.height * 0.01,
                ),
                SizedBox(
                  width: Get.width * 0.55,
                  child: Text(
                    ProfileController.i.selectedbasicInfo?.fullName ?? "",
                    // style: GoogleFonts.poppins(
                    //   textStyle: GoogleFonts.poppins(
                    //       fontSize: 15, color: ColorManager.kWhiteColor),
                    // ),
                    style: GoogleFonts.poppins(
                        color: ColorManager.kWhiteColor,
                        fontWeight: FontWeight.bold),

                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  //  TextFormField(
                  //   decoration: InputDecoration(
                  //     enabled: false,
                  //     hintText: ProfileController.i.selectedbasicInfo?.fullName,
                  //     hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  //         fontSize: 15,
                  //         color: ColorManager.kWhiteColor,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                ),
                // Row(
                //   children: [
                //     SizedBox(
                //       width: Get.width * 0.55,
                //       child: TextFormField(
                //         decoration: InputDecoration(
                //           // suffixIcon: InkWell(
                //           //   onTap: () {
                //           //     Get.to(const EditProfile());
                //           //   },
                //           //   child: Image.asset(
                //           //     Images.edit,
                //           //     color: ColorManager.kWhiteColor,
                //           //   ),
                //           // ),
                //           // disabledBorder: const UnderlineInputBorder(
                //           //   borderSide: BorderSide(
                //           //       color: ColorManager.kWhiteColor, width: 3.0),
                //           // ),
                //           enabled: false,
                //           // hintText: UserName,
                //           hintText:
                //               ProfileController.i.selectedbasicInfo?.fullName,
                //           hintStyle: Theme.of(context)
                //               .textTheme
                //               .bodyMedium!
                //               .copyWith(
                //                   fontSize: 15,
                //                   color: ColorManager.kWhiteColor,
                //                   fontWeight: FontWeight.bold),
                //         ),
                //       ),
                //     ),
                // InkWell(
                //   onTap: () {

                //     Get.to(() => const ProfileDetailMain());
                //   },
                //   child: Image.asset(
                //     Images.edit,
                //     height: Get.height * 0.035,
                //     color: ColorManager.kWhiteColor,
                //   ),
                // ),
                //   ],
                // ),

                Divider(
                  thickness: Get.height * 0.002,
                  color: ColorManager.kWhiteColor,
                ),

                // customListTile(context, onTap: () {
                //   Get.to(() => const NoDataFound());
                // }, imagePath: Images.family, title: 'Family Members'),
                // customListTile(context, onTap: () {
                //   Get.to(() => const NoDataFound());
                // }, imagePath: Images.location, title: 'Location'),
                // customListTile(context, onTap: () {
                //   Get.to(() => const NoDataFound());
                // }, imagePath: Images.wallet, title: 'Wallet'),
                // customListTile(context, onTap: () {
                //   Get.to(() => const NoDataFound());
                // }, imagePath: Images.wifi, title: 'Forgot Password'),

                // customListTile(context, onTap: () {
                //   Get.to(() => const NoDataFound());
                // },
                //     imagePath: Images.fingerprint,
                //     title: 'Finger Print',
                //     togglebutton: true),

                // const Divider(
                //   height: 1,
                //   thickness: 3,
                //   color: ColorManager.kWhiteColor,
                // ),
                // customListTile(context,
                // onTap: () {
                //   Get.to(()=> const  RegisterScreen());
                // },
                //     imagePath: Images.family, title: 'Sign Up'),

                SizedBox(
                  height: Get.height * 0.01,
                ),
                // ListTile(
                //   visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                //   contentPadding:
                //       const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                //   leading: Image.asset(AppImages.vector),
                //   title: Text(
                //     'patienthistory'.tr,
                //     style: GoogleFonts.poppins(
                //       textStyle: GoogleFonts.poppins(
                //           fontSize: 15, color: ColorManager.kWhiteColor),
                //     ),
                //   ),
                //   onTap: () {
                //     //Navigator.pop(context);
                //     Get.to(() => const PatientHistory());
                //   },
                // ),
                ListTile(
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  leading: Image.asset(
                    AppImages.walletimg,
                    height: Get.height * 0.035,
                    width: Get.width * 0.08,
                  ),
                  title: Text(
                    'wallet'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: ColorManager.kWhiteColor,
                      // fontWeight: FontWeight.w600,
                    ),
                    // ),
                    // style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    //     color: ColorManager.kWhiteColor,
                    //     fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // COMING SOON
                    Fluttertoast.showToast(
                        msg: "ComingSoon".tr,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: ColorManager.kPrimaryLightColor,
                        textColor: ColorManager.kPrimaryColor,
                        fontSize: 14.0);
                    // Get.to(() => WalletScreen(
                    //       index: 1,
                    //     ));
                  },
                ),
                ListTile(
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  leading: Image.asset(
                    AppImages.forgetpassword,
                    height: Get.height * 0.035,
                  ),
                  title: Text(
                    'changePassword'.tr,
                    style: GoogleFonts.poppins(
                      textStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        color: ColorManager.kWhiteColor,
                        //  fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.to(() => const ChangePasswordScreen());
                  },
                ),
                ListTile(
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  leading: Image.asset(
                    AppImages.biometric,
                    height: Get.height * 0.035,
                  ),
                  trailing: Transform.scale(
                    scale: 0.55,
                    child: Switch(
                        value: fingerprint,
                        onChanged: (val) async {
                          bool auth = await Authentication.authentication();
                          if (val == true) {
                            if (auth) {
                              // authentication = await _authenticate();
                              if (auth) {
                                if (ProfileController.i.selectedbasicInfo?.id ==
                                    null) {
                                  fingerprint = auth;
                                } else {
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //     const SnackBar(
                                  //         content: Text('Biometric Enabled')));
                                  LocalDb.savefingerprint(true);
                                  // Utils().toastmessage(“You are already Logged in”);
                                  fingerprint = true;
                                }
                                setState(() {});
                              } else {
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //     const SnackBar(
                                //         content: Text(
                                //             "You declined the biometric login.")));
                              }
                              if (fingerprint) {
                                if (auth) {
                                  if (ProfileController
                                          .i.selectedbasicInfo?.id !=
                                      null) {
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //     const SnackBar(
                                    //         content:
                                    //             Text('Biometric Enabled')));
                                    LocalDb.savefingerprint(true);
                                    setState(() {
                                      fingerprint = true;
                                    });
                                  }
                                  setState(() {
                                    ProfileController.i.selectedbasicInfo;
                                  });
                                } else {
                                  setState(() {
                                    LocalDb.savefingerprint(true);
                                    fingerprint = true;
                                  });
                                }
                              }
                            } else {
                              setState(() {
                                LocalDb.savefingerprint(false);
                                fingerprint = false;
                              });
                            }
                          } else {
                            fingerprint = val;
                            setState(() {});
                          }
                        }),
                    // Switch(
                    //   value: isBiometric,
                    //   activeColor: ColorManager.kWhiteColor,
                    //   onChanged: (value) async {
                    //   },
                    // ),
                  ),
                  title: Text(
                    'biometric'.tr,
                    style: GoogleFonts.poppins(
                      textStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        color: ColorManager.kWhiteColor,
                        //    fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onTap: () {
                    //Navigator.pop(context);
                  },
                ),

                ListTile(
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  leading: Image.asset(
                    AppImages.language,
                    height: Get.height * 0.035,
                  ),
                  title: Text(
                    'languages'.tr,
                    style: GoogleFonts.poppins(
                      textStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        color: ColorManager.kWhiteColor,
                        //  fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onTap: () async {
                    await languageSelector(context, AppConstants.languages);
                  },
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Divider(
                  thickness: Get.height * 0.002,
                  color: ColorManager.kWhiteColor,
                ),

                SizedBox(
                  height: Get.height * 0.22,
                ),
                ListTile(
                  leading: Image.asset(
                    AppImages.bin,
                    height: Get.height * 0.035,
                  ),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  title: Text(
                    'deleteAccount'.tr,
                    style: GoogleFonts.poppins(
                      textStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        color: ColorManager.kWhiteColor,
                        //   fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onTap: () async {},
                ),

                ListTile(
                  leading: Image.asset(
                    AppImages.logout,
                    height: Get.height * 0.035,
                  ),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  title: Text(
                    'logout'.tr,
                    style: GoogleFonts.poppins(
                      textStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        color: ColorManager.kWhiteColor,
                        //  fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onTap: () async {
                    Get.offAll(() => const LoginScreen());
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  final LocalAuthentication auth = LocalAuthentication();
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool authentication = false;

  Future<bool> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
        print(e.message.toString());
      });
      return authenticated;
    }
    if (!mounted) {
      return authenticated;
    }

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
    return authenticated;
  }

  bool fingerprint = false;

  customListTile(BuildContext context,
      {String? title,
      Function()? onTap,
      Color? textColor = ColorManager.kWhiteColor,
      String? imagePath,
      bool? togglebutton = false,
      bool? isIcon = false,
      bool isImageThere = false}) {
    return ListTile(
        onTap: onTap,
        minLeadingWidth: 20,
        contentPadding: EdgeInsets.zero,
        leading: isIcon == false
            ? Image.asset(imagePath!)
            : const Icon(
                Icons.delete,
                color: ColorManager.kRedColor,
                size: 20,
              ),
        title: Text(
          '$title',
          style:
              Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor),
        ),
        trailing: togglebutton == true
            ? CupertinoSwitch(value: true, onChanged: (value) {})
            : const SizedBox.shrink());
  }
}
