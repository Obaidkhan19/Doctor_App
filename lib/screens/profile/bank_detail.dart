import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/image_container.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/add_bank_controller.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/degree.dart';
import 'package:doctormobileapplication/models/doctor_details.dart';
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
    // token = await LocalDb().getToken() ?? "";
  }

  // String token = "";
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
    // print("aaaa print token $token");
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
                              InkWell(
                                onTap: () async {
                                  ProfileRepo pr = ProfileRepo();
                                  AuthRepo ar = AuthRepo();

                                  edit.updateisloading(true);
                                  if (_editformKey.currentState!.validate()) {
                                    // upload image

                                    if (edit.bankfile != null) {
                                      edit.editbankaccountfilepath =
                                          await ar.uploadFile(edit.bankfile!);
                                    }

                                    String res = await pr.editBankAccount(
                                        edit.editbankaccountid,
                                        edit.selectedbank?.id,
                                        edit.accountNo.text,
                                        edit.accountTitle.text,
                                        edit.editbankaccountfilepath);
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
                                  InkWell(
                                    onTap: () async {
                                      ProfileRepo pr = ProfileRepo();
                                      AuthRepo ar = AuthRepo();

                                      add.updateisloading(true);
                                      if (_addformKey.currentState!
                                          .validate()) {
                                        // upload image
                                        String path = "";
                                        if (add.bankfile != null) {
                                          path = await ar
                                              .uploadFile(add.bankfile!);
                                        }

                                        String res = await pr.addBankAccount(
                                            add.addselectedbank?.id,
                                            add.accountNo.text,
                                            add.accountTitle.text,
                                            path);
                                        if (res == "true") {
                                          _getDoctorBasicInfo();
                                          ProfileController.i
                                              .updateaddval(false);
                                          setState(() {});

                                          add.updateisloading(false);
                                        }
                                        add.updateisloading(false);
                                      }
                                      add.updateisloading(false);
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
                                                    // ImageContainerNew(
                                                    //   onpressed: () async {
                                                    //     String id =
                                                    //         ProfileController
                                                    //                 .i
                                                    //                 .bankDetailList[
                                                    //                     index]
                                                    //                 .id ??
                                                    //             "";
                                                    //     deleteBank(context, id);
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
                                                        BankAccounts ba =
                                                            BankAccounts();

                                                        ba = ProfileController.i
                                                                .bankDetailList[
                                                            index];
                                                        edit.updateeditSelectedBankAccount(
                                                            ba);
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
                                                    onTap: () async {
                                                      String id =
                                                          ProfileController
                                                              .i
                                                              .bankDetailList[
                                                                  index]
                                                              .id!;

                                                      if (ProfileController
                                                              .i
                                                              .bankDetailList[
                                                                  index]
                                                              .isDefault !=
                                                          true) {
                                                        ProfileRepo pr =
                                                            ProfileRepo();

                                                        String res = await pr
                                                            .setdefaultBank(id);

                                                        if (res == "true") {
                                                          _getDoctorBasicInfo();
                                                          setState(() {});
                                                        }
                                                      }
                                                    },
                                                    child: Text(
                                                      (ProfileController
                                                                  .i
                                                                  .bankDetailList[
                                                                      index]
                                                                  .isDefault ==
                                                              true
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

  deleteBank(
    BuildContext context,
    String bankid,
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

                      String res = await pr.deleteBank(bankid);

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
