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

class AddMembership extends StatefulWidget {
  const AddMembership({super.key});

  @override
  State<AddMembership> createState() => _AddMembershipState();
}

class _AddMembershipState extends State<AddMembership> {
  var edit = Get.put<EditProfileController>(EditProfileController());

  _getLocations() async {
    ProfileRepo pr = ProfileRepo();
    EditProfileController.i.updatemembershiplocationList(
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
          'Add Membership',
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
                  controller: edit.membershiptitle,
                  hintText: 'Title',
                ),

                SizedBox(
                  height: Get.height * 0.02,
                ),
                AuthTextField(
                  controller: edit.membershipcode,
                  hintText: 'Code',
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                // organization

                // location
                RegisterCustomTextField(
                  onTap: () async {
                    Degrees generic = await searchabledropdown(
                        context, edit.membershiplocationList ?? []);
                    edit.selectedmembershiplocation = null;
                    edit.updateselectedlocation(generic);

                    if (generic != '') {
                      edit.selectedmembershiplocation = generic;
                      edit.selectedmembershiplocation = (generic == '')
                          ? null
                          : edit.selectedmembershiplocation;
                    }
                  },
                  readonly: true,
                  suffixIcon: IconButton(
                      onPressed: () async {
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
                      icon: Image.asset(Images.dropdown)),
                  hintText: edit.selectedmembershiplocation?.name == ""
                      ? 'Location'.tr
                      : edit.selectedmembershiplocation?.name ??
                          "Select Location",
                ),

                RegisterCustomTextField(
                  onTap: () async {
                    await edit.selectmembershipfromDateAndTime(
                        context,
                        EditProfileController.membershipfrom,
                        edit.formatemembershipfrom);
                  },
                  readonly: true,
                  hintText:
                      edit.formattedmembershipfrom.toString().split("T")[0] ==
                              DateTime.now().toString().split(" ")[0]
                          ? "Select From Date"
                          : DateFormat('MM-dd-y').format(DateTime.parse(edit
                              .formattedmembershipfrom
                              .toString()
                              .split(" ")[0])),
                ),

                RegisterCustomTextField(
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
                      : DateFormat('MM-dd-y').format(DateTime.parse(
                          edit.formattedmembershipto.toString().split(" ")[0])),
                ),

                AuthTextField(
                  controller: edit.membershipdescription,
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
