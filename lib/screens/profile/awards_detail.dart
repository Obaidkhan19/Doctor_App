import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/image_container.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/models/degree.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';

import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AwardsDetail extends StatefulWidget {
  const AwardsDetail({super.key});

  @override
  State<AwardsDetail> createState() => _AwardsDetailState();
}

class _AwardsDetailState extends State<AwardsDetail> {
  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  var edit = Get.put<EditProfileController>(EditProfileController());

  _getLocations() async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updateawardList(
      await pr.getLocations(),
    );
  }

  @override
  void initState() {
    _getDoctorBasicInfo();
    super.initState();
    Future.delayed(Duration.zero, () async {
      ProfileController.i.updateselectedindex(6);
    });
    _getLocations();
  }

  var profile = Get.put<ProfileController>(ProfileController());
  var awards = Get.put<ProfileController>(ProfileController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (contt) => BlurryModalProgressHUD(
        inAsyncCall: profile.isLoading,
        blurEffectIntensity: 4,
        progressIndicator: const SpinKitSpinningLines(
          color: Color(0xfff1272d3),
          size: 60,
        ),
        child: GetBuilder<ProfileController>(
          builder: (contr) => contr.editval
              ? Container(
                  height: Get.height * 1,
                  color: ColorManager.kPrimaryColor,
                  padding: EdgeInsets.only(
                    top: Get.height * 0.02,
                    left: Get.width * 0.02,
                    right: Get.width * 0.02,
                  ),
                  child: GetBuilder<EditProfileController>(
                    builder: (contr) => Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            EditProfileCustomTextField(
                              controller: edit.awardtitle,
                              hintText: 'title'.tr,
                            ),

                            EditProfileCustomTextField(
                              controller: edit.awardcode,
                              hintText: 'code'.tr,
                            ),

                            // organization

                            // location
                            EditProfileCustomTextField(
                              onTap: () async {
                                Degrees generic = await searchabledropdown(
                                    context, edit.awardList);
                                edit.selectedawardlocation = null;
                                edit.updateselectedaward(generic);

                                if (generic.id != null) {
                                  edit.selectedawardlocation = generic;
                                  edit.selectedawardlocation =
                                      (generic.id == null)
                                          ? null
                                          : edit.selectedawardlocation;
                                }
                              },
                              readonly: true,
                              hintText: edit.selectedawardlocation?.name == ""
                                  ? 'location'.tr
                                  : edit.selectedawardlocation?.name ??
                                      "selectLocation".tr,
                            ),

                            EditProfileCustomTextField(
                              onTap: () async {
                                await edit.selectformattedawardedDateAndTime(
                                    context,
                                    EditProfileController.awardeddate,
                                    edit.formateawardeddate);
                              },
                              readonly: true,
                              hintText: edit.formattedawardeddate
                                          .toString()
                                          .split("T")[0] ==
                                      DateTime.now().toString().split(" ")[0]
                                  ? "SelectAwardedDate".tr
                                  : DateFormat('MM-dd-y').format(DateTime.parse(
                                      edit.formattedawardeddate
                                          .toString()
                                          .split(" ")[0])),
                            ),

                            EditProfileCustomTextField(
                              controller: edit.awarddescription,
                              hintText: 'description'.tr,
                            ),
                            SizedBox(height: Get.height * 0.03),
                            PrimaryButton(
                                fontSize: 15,
                                title: 'edit'.tr,
                                onPressed: () async {
                                  ProfileController.i.updateval(false);
                                  setState(() {});
                                },
                                color:
                                    ColorManager.kWhiteColor.withOpacity(0.7),
                                textcolor: ColorManager.kWhiteColor),
                            SizedBox(height: Get.height * 0.03),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : contr.addval
                  ? Container(
                      height: Get.height * 1,
                      color: ColorManager.kPrimaryColor,
                      padding: EdgeInsets.only(
                        top: Get.height * 0.02,
                        left: Get.width * 0.02,
                        right: Get.width * 0.02,
                      ),
                      child: GetBuilder<EditProfileController>(
                        builder: (contr) => Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.02),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                EditProfileCustomTextField(
                                  controller: edit.awardtitle,
                                  hintText: 'title'.tr,
                                ),

                                EditProfileCustomTextField(
                                  controller: edit.awardcode,
                                  hintText: 'code'.tr,
                                ),

                                // organization

                                // location
                                EditProfileCustomTextField(
                                  onTap: () async {
                                    Degrees generic = await searchabledropdown(
                                        context, edit.awardList);
                                    edit.selectedawardlocation = null;
                                    edit.updateselectedaward(generic);

                                    if (generic.id != null) {
                                      edit.selectedawardlocation = generic;
                                      edit.selectedawardlocation =
                                          (generic.id == null)
                                              ? null
                                              : edit.selectedawardlocation;
                                    }
                                  },
                                  readonly: true,
                                  hintText:
                                      edit.selectedawardlocation?.name == ""
                                          ? 'location'.tr
                                          : edit.selectedawardlocation?.name ??
                                              "SelectLocation".tr,
                                ),

                                EditProfileCustomTextField(
                                  onTap: () async {
                                    await edit
                                        .selectformattedawardedDateAndTime(
                                            context,
                                            EditProfileController.awardeddate,
                                            edit.formateawardeddate);
                                  },
                                  readonly: true,
                                  hintText: edit.formattedawardeddate
                                              .toString()
                                              .split("T")[0] ==
                                          DateTime.now()
                                              .toString()
                                              .split(" ")[0]
                                      ? "SelectAwardedDate".tr
                                      : DateFormat('MM-dd-y').format(
                                          DateTime.parse(edit
                                              .formattedawardeddate
                                              .toString()
                                              .split(" ")[0])),
                                ),

                                EditProfileCustomTextField(
                                  controller: edit.awarddescription,
                                  hintText: 'description'.tr,
                                ),
                                SizedBox(height: Get.height * 0.03),
                                PrimaryButton(
                                    fontSize: 15,
                                    title: 'add'.tr,
                                    onPressed: () async {
                                      ProfileController.i.updateaddval(false);
                                      setState(() {});
                                    },
                                    color: ColorManager.kWhiteColor
                                        .withOpacity(0.7),
                                    textcolor: ColorManager.kWhiteColor),
                                SizedBox(height: Get.height * 0.03),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: Get.height * 1,
                      color: ColorManager.kPrimaryColor,
                      padding: EdgeInsets.only(
                        top: Get.height * 0.02,
                        left: Get.width * 0.02,
                        right: Get.width * 0.02,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: Get.width * 0.04),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ImageContainer(
                                    onpressed: () {
                                      ProfileController.i.updateaddval(true);
                                      ProfileController.i.updateisEdit(true);
                                      setState(() {});
                                    },
                                    imagePath: Images.add,
                                    isSvg: false,
                                    color: ColorManager.kPrimaryColor,
                                    backgroundColor: ColorManager.kWhiteColor,
                                    boxheight: Get.height * 0.04,
                                    boxwidth: Get.width * 0.08,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            awards.awardsList.isNotEmpty
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.4,
                                        child: Row(
                                          children: [
                                            InkWell(
                                              child: SizedBox(
                                                height: Get.height * 0.04,
                                                width: Get.width * 0.15,
                                                child: Image.asset(
                                                  Images.edit,
                                                  color: ColorManager
                                                      .kPrimaryColor,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Title',
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: ColorManager.kWhiteColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.24,
                                        child: Text(
                                          'organization'.tr,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: ColorManager.kWhiteColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.2,
                                        child: Text(
                                          'date'.tr,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: ColorManager.kWhiteColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            awards.awardsList.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: awards.awardsList.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: Get.width * 0.4,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ImageContainerNew(
                                                      onpressed: () {},
                                                      imagePath:
                                                          AppImages.cross,
                                                      //  imageheight: Get.height * 0.03,
                                                      isSvg: false,
                                                      color: ColorManager
                                                          .kRedColor,
                                                      backgroundColor:
                                                          ColorManager
                                                              .kWhiteColor,
                                                      boxheight:
                                                          Get.height * 0.03,
                                                      boxwidth:
                                                          Get.width * 0.06,
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.004,
                                                    ),
                                                    ImageContainerNew(
                                                      onpressed: () {
                                                        ProfileController.i
                                                            .updateval(true);
                                                        ProfileController.i
                                                            .updateisEdit(true);
                                                        setState(() {});
                                                      },
                                                      imagePath:
                                                          AppImages.editbig,
                                                      isSvg: false,
                                                      color: ColorManager
                                                          .kPrimaryColor,
                                                      backgroundColor:
                                                          ColorManager
                                                              .kWhiteColor,
                                                      // imageheight: Get.height * 0.02,
                                                      boxheight:
                                                          Get.height * 0.03,
                                                      boxwidth:
                                                          Get.width * 0.06,
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.002,
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.25,
                                                      child: Text(
                                                        ProfileController
                                                                .i
                                                                .awardsList[
                                                                    index]
                                                                .title ??
                                                            "",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 11,
                                                          color: ColorManager
                                                              .kWhiteColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.24,
                                                child: Text(
                                                  ProfileController
                                                          .i
                                                          .awardsList[index]
                                                          .organizationName ??
                                                      "",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 11,
                                                    color: ColorManager
                                                        .kWhiteColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  width: Get.width * 0.2,
                                                  child: Text(
                                                    (ProfileController
                                                                .i
                                                                .awardsList[
                                                                    index]
                                                                .awardedDate !=
                                                            null)
                                                        ? DateFormat('MM-dd-y')
                                                            .format(DateTime.parse(
                                                                ProfileController
                                                                    .i
                                                                    .awardsList[
                                                                        index]
                                                                    .awardedDate!
                                                                    .split(
                                                                        "T")[0]))
                                                        : "",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 11,
                                                      color: ColorManager
                                                          .kWhiteColor,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text(
                                      "NoRecordFound".tr,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
