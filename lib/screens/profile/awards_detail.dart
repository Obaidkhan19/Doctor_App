import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/image_container.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/add_award_controller.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/models/degree.dart';
import 'package:doctormobileapplication/models/doctor_details.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:doctormobileapplication/utils/constants.dart';
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
  var add = Get.put<AddAwardController>(AddAwardController());

  _getLocations() async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updateawardList(
      await pr.getLocations(),
    );
  }

  _getLocationsadd() async {
    ProfileRepo pr = ProfileRepo();
    AddAwardController.i.updateawardList(
      await pr.getLocations(),
    );
  }

  _getOrganizationadd() async {
    ProfileRepo pr = ProfileRepo();
    AddAwardController.i.updateOrganizationList(
      await pr.getOrganization(),
    );
  }

  _getOrganizationedit() async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updateOrganizationList(
      await pr.getOrganization(),
    );
  }

  @override
  void initState() {
    _getDoctorBasicInfo();
    super.initState();
    Future.delayed(Duration.zero, () async {
      ProfileController.i.updateselectedindex(6);
    });
    _getOrganizationedit();
    _getOrganizationadd();
    _getLocations();
    _getLocationsadd();
  }

  var profile = Get.put<ProfileController>(ProfileController());
  var awards = Get.put<ProfileController>(ProfileController());

  final GlobalKey<FormState> _addformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _editformKey = GlobalKey<FormState>();
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
                        child: Form(
                          key: _editformKey,
                          child: Column(
                            children: [
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return 'entertitle'.tr;
                                  }
                                  return null;
                                },
                                controller: edit.awardtitle,
                                hintText: 'title'.tr,
                              ),

                              EditProfileCustomTextField(
                                controller: edit.awardcode,
                                hintText: 'code'.tr,
                              ),

                              // organization
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (edit.selectedOrganization?.id == null) {
                                    return 'SelectOrganization'.tr;
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  Degrees generic = await searchabledropdown(
                                      context, edit.OrganizationList);
                                  edit.selectedOrganization = null;
                                  edit.updateselectedOrganization(generic);

                                  if (generic.id != null) {
                                    edit.selectedOrganization = generic;
                                    edit.selectedOrganization =
                                        (generic.id == null)
                                            ? null
                                            : edit.selectedOrganization;
                                  }
                                },
                                readonly: true,
                                hintText: edit.selectedOrganization?.name == ""
                                    ? 'organization'.tr
                                    : edit.selectedOrganization?.name ??
                                        "SelectOrganization".tr,
                              ),
                              // location
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (edit.selectedawardlocation?.id == null) {
                                    return 'selectlocation'.tr;
                                  }
                                  return null;
                                },
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
                                    await edit
                                        .selectformattedawardedDateAndTime(
                                            context,
                                            EditProfileController.awardeddate,
                                            edit.formateawardeddate);
                                  },
                                  readonly: true,
                                  hintText: edit.formattedawardeddate
                                      .toString()
                                      .split("T")[0]),

                              EditProfileCustomTextField(
                                controller: edit.awarddescription,
                                hintText: 'description'.tr,
                              ),
                              SizedBox(height: Get.height * 0.03),

                              InkWell(
                                onTap: () async {
                                  ProfileRepo pr = ProfileRepo();
                                  if (_editformKey.currentState!.validate()) {
                                    edit.updateisloading(true);
                                    String res = await pr.editAwards(
                                        edit.editawardid,
                                        edit.awardtitle.text,
                                        edit.awardcode.text,
                                        edit.formattedawardeddate,
                                        edit.awarddescription.text,
                                        edit.selectedOrganization?.id,
                                        edit.selectedawardlocation?.id);
                                    if (res == "true") {
                                      _getDoctorBasicInfo();
                                      ProfileController.i.updateval(false);
                                      setState(() {});
                                      edit.updateisloading(false);
                                    }
                                    edit.updateisloading(false);
                                  }
                                  edit.updateisloading(false);
                                },
                                child: Container(
                                  height: Get.height * 0.07,
                                  width: Get.width * 1,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                      child: edit.isloading == false
                                          ? Text(
                                              'edit'.tr,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      ColorManager.kWhiteColor),
                                            )
                                          : const CircularProgressIndicator(
                                              color: ColorManager.kWhiteColor,
                                            )),
                                ),
                              ),

                              SizedBox(height: Get.height * 0.03),
                            ],
                          ),
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
                      child: GetBuilder<AddAwardController>(
                        builder: (contr) => Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.02),
                          child: SingleChildScrollView(
                            child: Form(
                              key: _addformKey,
                              child: Column(
                                children: [
                                  EditProfileCustomTextField(
                                    validator: (p0) {
                                      if (p0!.isEmpty) {
                                        return 'entertitle'.tr;
                                      }
                                      return null;
                                    },
                                    controller: add.title,
                                    hintText: 'title'.tr,
                                  ),

                                  EditProfileCustomTextField(
                                    controller: add.code,
                                    hintText: 'code'.tr,
                                  ),

                                  // organization
                                  EditProfileCustomTextField(
                                    validator: (p0) {
                                      if (add.selectedOrganization?.id ==
                                          null) {
                                        return 'SelectOrganization'.tr;
                                      }
                                      return null;
                                    },
                                    onTap: () async {
                                      Degrees generic =
                                          await searchabledropdown(
                                              context, add.OrganizationList);
                                      add.selectedOrganization = null;
                                      add.updateselectedOrganization(generic);

                                      if (generic.id != null) {
                                        add.selectedOrganization = generic;
                                        add.selectedOrganization =
                                            (generic.id == null)
                                                ? null
                                                : add.selectedOrganization;
                                      }
                                    },
                                    readonly: true,
                                    hintText:
                                        add.selectedOrganization?.name == ""
                                            ? 'organization'.tr
                                            : add.selectedOrganization?.name ??
                                                "SelectOrganization".tr,
                                  ),
                                  // location
                                  EditProfileCustomTextField(
                                    validator: (p0) {
                                      if (add.selectedawardlocation?.id ==
                                          null) {
                                        return 'selectlocation'.tr;
                                      }
                                      return null;
                                    },
                                    onTap: () async {
                                      Degrees generic =
                                          await searchabledropdown(
                                              context, add.awardList);
                                      add.selectedawardlocation = null;
                                      add.updateselectedaward(generic);

                                      if (generic.id != null) {
                                        add.selectedawardlocation = generic;
                                        add.selectedawardlocation =
                                            (generic.id == null)
                                                ? null
                                                : add.selectedawardlocation;
                                      }
                                    },
                                    readonly: true,
                                    hintText:
                                        add.selectedawardlocation?.name == ""
                                            ? 'location'.tr
                                            : add.selectedawardlocation?.name ??
                                                "selectLocation".tr,
                                  ),

                                  EditProfileCustomTextField(
                                      validator: (p0) {
                                        if (add.awarddateselect == false) {
                                          return 'SelectAwardedDate'.tr;
                                        }
                                        return null;
                                      },
                                      onTap: () async {
                                        await add
                                            .selectformattedawardedDateAndTime(
                                                context,
                                                AddAwardController.awardeddate,
                                                add.formateawardeddate);
                                      },
                                      readonly: true,
                                      hintText: add.awarddateselect == true
                                          ? add.formattedawardeddate
                                              .toString()
                                              .split("T")[0]
                                          : "SelectAwardedDate".tr),

                                  EditProfileCustomTextField(
                                    controller: add.description,
                                    hintText: 'description'.tr,
                                  ),
                                  SizedBox(height: Get.height * 0.03),

                                  InkWell(
                                    onTap: () async {
                                      ProfileRepo pr = ProfileRepo();
                                      if (_addformKey.currentState!
                                          .validate()) {
                                        add.updateisaddloading(true);
                                        String res = await pr.addAwards(
                                            add.title.text,
                                            add.code.text,
                                            add.formattedawardeddate,
                                            add.description.text,
                                            add.selectedOrganization?.id,
                                            add.selectedawardlocation?.id);
                                        if (res == "true") {
                                          _getDoctorBasicInfo();
                                          ProfileController.i
                                              .updateaddval(false);
                                          setState(() {});
                                          add.updateisaddloading(false);
                                        }
                                        add.updateisaddloading(false);
                                      }
                                      add.updateisaddloading(false);
                                    },
                                    child: Container(
                                      height: Get.height * 0.07,
                                      width: Get.width * 1,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                          child: add.isaddloading == false
                                              ? Text(
                                                  'add'.tr,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: ColorManager
                                                          .kWhiteColor),
                                                )
                                              : const CircularProgressIndicator(
                                                  color:
                                                      ColorManager.kWhiteColor,
                                                )),
                                    ),
                                  ),

                                  SizedBox(height: Get.height * 0.03),
                                ],
                              ),
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
                                      add.updateawarddateselect(false);
                                      add.title.clear();
                                      add.code.clear();
                                      add.formattedawardeddate =
                                          DateTime.now().toString();
                                      add.description.clear();
                                      add.selectedOrganization = null;
                                      add.selectedawardlocation = null;
                                      ProfileController.i.updateaddval(true);
                                      ProfileController.i.updateisEdit(true);
                                      setState(() {});
                                    },
                                    imagePath: Images.add,
                                    isSvg: false,
                                    color: ColorManager.kPrimaryColor,
                                    backgroundColor: ColorManager.kWhiteColor,
                                    boxheight: Get.height * 0.04,
                                    boxwidth: Get.width * 0.04,
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
                                              'title'.tr,
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
                                                    // ImageContainerNew(
                                                    //   onpressed: () async {
                                                    //     String id =
                                                    //         ProfileController
                                                    //                 .i
                                                    //                 .awardsList[
                                                    //                     index]
                                                    //                 .id ??
                                                    //             "";
                                                    //     deleteAward(
                                                    //         context, id);
                                                    //   },
                                                    //   imagePath:
                                                    //       AppImages.cross,
                                                    //   //  imageheight: Get.height * 0.03,
                                                    //   isSvg: false,
                                                    //   color: ColorManager
                                                    //       .kRedColor,
                                                    //   backgroundColor:
                                                    //       ColorManager
                                                    //           .kWhiteColor,
                                                    //   boxheight:
                                                    //       Get.height * 0.03,
                                                    //   boxwidth:
                                                    //       Get.width * 0.06,
                                                    // ),
                                                    SizedBox(
                                                      width: Get.width * 0.004,
                                                    ),
                                                    ImageContainerNew(
                                                      onpressed: () {
                                                        Awards a = Awards();
                                                        a = ProfileController.i
                                                            .awardsList[index];
                                                        edit.updateeditSelectedAward(
                                                            a);
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

  deleteAward(
    BuildContext context,
    String awardid,
  ) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: Get.width * 0.05),
                      Text(
                        'delete'.tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          textStyle: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.close_outlined,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Text(
                    'doyouwanttodeleteit'.tr,
                    style: GoogleFonts.poppins(
                      textStyle: GoogleFonts.poppins(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  PrimaryButton(
                    title: 'yes'.tr,
                    fontSize: 14,
                    height: Get.height * 0.06,
                    width: Get.width * 0.5,
                    onPressed: () async {
                      ProfileRepo pr = ProfileRepo();

                      String res = await pr.deleteAward(awardid);

                      if (res == "true") {
                        _getDoctorBasicInfo();

                        setState(() {});
                      }

                      // Call API
                      Get.back();
                    },
                    color: ColorManager.kPrimaryColor,
                    textcolor: ColorManager.kWhiteColor,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
