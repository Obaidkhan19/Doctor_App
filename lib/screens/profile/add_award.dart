import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/degree.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../components/primary_button.dart';

class AddAward extends StatefulWidget {
  const AddAward({super.key});

  @override
  State<AddAward> createState() => _AddAwardState();
}

class _AddAwardState extends State<AddAward> {
  @override
  var edit = Get.put<EditProfileController>(EditProfileController());

  _getLocations() async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updateawardList(
      await pr.getLocations(),
    );
  }

  @override
  void initState() {
    super.initState();
    _getLocations();
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
          'Add Award',
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
                AuthTextField(
                  controller: edit.awardtitle,
                  hintText: 'Title',
                ),

                SizedBox(
                  height: Get.height * 0.02,
                ),
                AuthTextField(
                  controller: edit.awardcode,
                  hintText: 'Code',
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                // organization

                // location
                RegisterCustomTextField(
                  onTap: () async {
                    Degrees generic =
                        await searchabledropdown(context, edit.awardList ?? []);
                    edit.selectedawardlocation = null;
                    edit.updateselectedaward(generic);

                    if (generic != '') {
                      edit.selectedawardlocation = generic;
                      edit.selectedawardlocation =
                          (generic == '') ? null : edit.selectedawardlocation;
                    }
                  },
                  readonly: true,
                  suffixIcon: IconButton(
                      onPressed: () async {
                        Degrees generic = await searchabledropdown(
                            context, edit.awardList ?? []);
                        edit.selectedawardlocation = null;
                        edit.updateselectedaward(generic);

                        if (generic != '') {
                          edit.selectedawardlocation = generic;
                          edit.selectedawardlocation = (generic == '')
                              ? null
                              : edit.selectedawardlocation;
                        }
                      },
                      icon: Image.asset(Images.dropdown)),
                  hintText: edit.selectedawardlocation?.name == ""
                      ? 'Location'.tr
                      : edit.selectedawardlocation?.name ?? "Select Location",
                ),

                RegisterCustomTextField(
                  onTap: () async {
                    await edit.selectformattedawardedDateAndTime(
                        context,
                        EditProfileController.awardeddate,
                        edit.formateawardeddate);
                  },
                  readonly: true,
                  hintText: edit.formattedawardeddate
                              .toString()
                              .split("T")[0] ==
                          DateTime.now().toString().split(" ")[0]
                      ? "Select Awarded Date"
                      : DateFormat('MM-dd-y').format(DateTime.parse(
                          edit.formattedawardeddate.toString().split(" ")[0])),
                ),

                AuthTextField(
                  controller: edit.awarddescription,
                  hintText: 'Description',
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
