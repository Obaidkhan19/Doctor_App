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
import 'package:doctormobileapplication/screens/profile/add_membership.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _getaddLocations();
    _getLocations();
    Future.delayed(Duration.zero, () async {
      ProfileController.i.updateselectedindex(5);
    });
  }

  // bool editchk = false;
  // bool addchck = false;
  var membership = Get.put<ProfileController>(ProfileController());
  var edit = Get.put<EditProfileController>(EditProfileController());
  var add = Get.put<AddMembershipController>(AddMembershipController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
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
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        EditProfileCustomTextField(
                          controller: edit.membershiptitle,
                          hintText: 'Title',
                        ),

                        EditProfileCustomTextField(
                          controller: edit.membershipcode,
                          hintText: 'Code',
                        ),

                        // organization

                        // location
                        EditProfileCustomTextField(
                          onTap: () async {
                            Degrees generic = await searchabledropdown(
                                context, edit.membershiplocationList ?? []);
                            edit.selectedmembershiplocation = null;
                            edit.updateselectedmembershiplocation(generic);

                            if (generic != '') {
                              edit.selectedmembershiplocation = generic;
                              edit.selectedmembershiplocation = (generic == '')
                                  ? null
                                  : edit.selectedmembershiplocation;
                            }
                          },
                          readonly: true,
                          hintText: edit.selectedmembershiplocation?.name == ""
                              ? 'Location'.tr
                              : edit.selectedmembershiplocation?.name ??
                                  "Select Location",
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
                                      .split("T")[0] ==
                                  DateTime.now().toString().split(" ")[0]
                              ? "Select From Date"
                              : DateFormat('MM-dd-y').format(DateTime.parse(edit
                                  .formattedmembershipfrom
                                  .toString()
                                  .split(" ")[0])),
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
                                      .split("T")[0] ==
                                  DateTime.now().toString().split(" ")[0]
                              ? "Select From Date"
                              : DateFormat('MM-dd-y').format(DateTime.parse(edit
                                  .formattedmembershipto
                                  .toString()
                                  .split(" ")[0])),
                        ),

                        EditProfileCustomTextField(
                          controller: edit.membershipdescription,
                          hintText: 'Description',
                        ),
                        SizedBox(height: Get.height * 0.03),
                        PrimaryButton(
                            fontSize: 15,
                            title: 'Edit'.tr,
                            onPressed: () async {
                              ProfileController.i.updateval(false);
                              setState(() {});
                            },
                            color: ColorManager.kWhiteColor.withOpacity(0.7),
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
                  child: GetBuilder<AddMembershipController>(
                    builder: (contr) => Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            EditProfileCustomTextField(
                              controller: add.membershiptitle,
                              hintText: 'Title',
                            ),

                            EditProfileCustomTextField(
                              controller: add.membershipcode,
                              hintText: 'Code',
                            ),

                            // organization

                            // location
                            EditProfileCustomTextField(
                              onTap: () async {
                                Degrees generic = await searchabledropdown(
                                    context,
                                    add.addmembershiplocationList ?? []);
                                add.addselectedmembershiplocation = null;
                                add.updateaddselectedmembershiplocation(
                                    generic);

                                if (generic != '') {
                                  add.addselectedmembershiplocation = generic;
                                  add.addselectedmembershiplocation =
                                      (generic == '')
                                          ? null
                                          : add.addselectedmembershiplocation;
                                }
                              },
                              readonly: true,
                              hintText:
                                  add.addselectedmembershiplocation?.name == ""
                                      ? 'Location'.tr
                                      : add.addselectedmembershiplocation
                                              ?.name ??
                                          "Select Location",
                            ),

                            EditProfileCustomTextField(
                              onTap: () async {
                                await add.selectmembershipfromDateAndTime(
                                    context,
                                    AddMembershipController.membershipfrom,
                                    add.formatemembershipfrom);
                              },
                              readonly: true,
                              hintText: add.formattedmembershipfrom
                                          .toString()
                                          .split("T")[0] ==
                                      DateTime.now().toString().split(" ")[0]
                                  ? "Select From Date"
                                  : DateFormat('MM-dd-y').format(DateTime.parse(
                                      add.formattedmembershipfrom
                                          .toString()
                                          .split(" ")[0])),
                            ),

                            EditProfileCustomTextField(
                              onTap: () async {
                                await add.selectmembershiptoDateAndTime(
                                    context,
                                    AddMembershipController.membershipto,
                                    add.formatemembershipto);
                              },
                              readonly: true,
                              hintText: add.formattedmembershipto
                                          .toString()
                                          .split("T")[0] ==
                                      DateTime.now().toString().split(" ")[0]
                                  ? "Select From Date"
                                  : DateFormat('MM-dd-y').format(DateTime.parse(
                                      add.formattedmembershipto
                                          .toString()
                                          .split(" ")[0])),
                            ),

                            EditProfileCustomTextField(
                              controller: add.membershipdescription,
                              hintText: 'Description',
                            ),
                            SizedBox(height: Get.height * 0.03),
                            PrimaryButton(
                                fontSize: 15,
                                title: 'Add'.tr,
                                onPressed: () async {
                                  ProfileController.i.updateaddval(false);
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
                                              color: ColorManager.kPrimaryColor,
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
                                      'Organization',
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
                                      'Date',
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
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: membership.membershipList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                  imagePath: AppImages.cross,
                                                  //  imageheight: Get.height * 0.03,
                                                  isSvg: false,
                                                  color: ColorManager.kRedColor,
                                                  backgroundColor:
                                                      ColorManager.kWhiteColor,
                                                  boxheight: Get.height * 0.03,
                                                  boxwidth: Get.width * 0.06,
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
                                                  imagePath: AppImages.editbig,
                                                  isSvg: false,
                                                  color: ColorManager
                                                      .kPrimaryColor,
                                                  backgroundColor:
                                                      ColorManager.kWhiteColor,
                                                  // imageheight: Get.height * 0.02,
                                                  boxheight: Get.height * 0.03,
                                                  boxwidth: Get.width * 0.06,
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
                                                    style: GoogleFonts.poppins(
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
                                                color: ColorManager.kWhiteColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              width: Get.width * 0.2,
                                              child: Text(
                                                "${DateFormat.yMMMd().format((DateTime.parse("${contr.membershipList[index].fromDate.toString().split('T').first} ${contr.membershipList[index].fromDate.toString().split('T').last}")))} To ${DateFormat.yMMMd().format((DateTime.parse("${contr.membershipList[index].toDate.toString().split('T').first} ${contr.membershipList[index].toDate.toString().split('T').last}")))}",
                                                //"${(ProfileController.i.membershipList[index].fromDate != null) ? "${ProfileController.i.experienceList[index].fromDate!.split("T").first} ${ProfileController.i.experienceList[index].fromDate!.split("T").last}" : "-"} ${" To "} ${(ProfileController.i.membershipList[index].fromDate != null) ? "${"${ProfileController.i.membershipList[index].toDate!.split("T").first} ${ProfileController.i.experienceList[index].toDate!.split("T").last}"} " : "-"}  ",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                  color:
                                                      ColorManager.kWhiteColor,
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
    );
  }
}
