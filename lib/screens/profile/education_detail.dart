import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/screens/profile/add_education.dart';
import 'package:flutter/material.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EducationDetail extends StatefulWidget {
  const EducationDetail({super.key});

  @override
  State<EducationDetail> createState() => _EducationDetailState();
}

class _EducationDetailState extends State<EducationDetail> {
  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  var education = Get.put<ProfileController>(ProfileController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (contr) => Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            top: Get.height * 0.04,
          ),
          child: education.educationList.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: education.educationList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      color: ColorManager.kPrimaryColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.04,
                            vertical: Get.height * 0.02),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Degree    :",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: ColorManager.kWhiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.04,
                                ),
                                SizedBox(
                                  width: Get.width * 0.56,
                                  child: Text(
                                    ProfileController.i.educationList[index]
                                            .degreeName ??
                                        "",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: ColorManager.kWhiteColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Country  :",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: ColorManager.kWhiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.04,
                                ),
                                SizedBox(
                                  width: Get.width * 0.56,
                                  child: Text(
                                    ProfileController.i.educationList[index]
                                            .countryName ??
                                        "",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: ColorManager.kWhiteColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "End Date :",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: ColorManager.kWhiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.04,
                                ),
                                SizedBox(
                                  width: Get.width * 0.56,
                                  child: Text(
                                    (ProfileController.i.educationList[index]
                                                .endDate !=
                                            null)
                                        ? DateFormat('MM-dd-y').format(
                                            DateTime.parse(ProfileController
                                                .i.educationList[index].endDate!
                                                .split("T")[0]))
                                        : "-",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: ColorManager.kWhiteColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    "No Record Found",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorManager.kPrimaryColor,
          onPressed: () {
            Get.to(() => const AddEducation());
          },
          child: const Icon(
            Icons.add,
            color: ColorManager.kWhiteColor,
          ),
        ),
      ),
    );
  }
}
