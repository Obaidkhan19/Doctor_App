
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/change_password.dart';
import 'package:doctormobileapplication/screens/profile/edit_profile.dart';
import 'package:doctormobileapplication/screens/wallet_screens/wallet.dart';
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

import '../../components/images.dart';


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
    String baseurl = AppConstants.baseURL;
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
      body: SafeArea(
        minimum: const EdgeInsets.all(AppPadding.p20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.14,
              ),

              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  ZoomDrawer.of(context)!.close();
                },
                child: Image.asset(
                  AppImages.back,
                  color: ColorManager.kWhiteColor,
                ),
              ),

              SizedBox(
                height: Get.height * 0.04,
              ),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 30,
                child: ClipOval(
                  child: path != ""
                      ? CachedNetworkImage(
                          imageUrl: imagepath,
                          fit: BoxFit.fill,
                          errorWidget: (context, url, error) =>
                              Image.asset(AppImages.doctorlogo),
                        )
                      : Image.asset(AppImages.doctorlogo),
                ),
              ),

              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.45,
                    child: TextFormField(
                      decoration: InputDecoration(
                        // suffixIcon: InkWell(
                        //   onTap: () {
                        //     Get.to(const EditProfile());
                        //   },
                        //   child: Image.asset(
                        //     Images.edit,
                        //     color: ColorManager.kWhiteColor,
                        //   ),
                        // ),
                        disabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorManager.kWhiteColor, width: 3.0),
                        ),
                        enabled: false,
                        hintText: UserName,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                fontSize: 15,
                                color: ColorManager.kWhiteColor,
                                fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => EditProfile(
                            imagepath: imagepath != '' ? imagepath : "",
                            fullName: profile.selectedbasicInfo?.fullName,
                            dob: profile.selectedbasicInfo?.dateofBirth,
                            cellNumber:
                                profile.selectedbasicInfo?.contactPublic,
                            email: profile.selectedbasicInfo?.email,
                            country: profile.selectedbasicInfo?.countryName,
                            province: profile.selectedbasicInfo?.stateName,
                            city: profile.selectedbasicInfo?.cityName,
                            address: profile.selectedbasicInfo?.address,
                            cityid: profile.selectedbasicInfo?.cityId,
                            countryid: profile.selectedbasicInfo?.countryId,
                            provinceid:
                                profile.selectedbasicInfo?.stateOrProvinceId,
                          ));
                    },
                    child: Image.asset(
                      Images.edit,
                      height: Get.height * 0.035,
                      color: ColorManager.kWhiteColor,
                    ),
                  ),
                ],
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
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                leading: Image.asset(
                  AppImages.walletimg,
                  height: Get.height * 0.035,
                ),
                title: Text(
                  'wallet'.tr,
                  style: GoogleFonts.poppins(
                    textStyle: GoogleFonts.poppins(
                        fontSize: 15, color: ColorManager.kWhiteColor),
                  ),
                ),
                onTap: () {
                  //Navigator.pop(context);
                  Get.to(() => WalletScreen(
                        index: 1,
                      ));
                },
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
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
                        fontSize: 15, color: ColorManager.kWhiteColor),
                  ),
                ),
                onTap: () {
                  Get.to(() => const ChangePasswordScreen());
                },
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                leading: Image.asset(
                  AppImages.biometric,
                  height: Get.height * 0.035,
                ),
                trailing: Transform.scale(
                  scale: 0.55,
                  child: Switch(
                    value: isBiometric,
                    activeColor: ColorManager.kWhiteColor,
                    onChanged: (value) async {
                      // print('namename');
                      // print(EditProfileController.i.name);
                      if (value) {
                        authentication = await _authenticate();
                        if (authentication) {
                          if (EditProfileController.i.name == null) {
                            fingerprint = authentication;
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("You are already Logged in")));
                            // Utils().toastmessage("You are already Logged in");
                            fingerprint = true;
                          }
                          setState(() {});
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "You declined the biometric login.")));
                        }

                        if (fingerprint) {
                          if (authentication) {
                            if (EditProfileController.i.name != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("You are already Logged in")));
                              setState(() {
                                fingerprint = true;
                              });
                            }
                            setState(() {
                              profile;
                            });
                          } else {
                            setState(() {
                              fingerprint = true;
                            });
                          }
                          // LocalDb.set ('fingerprint', !fingerprint);
                        }
                        // setState(() {
                        //   fingerprint = value;
                        // });
                      } else {
                        // prefs!.setBool('fingerprint', !fingerprint);
                        setState(() {
                          fingerprint = false;
                          // authentication = !fingerprint;
                        });
                      }
                    },
                  ),
                ),
                title: Text(
                  'biometric'.tr,
                  style: GoogleFonts.poppins(
                    textStyle: GoogleFonts.poppins(
                        fontSize: 15, color: ColorManager.kWhiteColor),
                  ),
                ),
                onTap: () {
                  //Navigator.pop(context);
                },
              ),

              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
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
                        fontSize: 15, color: ColorManager.kWhiteColor),
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
                thickness: Get.height * 0.005,
              ),

              SizedBox(
                height: Get.height * 0.08,
              ),
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                leading: Image.asset(
                  AppImages.bin,
                  height: Get.height * 0.035,
                ),
                title: Text(
                  'deleteAccount'.tr,
                  style: GoogleFonts.poppins(
                    textStyle: GoogleFonts.poppins(
                        fontSize: 15, color: ColorManager.kWhiteColor),
                  ),
                ),
                onTap: () async {},
              ),

              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                leading: Image.asset(
                  AppImages.logout,
                  height: Get.height * 0.035,
                ),
                title: Text(
                  'logout'.tr,
                  style: GoogleFonts.poppins(
                    textStyle: GoogleFonts.poppins(
                        fontSize: 15, color: ColorManager.kWhiteColor),
                  ),
                ),
                onTap: () async {
                  String? id = await LocalDb().getDoctorId();
                  String? token = await LocalDb().getToken();
                  bool? loginStatus = await LocalDb().getLoginStatus();
                  String? DeviceToken = await LocalDb().getDeviceToken();
                  if (loginStatus == true) {
                    AuthRepo.logout(
                        DoctorId: id,
                        token: token,
                        DeviceToken: DeviceToken,
                        IsLogOffAllDevice: 'true');
                  } else {
                    showSnackbar(context, 'You are not Logged in');
                  }
                  //Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
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
