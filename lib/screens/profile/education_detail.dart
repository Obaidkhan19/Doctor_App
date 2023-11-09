import 'package:doctormobileapplication/components/image_container.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/screens/profile/add_education.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
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
                          Get.to(() => const AddEducation());
                          // callback
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
                education.educationList.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      color: ColorManager.kPrimaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Degree',
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
                            width: Get.width * 0.2,
                            child: Text(
                              'Country',
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
                              'End Date',
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
                education.educationList.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: education.educationList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Get.width * 0.4,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ImageContainerNew(
                                          onpressed: () {},
                                          imagePath: AppImages.cross,
                                          isSvg: false,
                                          color: ColorManager.kRedColor,
                                          backgroundColor:
                                              ColorManager.kWhiteColor,
                                          boxheight: Get.height * 0.03,
                                          boxwidth: Get.width * 0.06,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.004,
                                        ),
                                        ImageContainerNew(
                                          onpressed: () {},
                                          imagePath: AppImages.editbig,
                                          isSvg: false,
                                          color: ColorManager.kPrimaryColor,
                                          backgroundColor:
                                              ColorManager.kWhiteColor,
                                          boxheight: Get.height * 0.03,
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
                                                    .educationList[index]
                                                    .degreeName ??
                                                "",
                                            style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              color: ColorManager.kWhiteColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.2,
                                    child: Text(
                                      ProfileController.i.educationList[index]
                                              .countryName ??
                                          "",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: ColorManager.kWhiteColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: Get.width * 0.2,
                                      child: Text(
                                        ProfileController.i.educationList[index]
                                                .endDate ??
                                            "",
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          color: ColorManager.kWhiteColor,
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
