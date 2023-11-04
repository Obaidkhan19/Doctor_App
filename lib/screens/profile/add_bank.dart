import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/degree.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddBank extends StatefulWidget {
  const AddBank({super.key});

  @override
  State<AddBank> createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: ColorManager.kPrimaryColor,
          onPressed: () {
            Get.back(result: true);
          },
        ),
        title: Text(
          'Add Bank',
          style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: ColorManager.kPrimaryColor),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<EditProfileController>(
        builder: (contr) => Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                RegisterCustomTextField(
                  onTap: () async {
                    Degrees generic =
                        await searchabledropdown(context, edit.bankList ?? []);
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
                          edit.selectedbank =
                              (generic == '') ? null : edit.selectedbank;
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
                    title: 'Add'.tr,
                    onPressed: () async {},
                    color: ColorManager.kPrimaryColor,
                    textcolor: ColorManager.kWhiteColor),
                SizedBox(height: Get.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
