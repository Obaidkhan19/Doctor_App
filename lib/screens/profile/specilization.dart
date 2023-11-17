import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/image_container.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/add_specialization_controller.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/speciality.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
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
    _getSpeciality();
    Future.delayed(Duration.zero, () async {
      ProfileController.i.updateselectedindex(4);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        builder: (contr) => contr.addval
            ? GetBuilder<AddSpecializationController>(
                builder: (contr) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        EditProfileCustomTextField(
                          onTap: () async {
                            add.addselectedspecialities = null;
                            Specialities1 generic = await searchabledropdown(
                                context, add.addspecialitiesList ?? []);
                            add.addselectedspecialities = null;
                            add.updateaddselectedspeciality(generic);

                            if (generic != '') {
                              add.addselectedspecialities = generic;
                              add.addselectedspecialities = (generic == '')
                                  ? null
                                  : add.addselectedspecialities;
                            }

                            setState(() {
                              _getaddSubSpeciality(generic.id);
                            });
                          },
                          readonly: true,
                          hintText: add.addselectedspecialities == null
                              ? 'speciality'.tr
                              : add.addselectedspecialities!.name.toString(),
                        ),
                        // SizedBox(
                        //   height: Get.height * 0.02,
                        // ),

                        // SUB
                        EditProfileCustomTextField(
                          onTap: () async {
                            add.addselectedsubspecialities = null;
                            Specialities1 generic = await searchabledropdown(
                                context, add.addsubspecialitiesList ?? []);
                            add.addselectedsubspecialities = null;
                            add.updateaddselectedspeciality(generic);

                            if (generic != '') {
                              add.addselectedsubspecialities = generic;
                              add.addselectedsubspecialities = (generic == '')
                                  ? null
                                  : add.addselectedsubspecialities;
                            }
                          },
                          readonly: true,
                          hintText: add.addselectedsubspecialities == null
                              ? 'subspeciality'.tr
                              : add.addselectedsubspecialities!.name.toString(),
                        ),
                        SizedBox(height: Get.height * 0.03),
                        PrimaryButton(
                            fontSize: 15,
                            title: 'Add'.tr,
                            onPressed: () async {
                              ProfileController.i.updateaddval(false);
                              setState(() {});
                            },
                            color: Colors.white.withOpacity(0.7),
                            textcolor: ColorManager.kWhiteColor),
                        SizedBox(height: Get.height * 0.03),
                      ],
                    ),
                  ),
                ),
              )
            : contr.editval
                ? GetBuilder<EditProfileController>(
                    builder: (contr) => Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            EditProfileCustomTextField(
                              onTap: () async {
                                edit.selectedspecialities = null;
                                Specialities1 generic =
                                    await searchabledropdown(
                                        context, edit.specialitiesList ?? []);
                                edit.selectedspecialities = null;
                                edit.updateselectedspeciality(generic);

                                if (generic != '') {
                                  edit.selectedspecialities = generic;
                                  edit.selectedspecialities = (generic == '')
                                      ? null
                                      : edit.selectedspecialities;
                                }

                                setState(() {
                                  _getSubSpeciality(generic.id);
                                });
                              },
                              readonly: true,
                              hintText: edit.selectedspecialities == null
                                  ? 'speciality'.tr
                                  : edit.selectedspecialities!.name.toString(),
                            ),
                            // SizedBox(
                            //   height: Get.height * 0.02,
                            // ),

                            // SUB
                            EditProfileCustomTextField(
                              onTap: () async {
                                edit.selectedsubspecialities = null;
                                Specialities1 generic =
                                    await searchabledropdown(context,
                                        edit.subspecialitiesList ?? []);
                                edit.selectedsubspecialities = null;
                                edit.updateselectedspeciality(generic);

                                if (generic != '') {
                                  edit.selectedsubspecialities = generic;
                                  edit.selectedsubspecialities = (generic == '')
                                      ? null
                                      : edit.selectedsubspecialities;
                                }
                              },
                              readonly: true,
                              hintText: edit.selectedsubspecialities == null
                                  ? 'subspeciality'.tr
                                  : edit.selectedsubspecialities!.id == null
                                      ? 'subspeciality'.tr
                                      : edit.selectedsubspecialities!.name
                                          .toString(),
                            ),
                            SizedBox(height: Get.height * 0.03),
                            PrimaryButton(
                                fontSize: 15,
                                title: 'Edit'.tr,
                                onPressed: () async {
                                  ProfileController.i.updateval(false);
                                  setState(() {});
                                },
                                color: Colors.white.withOpacity(0.7),
                                textcolor: ColorManager.kWhiteColor),
                            SizedBox(height: Get.height * 0.03),
                          ],
                        ),
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
                                                color: ColorManager.kWhiteColor,
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
                                    itemCount:
                                        specilization.specilizationList.length,
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
                                                        EditProfileController.i
                                                            .updateEditSelectedSpecialities(
                                                          ProfileController
                                                              .i
                                                              .specilizationList[
                                                                  index]
                                                              .specialityId,
                                                          ProfileController
                                                              .i
                                                              .specilizationList[
                                                                  index]
                                                              .speciality,
                                                          ProfileController
                                                              .i
                                                              .specilizationList[
                                                                  index]
                                                              .subSpecialityId,
                                                          ProfileController
                                                              .i
                                                              .specilizationList[
                                                                  index]
                                                              .subSpeciality,
                                                        );
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
                                                                .specilizationList[
                                                                    index]
                                                                .speciality ??
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
                                                width: Get.width * 0.28,
                                                child: Text(
                                                  ProfileController
                                                          .i
                                                          .specilizationList[
                                                              index]
                                                          .subSpeciality ??
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
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Text(
                                                      (ProfileController
                                                                  .i
                                                                  .specilizationList[
                                                                      index]
                                                                  .isDefault ==
                                                              1
                                                          ? "default".tr
                                                          : "SetDefault".tr),
                                                      style:
                                                          GoogleFonts.poppins(
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
                  ));
  }
}
