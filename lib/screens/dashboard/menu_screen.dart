import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/change_password.dart';
import 'package:doctormobileapplication/screens/dashboard/dashboard.dart';
import 'package:doctormobileapplication/screens/dashboard/menu_drawer.dart';
import 'package:doctormobileapplication/screens/health_summary/patient_history.dart';
import 'package:doctormobileapplication/screens/profile/edit_profile.dart';
import 'package:doctormobileapplication/screens/wallet_screens/wallet.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:doctormobileapplication/utils/DialogBoxes/language_dialog.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/images.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  String path = '';

  _getimagepath() async {
    path = (await LocalDb().getDoctorUserImagePath())!;
    String baseurl = AppConstants.baseURL;
    imagepath = baseurl + path;
  }

  bool isBiometric = false;
  @override
  Widget build(BuildContext context) {
    print('pathpathpath');
    print('$path   aaaa');
    var profile = Get.put<ProfileController>(ProfileController());
    return Scaffold(
      backgroundColor: ColorManager.kPrimaryColor,
      body: SafeArea(
        minimum: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.14,
            ),
            InkWell(
              onTap: () {
                //Get.;
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
                child: path == '' || path == 'null'
                    ? Image.asset(AppImages.doctorlogo)
                    : Image.network(imagepath),
              ),
            ),

            SizedBox(
              height: Get.height * 0.01,
            ),
            Row(
              children: [
                SizedBox(
                  width: Get.width * 0.5,
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
                          firstName: profile.selectedbasicInfo?.firstName,
                          dob: profile.selectedbasicInfo?.dateofBirth,
                          cellNumber: profile.selectedbasicInfo?.contactPublic,
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
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              leading: Image.asset(AppImages.vector),
              title: Text(
                'patienthistory'.tr,
                style: GoogleFonts.raleway(
                  textStyle: GoogleFonts.poppins(
                      fontSize: 15, color: ColorManager.kWhiteColor),
                ),
              ),
              onTap: () {
                //Navigator.pop(context);
                Get.to(() => const PatientHistory());
              },
            ),

            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              leading: Image.asset(AppImages.wallet),
              title: Text(
                'wallet'.tr,
                style: GoogleFonts.raleway(
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
              leading: Image.asset(AppImages.forgetpassword),
              title: Text(
                'changePassword'.tr,
                style: GoogleFonts.raleway(
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
              leading: Image.asset(AppImages.biometric),
              trailing: Transform.scale(
                scale: 0.55,
                child: Switch(
                  value: isBiometric,
                  activeColor: ColorManager.kWhiteColor,
                  onChanged: (value) {
                    setState(() {
                      isBiometric = value;
                    });
                  },
                ),
              ),
              title: Text(
                'biometric'.tr,
                style: GoogleFonts.raleway(
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
              leading: Image.asset(AppImages.language),
              title: Text(
                'languages'.tr,
                style: GoogleFonts.raleway(
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
              height: Get.height * 0.1,
            ),

            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              leading: Image.asset(AppImages.logout),
              title: Text(
                'logout'.tr,
                style: GoogleFonts.raleway(
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

            // customListTile(
            //   context,
            //   imagePath: Images.logout,
            //   title: 'Logout',
            //   onTap: () async {
            //     String? id = await LocalDb().getDoctorId();
            //     String? token = await LocalDb().getToken();
            //     bool? loginStatus = await LocalDb().getLoginStatus();
            //     String? DeviceToken = await LocalDb().getDeviceToken();
            //     if (loginStatus == true) {
            //       // Get.offAll(() => const LoginScreen());
            //       AuthRepo.logout(
            //           DoctorId: id,
            //           token: token,
            //           DeviceToken: DeviceToken,
            //           IsLogOffAllDevice: 'true');
            //     } else {
            //       showSnackbar(context, 'You are not Logged in');
            //     }
            //     // Get.off(() => const LoginScreen());
            //   },
            // ),
            // customListTile(context, onTap: () async {
            //   String? id = await LocalDb().getDoctorId();
            //   String? token = await LocalDb().getToken();
            //   bool? loginStatus = await LocalDb().getLoginStatus();
            //   if (loginStatus == true) {
            //     AuthRepo.deleteAccount(patientId: id, token: token);
            //   } else {
            //     showSnackbar(context, 'You are not Logged in');
            //   }
            // },
            //     imagePath: Images.family,
            //     title: 'Delete Account',
            //     isIcon: true,
            //     textColor: ColorManager.kRedColor),
          ],
        ),
      ),
    );
  }

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
