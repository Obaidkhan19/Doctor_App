import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/image_container.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/add_specialization_controller.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/speciality.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecilizationDetail extends StatefulWidget {
  const SpecilizationDetail({super.key});

  @override
  State<SpecilizationDetail> createState() => _SpecilizationDetailState();
}

class _SpecilizationDetailState extends State<SpecilizationDetail> {
  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  var specilization = Get.put<ProfileController>(ProfileController());
  var edit = Get.put<EditProfileController>(EditProfileController());
  var add = Get.put<AddSpecializationController>(AddSpecializationController());
  _getaddSpeciality() async {
    AuthRepo ar = AuthRepo();
    AddSpecializationController.i.updateaddspecialitiesList(
      await ar.getSpecialities(),
    );
  }

  _getaddSubSpeciality(id) async {
    AuthRepo ar = AuthRepo();
    AddSpecializationController.i.addselectedsubspecialities = null;
    AddSpecializationController.i.updateaddsubspecialitiesList(
      await ar.getSubSpecialities(id),
    );
  }

  _getSpeciality() async {
    AuthRepo ar = AuthRepo();
    EditProfileController.i.updatespecialitiesList(
      await ar.getSpecialities(),
    );
  }

  _getSubSpeciality(id) async {
    AuthRepo ar = AuthRepo();
    EditProfileController.i.selectedsubspecialities = null;
    EditProfileController.i.updatesubspecialitiesList(
      await ar.getSubSpecialities(id),
    );
  }

  @override
  void initState() {
    _getDoctorBasicInfo();
    _getaddSpeciality();
    _getSpeciality();
    Future.delayed(Duration.zero, () async {
      ProfileController.i.updateselectedindex(4);
    });
    super.initState();
  }

  var profile = Get.put<ProfileController>(ProfileController());
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
            builder: (contr) => contr.addval
                ? GetBuilder<AddSpecializationController>(
                    builder: (contr) => Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            child: Form(
                              key: _addformKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  EditProfileCustomTextField(
                                    onTap: () async {
                                      add.addselectedspecialities = null;
                                      Specialities1 generic =
                                          await searchabledropdown(
                                              context, add.addspecialitiesList);
                                      add.addselectedspecialities = null;
                                      add.updateaddselectedspeciality(generic);

                                      if (generic.id != null) {
                                        add.addselectedspecialities = generic;
                                        add.addselectedspecialities =
                                            (generic.id == null)
                                                ? null
                                                : add.addselectedspecialities;
                                      }

                                      setState(() {
                                        _getaddSubSpeciality(generic.id);
                                      });
                                    },
                                    validator: (p0) {
                                      if (add.addselectedspecialities == null) {
                                        return 'SelectSpeciality'.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                    readonly: true,
                                    hintText:
                                        add.addselectedspecialities == null
                                            ? 'speciality'.tr
                                            : add.addselectedspecialities!.name
                                                .toString(),
                                  ),
                                  // SizedBox(
                                  //   height: Get.height * 0.02,
                                  // ),

                                  // SUB
                                  EditProfileCustomTextField(
                                    onTap: () async {
                                      if (add.addselectedspecialities != null) {
                                        add.addselectedsubspecialities = null;
                                        Specialities1 generic =
                                            await searchabledropdown(context,
                                                add.addsubspecialitiesList);
                                        add.addselectedsubspecialities = null;
                                        add.updateaddselectedspeciality(
                                            generic);

                                        if (generic.id != null) {
                                          add.addselectedsubspecialities =
                                              generic;
                                          add.addselectedsubspecialities =
                                              (generic.id == null)
                                                  ? null
                                                  : add
                                                      .addselectedsubspecialities;
                                        }
                                      }
                                    },
                                    readonly: true,
                                    hintText: add.addselectedsubspecialities ==
                                            null
                                        ? 'subspeciality'.tr
                                        : add.addselectedsubspecialities!.name
                                            .toString(),
                                  ),
                                  SizedBox(height: Get.height * 0.03),

                                  InkWell(
                                    onTap: () async {
                                      ProfileRepo pr = ProfileRepo();

                                      if (_addformKey.currentState!
                                          .validate()) {
                                        String res = await pr.addSpecilization(
                                            add.addselectedspecialities!.id ??
                                                "",
                                            add.addselectedsubspecialities
                                                    ?.id ??
                                                "");

                                        if (res == "true") {
                                          ProfileController.i
                                              .updateaddval(false);
                                          _getDoctorBasicInfo();
                                          setState(() {});
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: Get.height * 0.07,
                                      width: Get.width * 1,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                          child: add.isloading == false
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
                                  // PrimaryButton(
                                  // fontSize: 15,
                                  // title:  'add'.tr,
                                  // onPressed: () async {
                                  //   ProfileRepo pr = ProfileRepo();
                                  //   if (_addformKey.currentState!
                                  //       .validate()) {
                                  //     add.updateisloading(true);
                                  //     String res = await pr.addSpecilization(
                                  //         add.addselectedspecialities!.id ??
                                  //             "",
                                  //         add.addselectedsubspecialities!
                                  //                 .id ??
                                  //             "");

                                  //             add.updateisloading(false);
                                  //     if (res == "true") {
                                  //       ProfileController.i
                                  //           .updateaddval(false);
                                  //       setState(() {});
                                  //     }
                                  //   }
                                  // },
                                  // color: Colors.white.withOpacity(0.7),
                                  // textcolor: ColorManager.kWhiteColor),
                                  SizedBox(height: Get.height * 0.03),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : contr.editval
                    ? GetBuilder<EditProfileController>(
                        builder: (contr) => Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.05),
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                child: Form(
                                  key: _editformKey,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: Get.height * 0.02,
                                      ),
                                      EditProfileCustomTextField(
                                        onTap: () async {
                                          edit.selectedspecialities = null;
                                          Specialities1 generic =
                                              await searchabledropdown(context,
                                                  edit.specialitiesList);
                                          edit.selectedspecialities = null;
                                          edit.updateselectedspeciality(
                                              generic);

                                          if (generic.id != null) {
                                            edit.selectedspecialities = generic;
                                            edit.selectedspecialities =
                                                (generic.id == null)
                                                    ? null
                                                    : edit.selectedspecialities;
                                          }

                                          setState(() {
                                            _getSubSpeciality(generic.id);
                                          });
                                        },
                                        validator: (p0) {
                                          if (edit.selectedspecialities?.id ==
                                              null) {
                                            return 'SelectSpeciality'.tr;
                                          } else {
                                            return null;
                                          }
                                        },
                                        readonly: true,
                                        hintText: edit.selectedspecialities ==
                                                null
                                            ? 'speciality'.tr
                                            : edit.selectedspecialities!.name
                                                .toString(),
                                      ),
                                      // SizedBox(
                                      //   height: Get.height * 0.02,
                                      // ),

                                      // SUB
                                      EditProfileCustomTextField(
                                        onTap: () async {
                                          if (edit.selectedspecialities !=
                                              null) {
                                            edit.selectedsubspecialities = null;
                                            Specialities1 generic =
                                                await searchabledropdown(
                                                    context,
                                                    edit.subspecialitiesList);
                                            edit.selectedsubspecialities = null;
                                            edit.updateselectedspeciality(
                                                generic);

                                            if (generic.id != null) {
                                              edit.selectedsubspecialities =
                                                  generic;
                                              edit.selectedsubspecialities =
                                                  (generic.id != null)
                                                      ? null
                                                      : edit
                                                          .selectedsubspecialities;
                                            }
                                          }
                                        },
                                        readonly: true,
                                        hintText: edit
                                                    .selectedsubspecialities ==
                                                null
                                            ? 'subspeciality'.tr
                                            : edit.selectedsubspecialities!
                                                        .id ==
                                                    null
                                                ? 'subspeciality'.tr
                                                : edit.selectedsubspecialities!
                                                    .name
                                                    .toString(),
                                      ),
                                      SizedBox(height: Get.height * 0.03),

                                      InkWell(
                                        onTap: () async {
                                          ProfileRepo pr = ProfileRepo();

                                          if (_editformKey.currentState!
                                              .validate()) {
                                            String res =
                                                await pr.editSpecilization(
                                              // send id
                                              edit.selectedupdateid,
                                              edit.selectedspecialities!.id ??
                                                  "",
                                              edit.selectedsubspecialities
                                                      ?.id ??
                                                  "",
                                            );

                                            if (res == "true") {
                                              ProfileController.i
                                                  .updateaddval(false);
                                              _getDoctorBasicInfo();
                                              setState(() {});
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: Get.height * 0.07,
                                          width: Get.width * 1,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                              child: edit.isloading == false
                                                  ? Text(
                                                      'edit'.tr,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorManager
                                                              .kWhiteColor),
                                                    )
                                                  : const CircularProgressIndicator(
                                                      color: ColorManager
                                                          .kWhiteColor,
                                                    )),
                                        ),
                                      ),

                                      SizedBox(height: Get.height * 0.03),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : GetBuilder<ProfileController>(
                        builder: (contr) => Container(
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
                                  padding:
                                      EdgeInsets.only(right: Get.width * 0.04),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ImageContainer(
                                        onpressed: () {
                                          add.addselectedsubspecialities = null;
                                          add.addselectedspecialities = null;
                                          ProfileController.i
                                              .updateaddval(true);
                                          ProfileController.i
                                              .updateisEdit(true);
                                          setState(() {});
                                        },
                                        imagePath: Images.add,
                                        isSvg: false,
                                        color: ColorManager.kPrimaryColor,
                                        backgroundColor:
                                            ColorManager.kWhiteColor,
                                        boxheight: Get.height * 0.04,
                                        boxwidth: Get.width * 0.08,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                specilization.specilizationList.isNotEmpty
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
                                                  'speciality'.tr,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: ColorManager
                                                        .kWhiteColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.28,
                                            child: Text(
                                              'subspeciality'.tr,
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
                                              'default'.tr,
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
                                specilization.specilizationList.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: specilization
                                            .specilizationList.length,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.004,
                                                        ),
                                                        if (ProfileController
                                                                .i
                                                                .specilizationList[
                                                                    index]
                                                                .isDefault !=
                                                            1)
                                                          InkWell(
                                                            onTap: () {
                                                              String sid =
                                                                  ProfileController
                                                                      .i
                                                                      .specilizationList[
                                                                          index]
                                                                      .specialityId!;
                                                              String ssid = ProfileController
                                                                          .i
                                                                          .specilizationList[
                                                                              index]
                                                                          .subSpecialityId ==
                                                                      null
                                                                  ? ""
                                                                  : ProfileController
                                                                      .i
                                                                      .specilizationList[
                                                                          index]
                                                                      .subSpecialityId!;

                                                              deleteSpecilization(
                                                                  context,
                                                                  sid,
                                                                  ssid);
                                                            },
                                                            child:
                                                                ImageContainerNew(
                                                              imagePath:
                                                                  AppImages
                                                                      .cross,
                                                              isSvg: false,
                                                              color: ColorManager
                                                                  .kRedColor,
                                                              backgroundColor:
                                                                  ColorManager
                                                                      .kWhiteColor,
                                                              boxheight:
                                                                  Get.height *
                                                                      0.03,
                                                              boxwidth:
                                                                  Get.width *
                                                                      0.06,
                                                            ),
                                                          ),
                                                        if (ProfileController
                                                                .i
                                                                .specilizationList[
                                                                    index]
                                                                .isDefault ==
                                                            1)
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.03,
                                                            width: Get.width *
                                                                0.06,
                                                          ),

                                                        // ImageContainerNew(
                                                        //   onpressed: () {
                                                        //     _getDoctorBasicInfo();
                                                        //     EditProfileController.i.updateEditSelectedSpecialities(
                                                        //         ProfileController
                                                        //             .i
                                                        //             .specilizationList[
                                                        //                 index]
                                                        //             .specialityId,
                                                        //         ProfileController
                                                        //             .i
                                                        //             .specilizationList[
                                                        //                 index]
                                                        //             .speciality,
                                                        //         ProfileController
                                                        //             .i
                                                        //             .specilizationList[
                                                        //                 index]
                                                        //             .subSpecialityId,
                                                        //         ProfileController
                                                        //             .i
                                                        //             .specilizationList[
                                                        //                 index]
                                                        //             .subSpeciality,
                                                        //         ProfileController
                                                        //             .i
                                                        //             .specilizationList[
                                                        //                 index]
                                                        //             .id);
                                                        //     ProfileController.i
                                                        //         .updateval(
                                                        //             true);
                                                        //     ProfileController.i
                                                        //         .updateisEdit(
                                                        //             true);
                                                        //     setState(() {});
                                                        //   },
                                                        //   imagePath:
                                                        //       AppImages.editbig,
                                                        //   isSvg: false,
                                                        //   color: ColorManager
                                                        //       .kPrimaryColor,
                                                        //   backgroundColor:
                                                        //       ColorManager
                                                        //           .kWhiteColor,
                                                        //   // imageheight: Get.height * 0.02,
                                                        //   boxheight:
                                                        //       Get.height * 0.03,
                                                        //   boxwidth:
                                                        //       Get.width * 0.06,
                                                        // ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.002,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.25,
                                                          child: Text(
                                                            ProfileController
                                                                    .i
                                                                    .specilizationList[
                                                                        index]
                                                                    .speciality ??
                                                                "",
                                                            style: GoogleFonts
                                                                .poppins(
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
                                                    width: Get.width * 0.28,
                                                    child: Text(
                                                      ProfileController
                                                              .i
                                                              .specilizationList[
                                                                  index]
                                                              .subSpeciality ??
                                                          "",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 11,
                                                        color: ColorManager
                                                            .kWhiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: Get.width * 0.2,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          String sid =
                                                              ProfileController
                                                                  .i
                                                                  .specilizationList[
                                                                      index]
                                                                  .specialityId!;
                                                          String ssid = ProfileController
                                                                      .i
                                                                      .specilizationList[
                                                                          index]
                                                                      .subSpecialityId ==
                                                                  null
                                                              ? ""
                                                              : ProfileController
                                                                  .i
                                                                  .specilizationList[
                                                                      index]
                                                                  .subSpecialityId!;

                                                          if (ProfileController
                                                                  .i
                                                                  .specilizationList[
                                                                      index]
                                                                  .isDefault !=
                                                              1) {
                                                            ProfileRepo pr =
                                                                ProfileRepo();

                                                            String res = await pr
                                                                .setdefaultSpecilization(
                                                                    sid, ssid);

                                                            if (res == "true") {
                                                              _getDoctorBasicInfo();

                                                              setState(() {});
                                                            }
                                                          }
                                                        },
                                                        child: Text(
                                                          (ProfileController
                                                                      .i
                                                                      .specilizationList[
                                                                          index]
                                                                      .isDefault ==
                                                                  1
                                                              ? "default".tr
                                                              : "SetDefault"
                                                                  .tr),
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 11,
                                                            color: ColorManager
                                                                .kWhiteColor,
                                                          ),
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
                      )),
      ),
    );
  }

  deleteSpecilization(
    BuildContext context,
    String specilizationid,
    String subspecilizationid,
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

                      String res = await pr.deleteSpecilization(
                          specilizationid, subspecilizationid);

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
