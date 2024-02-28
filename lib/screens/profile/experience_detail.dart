import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/image_container.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/add_experience_controller.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/models/degree.dart';
import 'package:doctormobileapplication/models/doctor_details.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ExperienceDetail extends StatefulWidget {
  const ExperienceDetail({super.key});

  @override
  State<ExperienceDetail> createState() => _ExperienceDetailState();
}

class _ExperienceDetailState extends State<ExperienceDetail> {
  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  _getLocation() async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updateexperiencelocationList(
      await pr.getLocations(),
    );
  }

  var experience = Get.put<ProfileController>(ProfileController());
  var edit = Get.put<EditProfileController>(EditProfileController());
  var profile = Get.put<ProfileController>(ProfileController());
  var add = Get.put<AddExperienceController>(AddExperienceController());

  _getaddLocation() async {
    ProfileRepo pr = ProfileRepo();
    AddExperienceController.i.updateaddexperiencelocationList(
      await pr.getLocations(),
    );
  }

  _getOrganizationadd() async {
    ProfileRepo pr = ProfileRepo();
    AddExperienceController.i.updateOrganizationList(
      await pr.getOrganization(),
    );
  }

  _getOrganizationedit() async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updateExperienceOrganizationList(
      await pr.getOrganization(),
    );
  }

  @override
  void initState() {
    super.initState();
    _getOrganizationedit();
    _getaddLocation();
    _getOrganizationadd();
    _getDoctorBasicInfo();
    _getLocation();
    Future.delayed(Duration.zero, () async {
      ProfileController.i.updateselectedindex(3);
    });
  }

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
              ? GetBuilder<EditProfileController>(
                  builder: (contr) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _editformKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            EditProfileCustomTextField(
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return 'PleaseEnterJobTitle'.tr;
                                }
                                return null;
                              },
                              controller: edit.jobtitle,
                              hintText: 'JobTitle'.tr,
                            ),
                            EditProfileCustomTextField(
                              validator: (p0) {
                                if (edit.selectedExperienceOrganization?.id ==
                                    null) {
                                  return 'SelectOrganization'.tr;
                                }
                                return null;
                              },
                              onTap: () async {
                                Degrees generic = await searchabledropdown(
                                    context, edit.ExperienceOrganizationList);
                                edit.selectedExperienceOrganization = null;
                                edit.updateselectedExperienceOrganization(
                                    generic);

                                if (generic.id != null) {
                                  edit.selectedExperienceOrganization = generic;
                                  edit.selectedExperienceOrganization =
                                      (generic.id == null)
                                          ? null
                                          : edit.selectedExperienceOrganization;
                                }
                              },
                              readonly: true,
                              hintText: edit.selectedExperienceOrganization
                                          ?.name ==
                                      ""
                                  ? 'organization'.tr
                                  : edit.selectedExperienceOrganization?.name ??
                                      "SelectOrganization".tr,
                            ),
                            EditProfileCustomTextField(
                              onTap: () async {
                                Degrees generic = await searchabledropdown(
                                    context, edit.experiencelocationList);
                                edit.selectedexperiencelocation = null;
                                edit.updateselectedexperiencelocation(generic);

                                if (generic.id != null) {
                                  edit.selectedexperiencelocation = generic;
                                  edit.selectedexperiencelocation =
                                      (generic.id == null)
                                          ? null
                                          : edit.selectedexperiencelocation;
                                }
                              },
                              readonly: true,
                              hintText:
                                  edit.selectedexperiencelocation?.name == ""
                                      ? 'location'.tr
                                      : edit.selectedexperiencelocation?.name ??
                                          "SelectLocation".tr,
                            ),
                            EditProfileCustomTextField(
                                isSizedBoxAvailable: false,
                                onTap: () async {
                                  await edit.selectexperiencefromDateAndTime(
                                      context,
                                      EditProfileController.experiencefrom,
                                      edit.formateexperiencefrom);
                                },
                                readonly: true,
                                hintText: edit.formattedexperiencefrom
                                    .toString()
                                    .split("T")[0]),
                            SizedBox(
                              height: Get.height * 0.05,
                              child: Row(
                                children: <Widget>[
                                  Checkbox(
                                    side: MaterialStateBorderSide.resolveWith(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return const BorderSide(
                                              color: Colors.white);
                                        }
                                        return const BorderSide(
                                            color: Colors.white);
                                      },
                                    ),
                                    value: edit.currentlyworkingisChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        edit.currentlyworkingisChecked = value!;
                                      });
                                    },
                                    checkColor: ColorManager.kPrimaryColor,
                                    activeColor: ColorManager.kWhiteColor,
                                  ),
                                  Text(
                                    'CurrentlyWorking'.tr,
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: ColorManager.kWhiteColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: edit.currentlyworkingisChecked == false,
                              child: EditProfileCustomTextField(
                                  onTap: () async {
                                    await edit.selectexperiencetoDateAndTime(
                                        context,
                                        EditProfileController.experienceto,
                                        edit.formateexperienceto);
                                  },
                                  readonly: true,
                                  hintText: edit.todatetextvisible == true
                                      ? "SelectToDate".tr
                                      : edit.formattedexperienceto
                                          .toString()
                                          .split("T")[0]),
                            ),
                            InkWell(
                              onTap: () {
                                edit.picksingleexperiencefile();
                              },
                              child: Container(
                                width:
                                    Get.width * 1, // Adjust the width as needed
                                height: Get.height * 0.065,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    'Attachment'.tr,
                                    style: GoogleFonts.poppins(
                                      color: ColorManager.kWhiteColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            EditProfileCustomTextField(
                              controller: edit.experienceDescription,
                              hintText: 'Description'.tr,
                            ),
                            SizedBox(height: Get.height * 0.03),
                            SizedBox(height: Get.height * 0.03),
                            InkWell(
                              onTap: () async {
                                ProfileRepo pr = ProfileRepo();
                                AuthRepo ar = AuthRepo();
                                edit.updateisloading(true);
                                if (_editformKey.currentState!.validate()) {
                                  if (edit.experiencefile != null) {
                                    edit.editexperiencepath = await ar
                                        .uploadFile(edit.experiencefile!);
                                  }

                                  String res = await pr.editExperience(
                                      edit.editexperienceid,
                                      edit.jobtitle.text,
                                      edit.experienceDescription.text,
                                      edit.currentlyworkingisChecked,
                                      edit.selectedExperienceOrganization?.id,
                                      edit.selectedexperiencelocation?.id,
                                      edit.formattedexperiencefrom,
                                      edit.formattedexperienceto,
                                      edit.editexperiencepath);
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
                                    child: add.isaddloading == false
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
                )
              : contr.addval
                  // add new Controller
                  ? GetBuilder<AddExperienceController>(
                      builder: (contr) => Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _addformKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                EditProfileCustomTextField(
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return 'PleaseEnterJobTitle'.tr;
                                    }
                                    return null;
                                  },
                                  controller: add.jobtitle,
                                  hintText: 'JobTitle'.tr,
                                ),
                                EditProfileCustomTextField(
                                  validator: (p0) {
                                    if (add.selectedOrganization?.id == null) {
                                      return 'SelectOrganization'.tr;
                                    }
                                    return null;
                                  },
                                  onTap: () async {
                                    Degrees generic = await searchabledropdown(
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
                                  hintText: add.selectedOrganization?.name == ""
                                      ? 'organization'.tr
                                      : add.selectedOrganization?.name ??
                                          "SelectOrganization".tr,
                                ),
                                EditProfileCustomTextField(
                                  // validator: (p0) {
                                  //   if (add.addselectedexperiencelocation!.id ==
                                  //       null) {
                                  //     return 'selectLocation'.tr;
                                  //   }
                                  //   return null;
                                  // },
                                  validator: (p0) {
                                    if (add.addselectedexperiencelocation?.id ==
                                        null) {
                                      return 'selectLocation'.tr;
                                    }
                                    return null;
                                  },
                                  onTap: () async {
                                    Degrees generic = await searchabledropdown(
                                        context, add.addexperiencelocationList);
                                    add.addselectedexperiencelocation = null;
                                    add.updateaddselectedexperiencelocation(
                                        generic);

                                    if (generic.id != null) {
                                      add.addselectedexperiencelocation =
                                          generic;
                                      add.addselectedexperiencelocation =
                                          (generic.id == null)
                                              ? null
                                              : add
                                                  .addselectedexperiencelocation;
                                    }
                                  },
                                  readonly: true,
                                  hintText:
                                      add.addselectedexperiencelocation?.name ==
                                              ""
                                          ? 'Location'.tr
                                          : add.addselectedexperiencelocation
                                                  ?.name ??
                                              "SelectLocation".tr,
                                ),
                                EditProfileCustomTextField(
                                    validator: (p0) {
                                      if (add.addexperiencefrom == false) {
                                        return 'SelectFromDate'.tr;
                                      }
                                      return null;
                                    },
                                    isSizedBoxAvailable: false,
                                    onTap: () async {
                                      await add.selectexperiencefromDateAndTime(
                                          context,
                                          AddExperienceController
                                              .experiencefrom,
                                          add.formateexperiencefrom);
                                    },
                                    readonly: true,
                                    hintText: add.addexperiencefrom == true
                                        ? add.formattedexperiencefrom
                                            .toString()
                                            .split("T")[0]
                                        : "SelectFromDate".tr),
                                SizedBox(
                                  height: Get.height * 0.05,
                                  child: Row(
                                    children: <Widget>[
                                      Checkbox(
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.selected)) {
                                              return const BorderSide(
                                                  color: Colors.white);
                                            }
                                            return const BorderSide(
                                                color: Colors.white);
                                          },
                                        ),
                                        value: add.currentlyworkingisChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            add.currentlyworkingisChecked =
                                                value!;
                                          });
                                        },
                                        checkColor: ColorManager.kPrimaryColor,
                                        activeColor: ColorManager.kWhiteColor,
                                      ),
                                      Text(
                                        'CurrentlyWorking'.tr,
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: ColorManager.kWhiteColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      add.currentlyworkingisChecked == false,
                                  child: EditProfileCustomTextField(
                                      validator: (p0) {
                                        if (add.addexperienceto == false) {
                                          return 'SelectToDate'.tr;
                                        }
                                        return null;
                                      },
                                      onTap: () async {
                                        await add.selectexperiencetoDateAndTime(
                                            context,
                                            AddExperienceController
                                                .experienceto,
                                            add.formateexperienceto);
                                      },
                                      readonly: true,
                                      hintText: add.addexperienceto == true
                                          ? add.formattedexperienceto
                                              .toString()
                                              .split("T")[0]
                                          : "SelectToDate".tr),
                                ),
                                InkWell(
                                  onTap: () {
                                    add.picksingleexperiencefile();
                                  },
                                  child: Container(
                                    width: Get.width *
                                        1, // Adjust the width as needed
                                    height: Get.height * 0.065,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Attachment'.tr,
                                        style: GoogleFonts.poppins(
                                          color: ColorManager.kWhiteColor,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                EditProfileCustomTextField(
                                  controller: add.experienceDescription,
                                  hintText: 'Description'.tr,
                                ),
                                SizedBox(height: Get.height * 0.03),
                                InkWell(
                                  onTap: () async {
                                    ProfileRepo pr = ProfileRepo();
                                    AuthRepo ar = AuthRepo();

                                    if (_addformKey.currentState!.validate()) {
                                      add.updateisaddloading(true);
                                      String path = "";
                                      if (add.experiencefile != null) {
                                        path = await ar
                                            .uploadFile(add.experiencefile!);
                                      }

                                      String res = await pr.addExperience(
                                          add.jobtitle.text,
                                          add.experienceDescription.text,
                                          add.currentlyworkingisChecked,
                                          add.selectedOrganization?.id,
                                          add.addselectedexperiencelocation?.id,
                                          add.formattedexperiencefrom,
                                          add.formattedexperienceto,
                                          path);
                                      if (res == "true") {
                                        _getDoctorBasicInfo();

                                        ProfileController.i.updateaddval(false);
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
                                                    fontWeight: FontWeight.bold,
                                                    color: ColorManager
                                                        .kWhiteColor),
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
                                      add.updateaddexperiencefrom(false);
                                      add.updateaddexperienceto(false);
                                      add.jobtitle.clear();
                                      add.experienceDescription.clear();
                                      add.currentlyworkingisChecked = false;
                                      add.selectedOrganization = null;
                                      add.addselectedexperiencelocation = null;
                                      add.formattedexperiencefrom =
                                          DateTime.now().toString();
                                      add.formattedexperienceto =
                                          DateTime.now().toString();
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
                            experience.experienceList.isNotEmpty
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
                            experience.experienceList.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: experience.experienceList.length,
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
                                                    //   onpressed: () {
                                                    //     String id =
                                                    //         ProfileController
                                                    //                 .i
                                                    //                 .bankDetailList[
                                                    //                     index]
                                                    //                 .id ??
                                                    //             "";
                                                    //     deleteExperience(
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
                                                        Expereinces e =
                                                            Expereinces();
                                                        e = experience
                                                                .experienceList[
                                                            index];
                                                        edit.updateEditSelectedExperience(
                                                            e);
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
                                                                .experienceList[
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
                                                          .experienceList[index]
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
                                                                .experienceList[
                                                                    index]
                                                                .fromDate !=
                                                            null)
                                                        ? ((ProfileController
                                                                    .i
                                                                    .experienceList[
                                                                        index]
                                                                    .toDate !=
                                                                null)
                                                            ? '${DateFormat('MM-dd-y').format(DateTime.parse(ProfileController.i.experienceList[index].fromDate!.split("T")[0]))} To ${DateFormat('MM-dd-y').format(DateTime.parse(ProfileController.i.experienceList[index].toDate!.split("T")[0]))}'
                                                            : '${DateFormat('MM-dd-y').format(DateTime.parse(ProfileController.i.experienceList[index].fromDate!.split("T")[0]))} To Present')
                                                        : "-",
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

  deleteExperience(
    BuildContext context,
    String id,
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

                      String res = await pr.deleteExperience(id);

                      if (res == "true") {
                        _getDoctorBasicInfo();

                        setState(() {});
                      }

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
