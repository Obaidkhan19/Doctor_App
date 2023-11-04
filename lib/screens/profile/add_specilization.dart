import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/searchable_dropdown.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/speciality.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddSpecilization extends StatefulWidget {
  const AddSpecilization({super.key});

  @override
  State<AddSpecilization> createState() => _AddSpecilizationState();
}

class _AddSpecilizationState extends State<AddSpecilization> {
  var edit = Get.put<EditProfileController>(EditProfileController());
  _getSpeciality() async {
    AuthRepo ar = AuthRepo();
    EditProfileController.i.updatespecialitiesList(
      await ar.getSpecialities(),
    );
  }

  _getSubSpeciality(id) async {
    AuthRepo ar = AuthRepo();
    EditProfileController.i.updatesubspecialitiesList(
      await ar.getSubSpecialities(id),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _getSpeciality();
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
          'Add Specilization',
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
                    edit.selectedspecialities = null;
                    Specialities1 generic = await searchabledropdown(
                        context, edit.specialitiesList ?? []);
                    edit.selectedspecialities = null;
                    edit.updateselectedspeciality(generic);

                    if (generic != '') {
                      edit.selectedspecialities = generic;
                      edit.selectedspecialities =
                          (generic == '') ? null : edit.selectedspecialities;
                    }

                    setState(() {
                      _getSubSpeciality(generic.id);
                    });
                  },
                  readonly: true,
                  suffixIcon: IconButton(
                      onPressed: () async {
                        edit.selectedspecialities = null;
                        Specialities1 generic = await searchabledropdown(
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
                      icon: Image.asset(Images.dropdown)),
                  hintText: edit.selectedspecialities == null
                      ? 'speciality'.tr
                      : edit.selectedspecialities!.name.toString(),
                ),
                // SizedBox(
                //   height: Get.height * 0.02,
                // ),

                // SUB
                RegisterCustomTextField(
                  onTap: () async {
                    edit.selectedsubspecialities = null;
                    Specialities1 generic = await searchabledropdown(
                        context, edit.subspecialitiesList ?? []);
                    edit.selectedsubspecialities = null;
                    edit.updateselectedspeciality(generic);

                    if (generic != '') {
                      edit.selectedsubspecialities = generic;
                      edit.selectedsubspecialities =
                          (generic == '') ? null : edit.selectedsubspecialities;
                    }
                  },
                  readonly: true,
                  suffixIcon: IconButton(
                      onPressed: () async {
                        edit.selectedsubspecialities = null;
                        Specialities1 generic = await searchabledropdown(
                            context, edit.subspecialitiesList ?? []);
                        edit.selectedsubspecialities = null;
                        edit.updateselectedspeciality(generic);

                        if (generic != '') {
                          edit.selectedsubspecialities = generic;
                          edit.selectedsubspecialities = (generic == '')
                              ? null
                              : edit.selectedsubspecialities;
                        }
                      },
                      icon: Image.asset(Images.dropdown)),
                  hintText: edit.selectedsubspecialities == null
                      ? 'subspeciality'.tr
                      : edit.selectedsubspecialities!.name.toString(),
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
