import 'package:doctormobileapplication/components/doted_line.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/family_screens/status_screen.dart';
import 'package:doctormobileapplication/screens/profile/edit_contact.dart';
import 'package:doctormobileapplication/screens/profile/personal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ContactDetail extends StatefulWidget {
  const ContactDetail({super.key});

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  var profile = Get.put<ProfileController>(ProfileController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (contr) => Container(
        padding: EdgeInsets.only(top: Get.height * 0.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  'Contact Information',
                  style: GoogleFonts.poppins(
                    textStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.kWhiteColor),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.02,
                  right: Get.width * 0.02,
                  top: Get.height * 0.01,
                  bottom: Get.height * 0.01,
                ),
                child: const MySeparator(
                  color: ColorManager.kWhiteColor,
                ),
              ),
              ProfileRecordWidget(
                title: "Country",
                name: profile.selectedbasicInfo?.countryName == ""
                    ? "-"
                    : profile.selectedbasicInfo?.countryName == null
                        ? "-"
                        : profile.selectedbasicInfo?.countryName ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "State",
                name: profile.selectedbasicInfo?.stateName == ""
                    ? "-"
                    : profile.selectedbasicInfo?.stateName == null
                        ? "-"
                        : profile.selectedbasicInfo?.stateName ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "City",
                name: profile.selectedbasicInfo?.cityName == ""
                    ? "-"
                    : profile.selectedbasicInfo?.cityName == null
                        ? "-"
                        : profile.selectedbasicInfo?.cityName ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "Address",
                name: profile.selectedbasicInfo?.address == ""
                    ? "-"
                    : profile.selectedbasicInfo?.address == null
                        ? "-"
                        : profile.selectedbasicInfo?.address ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "Mobile Number (Private)",
                name: profile.selectedbasicInfo?.cellNumber == ""
                    ? "-"
                    : profile.selectedbasicInfo?.cellNumber == null
                        ? "-"
                        : profile.selectedbasicInfo?.cellNumber ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "Mobile Number (Public)",
                name: profile.selectedbasicInfo?.contactPublic == ""
                    ? "-"
                    : profile.selectedbasicInfo?.contactPublic == null
                        ? "-"
                        : profile.selectedbasicInfo?.contactPublic ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "Telephone Number",
                name: profile.selectedbasicInfo?.telephoneNumber == ""
                    ? "-"
                    : profile.selectedbasicInfo?.telephoneNumber == null
                        ? "-"
                        : profile.selectedbasicInfo?.telephoneNumber ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "Email",
                name: profile.selectedbasicInfo?.email == ""
                    ? "-"
                    : profile.selectedbasicInfo?.email == null
                        ? "-"
                        : profile.selectedbasicInfo?.email ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Center(
                child: Text(
                  'Next of Kin',
                  style: GoogleFonts.poppins(
                    textStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.kWhiteColor),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Get.width * 0.02,
                  right: Get.width * 0.02,
                  top: Get.height * 0.01,
                  bottom: Get.height * 0.01,
                ),
                child: const MySeparator(
                  color: ColorManager.kWhiteColor,
                ),
              ),
              ProfileRecordWidget(
                title: "NOK Name",
                name: profile.selectedbasicInfo?.nOKFirstName == ""
                    ? "-"
                    : profile.selectedbasicInfo?.nOKFirstName == null
                        ? "-"
                        : profile.selectedbasicInfo?.nOKFirstName ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "NOK ID Number",
                name: profile.selectedbasicInfo?.nOKCNICNumber == ""
                    ? "-"
                    : profile.selectedbasicInfo?.nOKCNICNumber == null
                        ? "-"
                        : profile.selectedbasicInfo?.nOKCNICNumber ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "NOK Relation",
                name: profile.selectedbasicInfo?.nOKRelationName == ""
                    ? "-"
                    : profile.selectedbasicInfo?.nOKRelationName == null
                        ? "-"
                        : profile.selectedbasicInfo?.nOKRelationName ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "NOK Mobile Number",
                name: profile.selectedbasicInfo?.nOKCellNumber == ""
                    ? "-"
                    : profile.selectedbasicInfo?.nOKCellNumber == null
                        ? "-"
                        : profile.selectedbasicInfo?.nOKCellNumber ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              PrimaryButton(
                  width: Get.width * 0.6,
                  height: Get.height * 0.06,
                  fontSize: 15,
                  title: "Edit",
                  onPressed: () async {
                    var result = await Get.to(() => const EditContact());
                    if (result == true) {
                      _getDoctorBasicInfo();
                    }
                  },
                  color: ColorManager.kWhiteColor,
                  textcolor: ColorManager.kPrimaryColor),
              SizedBox(
                height: Get.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
