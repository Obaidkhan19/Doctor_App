import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/models/doctor_details.dart';
import 'package:doctormobileapplication/screens/dashboard/menu_drawer.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/family_screens/family_members.dart';
import 'package:doctormobileapplication/screens/family_screens/status_screen.dart';
import 'package:doctormobileapplication/screens/profile/edit_profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'package:intl/intl.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    _getDoctorBasicInfo();
    _getimagepath();
    //  getDetails();
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

  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  String truncateText(String text, int wordLimit) {
    List<String> words = text.split(' ');
    if (words.length <= wordLimit) {
      return text;
    }
    return '${words.sublist(0, wordLimit).join(' ')}...';
  }

  @override
  Widget build(BuildContext context) {
    var profile = Get.put<ProfileController>(ProfileController());

    return GetBuilder<ProfileController>(
      builder: (cont) => BlurryModalProgressHUD(
        inAsyncCall: profile.isLoading,
        blurEffectIntensity: 4,
        progressIndicator: const SpinKitSpinningLines(
          color: Color(0xfff1272d3),
          size: 60,
        ),
        child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Get.offAll(() => const DrawerScreen());
              },
              child: Image.asset(
                AppImages.back,
                color: ColorManager.kPrimaryColor,
              ),
            ),
            title: Text(
              'profile'.tr,
              style: GoogleFonts.poppins(
                  fontSize: 19, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
                  radius: 30,
                  child: ClipOval(
                    child:path != ""
                              ?  CachedNetworkImage(
                                                                imageUrl: imagepath,
                                                                        fit: BoxFit.fill,
                                                               
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Image.asset(
                                                                        AppImages.doctorlogo),
                              ):
                                                                    Image.asset(
                                                                        AppImages.doctorlogo),
                  ),
                ),
                title: Text(
                  profile.selectedbasicInfo?.fullName ?? "",
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    color: ColorManager.kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.07,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                width: Get.width,
                height: Get.height * 0.5,
                padding: EdgeInsets.only(top: Get.height * 0.04),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: ColorManager.kPrimaryColor),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      RecordWidget(
                          //   title: 'fullName'.tr,
                          title: "fullName".tr,
                          // name:
                          //     ProfileController.i.selectedbasicInfo?.fullName ??
                          //         "",
                          // name: EditProfileController.i.name),
                          name: profile.selectedbasicInfo?.fullName ?? ""),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      RecordWidget(
                        title: "dateOfBirth".tr,
                        name: (profile.selectedbasicInfo?.dateofBirth != null)
                            ? DateFormat('MM-dd-y').format(DateTime.parse(
                                profile.selectedbasicInfo?.dateofBirth!
                                    .split("T")[0]))
                            : "-",
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      RecordWidget(
                        title: "contact".tr,
                        name: profile.selectedbasicInfo?.contactPublic ?? "",
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      RecordWidget(
                          title: "email".tr,
                          name: profile.selectedbasicInfo?.email ?? ""),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      RecordWidget(
                        title: "country".tr,
                        name: profile.selectedbasicInfo?.countryName ?? "",
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      RecordWidget(
                        title: "province/state".tr,
                        name: profile.selectedbasicInfo?.stateName ?? "",
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      RecordWidget(
                        title: "city".tr,
                        name: profile.selectedbasicInfo?.cityName ?? "",
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      RecordWidget(
                        title: "address".tr,
                        name: profile.selectedbasicInfo?.address ?? "",
                      ),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      PrimaryButton(
                          width: Get.width * 0.9,
                          height: Get.height * 0.06,
                          fontSize: 15,
                          title: "editProfile".tr,
                          onPressed: () async {
                            var result = await Get.to(
                              () => EditProfile(
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
                                provinceid: profile
                                    .selectedbasicInfo?.stateOrProvinceId,
                              ),
                            );
                            if (result == true) {
                              _getDoctorBasicInfo();
                            }
                          },
                          color: ColorManager.kWhiteColor,
                          textcolor: ColorManager.kPrimaryColor),
                      SizedBox(
                        height: Get.height * 0.1,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
