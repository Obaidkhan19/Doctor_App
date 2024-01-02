import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/image_container.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/add_membership_controller.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/degree.dart';
import 'package:doctormobileapplication/models/doctor_details.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MemberShip extends StatefulWidget {
  const MemberShip({super.key});

  @override
  State<MemberShip> createState() => _MemberShipState();
}

class _MemberShipState extends State<MemberShip> {
  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  _getLocations() async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updatemembershiplocationList(
      await pr.getLocations(),
    );
  }

  _getaddLocations() async {
    ProfileRepo pr = ProfileRepo();
    AddMembershipController.i.updateaddmembershiplocationList(
      await pr.getLocations(),
    );
  }

  _getaddLOrganization() async {
    ProfileRepo pr = ProfileRepo();
    AddMembershipController.i.updateOrganizationList(
      await pr.getOrganization(),
    );
  }

  _geteditLOrganization() async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updateMembershipOrganizationList(
      await pr.getOrganization(),
    );
  }

  @override
  void initState() {
    super.initState();
    _getaddLOrganization();
    _geteditLOrganization();
    _getDoctorBasicInfo();
    _getaddLocations();
    _getLocations();
    Future.delayed(Duration.zero, () async {
      ProfileController.i.updateselectedindex(5);
    });
  }

  // bool editchk = false;
  // bool addchck = false;
  var profile = Get.put<ProfileController>(ProfileController());
  var membership = Get.put<ProfileController>(ProfileController());
  var edit = Get.put<EditProfileController>(EditProfileController());
  var add = Get.put<AddMembershipController>(AddMembershipController());

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
                                controller: edit.membershiptitle,
                                hintText: 'title'.tr,
                              ),

                              EditProfileCustomTextField(
                                controller: edit.membershipcode,
                                hintText: 'code'.tr,
                              ),

                              // organization

                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (edit.selectedMembershipOrganization?.id ==
                                      null) {
                                    return 'SelectOrganization'.tr;
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  Degrees generic = await searchabledropdown(
                                      context, edit.MembershipOrganizationList);
                                  edit.selectedMembershipOrganization = null;
                                  edit.updateselectedMembershipOrganization(
                                      generic);

                                  if (generic.id != null) {
                                    edit.selectedMembershipOrganization =
                                        generic;
                                    edit.selectedMembershipOrganization =
                                        (generic.id == null)
                                            ? null
                                            : edit
                                                .selectedMembershipOrganization;
                                  }
                                },
                                readonly: true,
                                hintText:
                                    edit.selectedMembershipOrganization?.name ==
                                            ""
                                        ? 'organization'.tr
                                        : edit.selectedMembershipOrganization
                                                ?.name ??
                                            "SelectOrganization".tr,
                              ),
                              // location
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (edit.selectedmembershiplocation?.id ==
                                      null) {
                                    return 'selectlocation'.tr;
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  Degrees generic = await searchabledropdown(
                                      context, edit.membershiplocationList);
                                  edit.selectedmembershiplocation = null;
                                  edit.updateselectedmembershiplocation(
                                      generic);

                                  if (generic.id == null) {
                                    edit.selectedmembershiplocation = generic;
                                    edit.selectedmembershiplocation =
                                        (generic.id == null)
                                            ? null
                                            : edit.selectedmembershiplocation;
                                  }
                                },
                                readonly: true,
                                hintText:
                                    edit.selectedmembershiplocation?.name == ""
                                        ? 'location'.tr
                                        : edit.selectedmembershiplocation
                                                ?.name ??
                                            "selectLocation".tr,
                              ),

                              EditProfileCustomTextField(
                                onTap: () async {
                                  await edit.selectmembershipfromDateAndTime(
                                      context,
                                      EditProfileController.membershipfrom,
                                      edit.formatemembershipfrom);
                                },
                                readonly: true,
                                hintText: edit.formattedmembershipfrom
                                    .toString()
                                    .split("T")[0],
                              ),

                              EditProfileCustomTextField(
                                  onTap: () async {
                                    await edit.selectmembershiptoDateAndTime(
                                        context,
                                        EditProfileController.membershipto,
                                        edit.formatemembershipto);
                                  },
                                  readonly: true,
                                  hintText: edit.formattedmembershipto
                                      .toString()
                                      .split("T")[0]),

                              EditProfileCustomTextField(
                                controller: edit.membershipdescription,
                                hintText: 'description'.tr,
                              ),
                              SizedBox(height: Get.height * 0.03),

                              InkWell(
                                onTap: () async {
                                  ProfileRepo pr = ProfileRepo();
                                  edit.membershiptitle.text;
                                  edit.membershipcode.text;
                                  edit.formattedmembershipfrom;
                                  edit.formattedmembershipto;
                                  edit.membershipdescription.text;
                                  edit.selectedMembershipOrganization?.id;
                                  edit.selectedmembershiplocation?.id;
                                  if (_editformKey.currentState!.validate()) {
                                    edit.updateisloading(true);
                                    String res = await pr.editMembership(
                                        edit.editmembershipid,
                                        edit.membershiptitle.text,
                                        edit.membershipcode.text,
                                        edit.formattedmembershipfrom,
                                        edit.formattedmembershipto,
                                        edit.membershipdescription.text,
                                        edit.selectedMembershipOrganization?.id,
                                        edit.selectedmembershiplocation?.id);
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
                      child: GetBuilder<AddMembershipController>(
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
                                    controller: add.membershiptitle,
                                    hintText: 'title'.tr,
                                  ),

                                  EditProfileCustomTextField(
                                    controller: add.membershipcode,
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
                                      if (add.addselectedmembershiplocation
                                              ?.id ==
                                          null) {
                                        return 'selectlocation'.tr;
                                      }
                                      return null;
                                    },
                                    onTap: () async {
                                      Degrees generic =
                                          await searchabledropdown(context,
                                              add.addmembershiplocationList);
                                      add.addselectedmembershiplocation = null;
                                      add.updateaddselectedmembershiplocation(
                                          generic);

                                      if (generic.id == null) {
                                        add.addselectedmembershiplocation =
                                            generic;
                                        add.addselectedmembershiplocation =
                                            (generic.id == null)
                                                ? null
                                                : add
                                                    .addselectedmembershiplocation;
                                      }
                                    },
                                    readonly: true,
                                    hintText: add.addselectedmembershiplocation
                                                ?.name ==
                                            ""
                                        ? 'location'.tr
                                        : add.addselectedmembershiplocation
                                                ?.name ??
                                            "SelectLocation".tr,
                                  ),

                                  EditProfileCustomTextField(
                                      validator: (p0) {
                                        if (add.addmembershipfrom == false) {
                                          return 'SelectFromDate'.tr;
                                        }
                                        return null;
                                      },
                                      onTap: () async {
                                        await add
                                            .selectmembershipfromDateAndTime(
                                                context,
                                                AddMembershipController
                                                    .membershipfrom,
                                                add.formatemembershipfrom);
                                      },
                                      readonly: true,
                                      hintText: add.addmembershipfrom == true
                                          ? add.formattedmembershipfrom
                                              .toString()
                                              .split("T")[0]
                                          : "SelectFromDate".tr),

                                  EditProfileCustomTextField(
                                    validator: (p0) {
                                      if (add.addmembershipto == false) {
                                        return 'SelectToDate'.tr;
                                      }
                                      return null;
                                    },
                                    onTap: () async {
                                      await add.selectmembershiptoDateAndTime(
                                          context,
                                          AddMembershipController.membershipto,
                                          add.formatemembershipto);
                                    },
                                    readonly: true,
                                    hintText: add.addmembershipto == true
                                        ? add.formattedmembershipto
                                            .toString()
                                            .split("T")[0]
                                        : "SelectToDate".tr,
                                  ),

                                  EditProfileCustomTextField(
                                    controller: add.membershipdescription,
                                    hintText: 'description'.tr,
                                  ),
                                  SizedBox(height: Get.height * 0.03),
                                  InkWell(
                                    onTap: () async {
                                      ProfileRepo pr = ProfileRepo();
                                      if (_addformKey.currentState!
                                          .validate()) {
                                        add.updateisaddloading(true);
                                        String res = await pr.addMembership(
                                            add.membershiptitle.text,
                                            add.membershipcode.text,
                                            add.formattedmembershipfrom,
                                            add.formattedmembershipto,
                                            add.membershipdescription.text,
                                            add.selectedOrganization?.id,
                                            add.addselectedmembershiplocation
                                                ?.id);
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
                                      add.updateaddmembershipfrom(false);
                                      add.updateaddmembershipto(false);
                                      add.membershiptitle.clear();
                                      add.membershipcode.clear();
                                      add.formattedmembershipfrom =
                                          DateTime.now().toString();
                                      add.formattedmembershipto =
                                          DateTime.now().toString();
                                      add.membershipdescription.clear();
                                      add.selectedOrganization = null;
                                      add.addselectedmembershiplocation = null;
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
                            membership.membershipList.isNotEmpty
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
                            membership.membershipList.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: membership.membershipList.length,
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
                                                    //                 .membershipList[
                                                    //                     index]
                                                    //                 .id ??
                                                    //             "";
                                                    //     deleteMembership(
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
                                                        Memberships m =
                                                            Memberships();
                                                        m = ProfileController.i
                                                                .membershipList[
                                                            index];
                                                        edit.updateeditSelectedMemberhsip(
                                                            m);
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
                                                                .membershipList[
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
                                                          .membershipList[index]
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
                                                    "${DateFormat('MM-dd-y').format((DateTime.parse("${contr.membershipList[index].fromDate.toString().split('T').first} ${contr.membershipList[index].fromDate.toString().split('T').last}")))} To ${DateFormat('MM-dd-y').format((DateTime.parse("${contr.membershipList[index].toDate.toString().split('T').first} ${contr.membershipList[index].toDate.toString().split('T').last}")))}",
                                                    // "${(ProfileController.i.membershipList[index].fromDate != null) ? "${ProfileController.i.experienceList[index].fromDate!.split("T").first} ${ProfileController.i.experienceList[index].fromDate!.split("T").last}" : "-"} ${" To "} ${(ProfileController.i.membershipList[index].fromDate != null) ? "${"${ProfileController.i.membershipList[index].toDate!.split("T").first} ${ProfileController.i.experienceList[index].toDate!.split("T").last}"} " : "-"}  ",
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

  deleteMembership(
    BuildContext context,
    String membershipid,
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

                      String res = await pr.deleteMemebership(membershipid);

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
