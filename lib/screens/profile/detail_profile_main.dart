import 'dart:io';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/screens/dashboard/menu_drawer.dart';
import 'package:doctormobileapplication/screens/profile/awards_detail.dart';
import 'package:doctormobileapplication/screens/profile/bank_detail.dart';
import 'package:doctormobileapplication/screens/profile/contact_detail.dart';
import 'package:doctormobileapplication/screens/profile/education_detail.dart';
import 'package:doctormobileapplication/screens/profile/experience_detail.dart';
import 'package:doctormobileapplication/screens/profile/membership.dart';
import 'package:doctormobileapplication/screens/profile/personal.dart';
import 'package:doctormobileapplication/screens/profile/prescription_configuration_detail.dart';
import 'package:doctormobileapplication/screens/profile/specilization.dart';
import 'package:doctormobileapplication/screens/profile/worklocation_detail.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileDetailMain extends StatefulWidget {
  const ProfileDetailMain({super.key});

  @override
  State<ProfileDetailMain> createState() => _ProfileDetailMainState();
}

class _ProfileDetailMainState extends State<ProfileDetailMain> {
  @override
  void initState() {
    super.initState();
    // _controller = TabController(length: 10, vsync: this);
    _getDoctorBasicInfo();
    _getimagepath();
    //  getDetails();
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

  // TabController? _controller;
  @override
  Widget build(BuildContext context) {
    var profile = Get.put<ProfileController>(ProfileController());
    var edit = Get.put<EditProfileController>(EditProfileController());

    return GetBuilder<ProfileController>(
      builder: (cont) => BlurryModalProgressHUD(
        inAsyncCall: profile.isLoading,
        blurEffectIntensity: 4,
        progressIndicator: const SpinKitSpinningLines(
          color: Color(0xfff1272d3),
          size: 60,
        ),
        child: DefaultTabController(
          length: 10,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: ColorManager.kPrimaryColor,
                onPressed: () {
                  if (profile.isEdit == false) {
                    Get.offAll(() => const DrawerScreen());
                  } else if (ProfileController.i.editval == true ||
                      ProfileController.i.addval == true) {
                    ProfileController.i.updateval(false);
                    ProfileController.i.updateaddval(false);
                  } else {
                    Get.offAll(() => const DrawerScreen());
                  }
                },
              ),
              title: Text(
                cont.tabindex == 0
                    ? 'personal'.tr
                    : cont.tabindex == 1
                        ? 'onlyContact'.tr
                        : cont.tabindex == 2
                            ? 'education'.tr
                            : cont.tabindex == 3
                                ? 'experience'.tr
                                : cont.tabindex == 4
                                    ? 'specialization'.tr
                                    : cont.tabindex == 5
                                        ? 'membership'.tr
                                        : cont.tabindex == 6
                                            ? 'awards'.tr
                                            : cont.tabindex == 7
                                                ? 'bankDetail'.tr
                                                : cont.tabindex == 8
                                                    ? 'prescriptionConfiguration'
                                                        .tr
                                                    : cont.tabindex == 9
                                                        ? 'workLocations'.tr
                                                        : 'personal'.tr,
                style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.kPrimaryColor),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  GetBuilder<ProfileController>(builder: (cont) {
                    return GetBuilder<EditProfileController>(builder: (prf) {
                      return Center(
                        child: InkWell(
                          onTap: () async {
                            edit.file = null;
                            await edit.pickImage();
                            if (edit.file != null) {
                              edit.updateimagepath(edit.file!.path);
                            }
                            if (edit.file != null) {
                              ProfileRepo pr = ProfileRepo();
                              pr.updatePicture(edit.file!,
                                  cont.selectedbasicInfo!.picturePath);
                            }
                          },
                          child: Container(
                            height: Get.height * 0.1,
                            width: Get.height * 0.1,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: edit.file != null
                                  ? DecorationImage(
                                      image:
                                          FileImage(File(edit.newiamgepath!)),
                                      fit: BoxFit.cover,
                                    )
                                  : cont.selectedbasicInfo?.picturePath != null
                                      ? DecorationImage(
                                          image: NetworkImage(baseURL +
                                              cont.selectedbasicInfo!
                                                  .picturePath),
                                          fit: BoxFit.cover,
                                        )
                                      : DecorationImage(
                                          image:
                                              AssetImage(AppImages.doctorlogo),
                                          fit: BoxFit.cover,
                                        ),
                            ),
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.green,
                                  child: IconButton(
                                      onPressed: () async {
                                        edit.file = null;
                                        await edit.pickImage();
                                        if (edit.file != null) {
                                          edit.updateimagepath(edit.file!.path);
                                        }
                                        if (edit.file != null) {
                                          ProfileRepo pr = ProfileRepo();
                                          pr.updatePicture(
                                              edit.file!,
                                              cont.selectedbasicInfo!
                                                  .picturePath);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: ColorManager.kWhiteColor,
                                        size: 15,
                                      )),
                                )),
                          ),
                        ),
                      );
                    });
                  }),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  GetBuilder<ProfileController>(builder: (cont) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        height: Get.height * 0.58,
                        width: Get.width * 1,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: ColorManager.kPrimaryColor),
                        child: SingleChildScrollView(
                          child: SafeArea(
                              child: Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TabBar(
                                    // controller: _controller,
                                    tabAlignment: TabAlignment.start,
                                    isScrollable: true,
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.02,
                                        right: Get.width * 0.02),
                                    labelPadding: EdgeInsets.only(
                                        left: Get.width * 0.02,
                                        right: Get.width * 0.02),
                                    indicator: const UnderlineTabIndicator(
                                      borderSide: BorderSide(
                                        width: 5,
                                        color: ColorManager.kWhiteColor,
                                      ),
                                    ),
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    onTap: (index) {
                                      cont.updateselectedindex(index);
                                      FocusScope.of(context).unfocus();
                                    },
                                    tabs: [
                                      Tab(
                                        child: SizedBox(
                                          width: Get.width * 0.17,
                                          child: Center(
                                            child: Text('personal'.tr,
                                                style: GoogleFonts.poppins(
                                                    color: cont.tabindex == 0
                                                        ? ColorManager
                                                            .kWhiteColor
                                                        : ColorManager
                                                            .kWhiteColor,
                                                    fontSize: 12)),
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: SizedBox(
                                          width: Get.width * 0.17,
                                          child: Center(
                                            child: Text('onlyContact'.tr,
                                                style: GoogleFonts.poppins(
                                                    color: cont.tabindex == 1
                                                        ? ColorManager
                                                            .kWhiteColor
                                                        : ColorManager
                                                            .kWhiteColor,
                                                    fontSize: 12)),
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: SizedBox(
                                          width: Get.width * 0.2,
                                          child: Center(
                                            child: Text(
                                              'education'.tr,
                                              style: GoogleFonts.poppins(
                                                  color: cont.tabindex == 2
                                                      ? ColorManager.kWhiteColor
                                                      : ColorManager
                                                          .kWhiteColor,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: SizedBox(
                                          width: Get.width * 0.22,
                                          child: Center(
                                            child: Text(
                                              'experience'.tr,
                                              style: GoogleFonts.poppins(
                                                  color: cont.tabindex == 3
                                                      ? ColorManager.kWhiteColor
                                                      : ColorManager
                                                          .kWhiteColor,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: SizedBox(
                                          width: Get.width * 0.26,
                                          child: Center(
                                            child: Text(
                                              'specialization'.tr,
                                              style: GoogleFonts.poppins(
                                                  color: cont.tabindex == 4
                                                      ? ColorManager.kWhiteColor
                                                      : ColorManager
                                                          .kWhiteColor,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: SizedBox(
                                          width: Get.width * 0.22,
                                          child: Center(
                                            child: Text(
                                              'membership'.tr,
                                              style: GoogleFonts.poppins(
                                                  color: cont.tabindex == 5
                                                      ? ColorManager.kWhiteColor
                                                      : ColorManager
                                                          .kWhiteColor,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: SizedBox(
                                          width: Get.width * 0.17,
                                          child: Center(
                                            child: Text(
                                              'awards'.tr,
                                              style: GoogleFonts.poppins(
                                                  color: cont.tabindex == 6
                                                      ? ColorManager.kWhiteColor
                                                      : ColorManager
                                                          .kWhiteColor,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: SizedBox(
                                          width: Get.width * 0.24,
                                          child: Center(
                                            child: Text(
                                              'bankDetail'.tr,
                                              style: GoogleFonts.poppins(
                                                  color: cont.tabindex == 7
                                                      ? ColorManager.kWhiteColor
                                                      : ColorManager
                                                          .kWhiteColor,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: SizedBox(
                                          width: Get.width * 0.48,
                                          child: Center(
                                            child: Text(
                                              'prescriptionConfiguration'.tr,
                                              style: GoogleFonts.poppins(
                                                  color: cont.tabindex == 8
                                                      ? ColorManager.kWhiteColor
                                                      : ColorManager
                                                          .kWhiteColor,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: SizedBox(
                                          width: Get.width * 0.3,
                                          child: Center(
                                            child: Text(
                                              'workLocations'.tr,
                                              style: GoogleFonts.poppins(
                                                  color: cont.tabindex == 9
                                                      ? ColorManager.kWhiteColor
                                                      : ColorManager
                                                          .kWhiteColor,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.52,
                                child: const TabBarView(
                                    physics: AlwaysScrollableScrollPhysics(),
                                    children: [
                                      PersonalDetail(),
                                      ContactDetail(),
                                      EducationDetail(),
                                      ExperienceDetail(),
                                      SpecilizationDetail(),
                                      MemberShip(),
                                      AwardsDetail(),
                                      BankDetail(),
                                      PrescriptionConfiguration(),
                                      WorkLocation(),
                                    ]),
                              ),
                            ],
                          )),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
