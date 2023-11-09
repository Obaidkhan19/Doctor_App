import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/image_container.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/degree.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:doctormobileapplication/screens/profile/add_bank.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BankDetail extends StatefulWidget {
  const BankDetail({super.key});

  @override
  State<BankDetail> createState() => _BankDetailState();
}

class _BankDetailState extends State<BankDetail> {
  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  var edit = Get.put<EditProfileController>(EditProfileController());

  _getBanks() async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updatedbankList(
      await pr.getBanks(),
    );
  }

  @override
  void initState() {
    _getBanks();
    super.initState();
  }

  var bankdetail = Get.put<ProfileController>(ProfileController());
  bool editchk = false;
  bool addchck = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (contr) => editchk
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
                        RegisterCustomTextField(
                          onTap: () async {
                            Degrees generic = await searchabledropdown(
                                context, edit.bankList ?? []);
                            edit.selectedbank = null;
                            edit.updateselectedbank(generic);

                            if (generic != '') {
                              edit.selectedbank = generic;
                              edit.selectedbank =
                                  (generic == '') ? null : edit.selectedbank;
                            }
                          },
                          readonly: true,
                          suffixIcon: IconButton(
                              onPressed: () async {
                                Degrees generic = await searchabledropdown(
                                    context, edit.bankList ?? []);
                                edit.selectedbank = null;
                                edit.updateselectedbank(generic);

                                if (generic != '') {
                                  edit.selectedbank = generic;
                                  edit.selectedbank = (generic == '')
                                      ? null
                                      : edit.selectedbank;
                                }
                              },
                              icon: Image.asset(Images.dropdown)),
                          hintText: edit.selectedbank?.name == ""
                              ? 'bank'.tr
                              : edit.selectedbank?.name ?? "Select Bank",
                        ),
                        AuthTextField(
                          controller: edit.accountTitle,
                          hintText: 'Account Title',
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        AuthTextField(
                          controller: edit.accountNo,
                          hintText: 'Account Number',
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        InkWell(
                          onTap: () {
                            edit.picksingleBankfile();
                          },
                          child: Container(
                            width: Get.width * 1, // Adjust the width as needed
                            height: Get.height * 0.07,
                            decoration: BoxDecoration(
                              color: ColorManager.kPrimaryColor,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                'Upload File',
                                style: GoogleFonts.poppins(
                                  color: ColorManager.kWhiteColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.03),
                        PrimaryButton(
                            fontSize: 15,
                            title: 'Edit'.tr,
                            onPressed: () async {
                              editchk = false;
                              setState(() {});
                            },
                            color: ColorManager.kPrimaryColor,
                            textcolor: ColorManager.kWhiteColor),
                        SizedBox(height: Get.height * 0.03),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : addchck
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
                              onTap: () async {
                                Degrees generic = await searchabledropdown(
                                    context, edit.bankList ?? []);
                                edit.selectedbank = null;
                                edit.updateselectedbank(generic);

                                if (generic != '') {
                                  edit.selectedbank = generic;
                                  edit.selectedbank = (generic == '')
                                      ? null
                                      : edit.selectedbank;
                                }
                              },
                              readonly: true,
                              hintText: edit.selectedbank?.name == ""
                                  ? 'bank'.tr
                                  : edit.selectedbank?.name ?? "Select Bank",
                            ),
                            EditProfileCustomTextField(
                              controller: edit.accountTitle,
                              hintText: 'Account Title',
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            EditProfileCustomTextField(
                              controller: edit.accountNo,
                              hintText: 'Account Number',
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            InkWell(
                              onTap: () {
                                edit.picksingleBankfile();
                              },
                              child: Container(
                                width:
                                    Get.width * 1, // Adjust the width as needed
                                height: Get.height * 0.07,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    'Upload File',
                                    style: GoogleFonts.poppins(
                                      color: ColorManager.kWhiteColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Get.height * 0.03),
                            PrimaryButton(
                                fontSize: 15,
                                title: 'Add'.tr,
                                onPressed: () async {
                                  addchck = false;
                                  setState(() {});
                                },
                                color: Colors.white.withOpacity(0.7),
                                textcolor: ColorManager.kWhiteColor),
                            SizedBox(height: Get.height * 0.03),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Scaffold(
                  body: Container(
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
                                    //   Get.to(() => const AddBank());
                                    // callback
                                    addchck = true;
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
                          bankdetail.bankDetailList.isNotEmpty
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
                                                color:
                                                    ColorManager.kPrimaryColor,
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
                                      width: Get.width * 0.28,
                                      child: Text(
                                        'Bank',
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
                                        'Default',
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
                          bankdetail.bankDetailList.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: bankdetail.bankDetailList.length,
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
                                                    imagePath: AppImages.cross,
                                                    //  imageheight: Get.height * 0.03,
                                                    isSvg: false,
                                                    color:
                                                        ColorManager.kRedColor,
                                                    backgroundColor:
                                                        ColorManager
                                                            .kWhiteColor,
                                                    boxheight:
                                                        Get.height * 0.03,
                                                    boxwidth: Get.width * 0.06,
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.004,
                                                  ),
                                                  ImageContainerNew(
                                                    onpressed: () {
                                                      editchk = true;
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
                                                              .bankDetailList[
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
                                              width: Get.width * 0.28,
                                              child: Text(
                                                ProfileController
                                                        .i
                                                        .bankDetailList[index]
                                                        .bankName ??
                                                    "",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 11,
                                                  color:
                                                      ColorManager.kWhiteColor,
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
                                                                .bankDetailList[
                                                                    index]
                                                                .isDefault ==
                                                            1
                                                        ? "Default"
                                                        : "Set Default"),
                                                    style: GoogleFonts.poppins(
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
                                    "No Record Found",
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
    );
  }
}
