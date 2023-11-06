import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/family_screens/status_screen.dart';
import 'package:doctormobileapplication/screens/profile/edit_personal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PersonalDetail extends StatefulWidget {
  const PersonalDetail({super.key});

  @override
  State<PersonalDetail> createState() => _PersonalDetailState();
}

class _PersonalDetailState extends State<PersonalDetail> {
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
              ProfileRecordWidget(
                title: "name".tr,
                name: profile.selectedbasicInfo?.fullName == ""
                    ? "-"
                    : profile.selectedbasicInfo?.fullName == null
                        ? "-"
                        : profile.selectedbasicInfo?.fullName ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "dateOfBirth".tr,
                name: (profile.selectedbasicInfo?.dateofBirth != null)
                    ? DateFormat('MM-dd-y').format(DateTime.parse(
                        profile.selectedbasicInfo?.dateofBirth!.split("T")[0]))
                    : "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "age".tr,
                name: profile.selectedbasicInfo?.age == ""
                    ? "-"
                    : profile.selectedbasicInfo?.age == null
                        ? "-"
                        : profile.selectedbasicInfo?.age ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "maritalStatus".tr,
                name: profile.selectedbasicInfo?.maritalStatusName == ""
                    ? "-"
                    : profile.selectedbasicInfo?.maritalStatusName == null
                        ? "-"
                        : profile.selectedbasicInfo?.maritalStatusName ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "gender".tr,
                name: profile.selectedbasicInfo?.genderName == ""
                    ? "-"
                    : profile.selectedbasicInfo?.genderName == null
                        ? "-"
                        : profile.selectedbasicInfo?.genderName ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "idnumber".tr,
                name: profile.selectedbasicInfo?.cNICNumber == ""
                    ? "-"
                    : profile.selectedbasicInfo?.cNICNumber == null
                        ? "-"
                        : profile.selectedbasicInfo?.cNICNumber ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "passportNumber".tr,
                name: profile.selectedbasicInfo?.passportNumber == ""
                    ? "-"
                    : profile.selectedbasicInfo?.passportNumber == null
                        ? "-"
                        : profile.selectedbasicInfo?.passportNumber ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "DHANO".tr,
                name: profile.selectedbasicInfo?.pMDCNumber == ""
                    ? "-"
                    : profile.selectedbasicInfo?.pMDCNumber == null
                        ? "-"
                        : profile.selectedbasicInfo?.pMDCNumber ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "NTNNumber".tr,
                name: profile.selectedbasicInfo?.nTNNo == ""
                    ? "-"
                    : profile.selectedbasicInfo?.nTNNo == null
                        ? "-"
                        : profile.selectedbasicInfo?.nTNNo ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "bloodGroup".tr,
                name: profile.selectedbasicInfo?.bloodGroupName == ""
                    ? "-"
                    : profile.selectedbasicInfo?.bloodGroupName == null
                        ? "-"
                        : profile.selectedbasicInfo?.bloodGroupName ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "religion".tr,
                name: profile.selectedbasicInfo?.religionName == ""
                    ? "-"
                    : profile.selectedbasicInfo?.religionName == null
                        ? "-"
                        : profile.selectedbasicInfo?.religionName ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "consultancyFee".tr,
                name:
                    profile.selectedbasicInfo?.consultationFee.toString() == ""
                        ? "-"
                        : profile.selectedbasicInfo?.consultationFee.toString(),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "followupfee".tr,
                name: profile.selectedbasicInfo?.followUpFee.toString() == ""
                    ? "-"
                    : profile.selectedbasicInfo?.followUpFee.toString(),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              ProfileRecordWidget(
                title: "designation(s)".tr,
                name: profile.selectedbasicInfo?.designation == ""
                    ? "-"
                    : profile.selectedbasicInfo?.designation == null
                        ? "-"
                        : profile.selectedbasicInfo?.designation ?? "-",
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              PrimaryButton(
                  width: Get.width * 0.6,
                  height: Get.height * 0.06,
                  fontSize: 15,
                  title: "edit".tr,
                  onPressed: () async {
                    var result = await Get.to(() => const EditPersonal());
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

class ProfileRecordWidget extends StatelessWidget {
  final String? title;
  final String? name;

  const ProfileRecordWidget({Key? key, this.title, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                '$title',
                // style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                //       color: Colors.black,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 12,
                //     ),
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              ':',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              width: Get.width * 0.03,
            ),
            Expanded(
              child: Text(
                '$name',
                // style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                //       color: Colors.black,
                //       fontWeight: FontWeight.w300,
                //       fontSize: 12,
                //     ),
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
