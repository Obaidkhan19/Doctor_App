import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/image_container.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/add_bank_controller.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/degree.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  var add = Get.put<AddBankController>(AddBankController());
  var profile = Get.put<ProfileController>(ProfileController());
  _getBanks() async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updatedbankList(
      await pr.getBanks(),
    );
  }

  _getaddBanks() async {
    ProfileRepo pr = ProfileRepo();
    AddBankController.i.updatedaddbankList(
      await pr.getBanks(),
    );
  }

  @override
  void initState() {
    _getBanks();
    _getDoctorBasicInfo();
    _getaddBanks();
    Future.delayed(Duration.zero, () async {
      ProfileController.i.updateselectedindex(7);
    });
    super.initState();
  }

  var bankdetail = Get.put<ProfileController>(ProfileController());

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
                          key: _addformKey,
                          child: Column(
                            children: [
                              EditProfileCustomTextField(
                                onTap: () async {
                                  Degrees generic = await searchabledropdown(
                                      context, edit.bankList);
                                  edit.selectedbank = null;
                                  edit.updateselectedbank(generic);

                                  if (generic.id != null) {
                                    edit.selectedbank = generic;
                                    edit.selectedbank = (generic.id == null)
                                        ? null
                                        : edit.selectedbank;
                                  }
                                },
                                validator: (p0) {
                                  if (edit.selectedbank!.id == null) {
                                    return 'SelectBank'.tr;
                                  } else {
                                    return null;
                                  }
                                },
                                readonly: true,
                                hintText: edit.selectedbank?.name == ""
                                    ? 'bank'.tr
                                    : edit.selectedbank?.name ??
                                        "SelectBank".tr,
                              ),
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return 'EnterAccountTitle'.tr;
                                  }
                                  return null;
                                },
                                controller: edit.accountTitle,
                                hintText: 'AccountTitle'.tr,
                              ),
                              EditProfileCustomTextField(
                                controller: edit.accountNo,
                                hintText: 'AccountNumber'.tr,
                              ),
                              InkWell(
                                onTap: () {
                                  edit.picksingleBankfile();
                                },
                                child: Container(
                                  width: Get.width *
                                      1, // Adjust th e width as needed
                                  height: Get.height * 0.065,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'UploadFile'.tr,
                                      style: GoogleFonts.poppins(
                                          color: ColorManager.kWhiteColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.03),
                              PrimaryButton(
                                  fontSize: 15,
                                  title: 'edit'.tr,
                                  onPressed: () async {
                                    if (_editformKey.currentState!.validate()) {
                                      ProfileController.i.updateval(false);
                                      setState(() {});
                                    }
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
                      child: GetBuilder<AddBankController>(
                        builder: (contr) => Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.02),
                          child: SingleChildScrollView(
                            child: Form(
                              key: _addformKey,
                              child: Column(
                                children: [
                                  EditProfileCustomTextField(
                                    onTap: () async {
                                      Degrees generic =
                                          await searchabledropdown(
                                              context, add.addbankList);
                                      add.addselectedbank = null;
                                      add.updateaddselectedbank(generic);

                                      if (generic.id != null) {
                                        add.addselectedbank = generic;
                                        add.addselectedbank =
                                            (generic.id == null)
                                                ? null
                                                : add.addselectedbank;
                                      }
                                    },
                                    validator: (p0) {
                                      if (add.addselectedbank?.name == null) {
                                        return 'SelectBank'.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                    readonly: true,
                                    hintText: add.addselectedbank?.name == ""
                                        ? 'bank'.tr
                                        : add.addselectedbank?.name ??
                                            "SelectBank".tr,
                                  ),
                                  EditProfileCustomTextField(
                                    validator: (p0) {
                                      if (p0!.isEmpty) {
                                        return 'EnterAccountTitle'.tr;
                                      }
                                      return null;
                                    },
                                    controller: add.accountTitle,
                                    hintText: 'AccountTitle'.tr,
                                  ),
                                  EditProfileCustomTextField(
                                    controller: add.accountNo,
                                    hintText: 'AccountNumber'.tr,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      add.picksingleBankfile();
                                    },
                                    child: Container(
                                      width: Get.width *
                                          1, // Adjust the width as needed
                                      height: Get.height * 0.065,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.7),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'UploadFile'.tr,
                                          style: GoogleFonts.poppins(
                                              color: ColorManager.kWhiteColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.03),
                                  PrimaryButton(
                                      fontSize: 15,
                                      title: 'add'.tr,
                                      onPressed: () async {
                                        if (_addformKey.currentState!
                                            .validate()) {
                                          ProfileController.i
                                              .updateaddval(false);
                                          setState(() {});
                                        }
                                      },
                                      color: Colors.white.withOpacity(0.7),
                                      textcolor: ColorManager.kWhiteColor),
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
                                        width: Get.width * 0.28,
                                        child: Text(
                                          'bank'.tr,
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
                            bankdetail.bankDetailList.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                                                  .bankDetailList[
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
        ),
      ),
    );
  }
}
