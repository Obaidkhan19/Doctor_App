import 'package:doctormobileapplication/components/image_container.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/profile/add_worklocation.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkLocation extends StatefulWidget {
  const WorkLocation({super.key});

  @override
  State<WorkLocation> createState() => _WorkLocationState();
}

class _WorkLocationState extends State<WorkLocation> {
  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  var worklocation = Get.put<ProfileController>(ProfileController());
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
                          Get.to(() => const AddWorklocation());
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
                worklocation.appointmentConfigurationList.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Get.width * 0.6,
                            child: Row(
                              children: [
                                InkWell(
                                  child: SizedBox(
                                    height: Get.height * 0.04,
                                    width: Get.width * 0.19,
                                    child: Image.asset(
                                      Images.edit,
                                      color: ColorManager.kPrimaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Hospital/Clinic',
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
                              'Preference',
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
                worklocation.appointmentConfigurationList.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            worklocation.appointmentConfigurationList.length,
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
                                    width: Get.width * 0.6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ImageContainerNew(
                                          onpressed: () {},
                                          imagePath: AppImages.cross,
                                          //  imageheight: Get.height * 0.03,
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
                                          // imageheight: Get.height * 0.02,
                                          boxheight: Get.height * 0.03,
                                          boxwidth: Get.width * 0.06,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.002,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.4,
                                          child: Text(
                                            ProfileController
                                                    .i
                                                    .appointmentConfigurationList[
                                                        index]
                                                    .workLocation ??
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
                                    width: Get.width * 0.28,
                                    child: Text(
                                      ProfileController
                                              .i
                                              .appointmentConfigurationList[
                                                  index]
                                              .address ??
                                          "",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: ColorManager.kWhiteColor,
                                      ),
                                    ),
                                  ),
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
        // Container(
        //   padding: EdgeInsets.only(
        //     top: Get.height * 0.04,
        //   ),
        //   child: worklocation.appointmentConfigurationList.isNotEmpty
        //       ? ListView.builder(
        //           scrollDirection: Axis.vertical,
        //           itemCount: worklocation.appointmentConfigurationList.length,
        //           itemBuilder: (context, index) {
        //             return Card(
        //               elevation: 4,
        //               color: ColorManager.kPrimaryColor,
        //               child: Padding(
        //                 padding: EdgeInsets.symmetric(
        //                     horizontal: Get.width * 0.04,
        //                     vertical: Get.height * 0.02),
        //                 child: Column(
        //                   children: [
        //                     Row(
        //                       children: [
        //                         Text(
        //                           "Hospital/Clinic :",
        //                           style: GoogleFonts.poppins(
        //                             fontSize: 14,
        //                             color: ColorManager.kWhiteColor,
        //                             fontWeight: FontWeight.bold,
        //                           ),
        //                         ),
        //                         SizedBox(
        //                           width: Get.width * 0.04,
        //                         ),
        //                         SizedBox(
        //                           width: Get.width * 0.43,
        //                           child: Text(
        //                             ProfileController
        //                                     .i
        //                                     .appointmentConfigurationList[index]
        //                                     .workLocation ??
        //                                 "",
        //                             style: GoogleFonts.poppins(
        //                               fontSize: 12,
        //                               color: ColorManager.kWhiteColor,
        //                               fontWeight: FontWeight.w600,
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                     Row(
        //                       children: [
        //                         Text(
        //                           "Preference          :",
        //                           style: GoogleFonts.poppins(
        //                             fontSize: 14,
        //                             color: ColorManager.kWhiteColor,
        //                             fontWeight: FontWeight.bold,
        //                           ),
        //                         ),
        //                         SizedBox(
        //                           width: Get.width * 0.04,
        //                         ),
        //                         SizedBox(
        //                           width: Get.width * 0.43,
        //                           child: Text(
        //                             // ProfileController
        //                             //         .i.bankDetailList[index].bankName ??
        //                             //     "",
        //                             "Add preference value from DB",
        //                             style: GoogleFonts.poppins(
        //                               fontSize: 12,
        //                               color: ColorManager.kWhiteColor,
        //                               fontWeight: FontWeight.w600,
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             );
        //           },
        //         )
        //       : Center(
        //           child: Text(
        //             "No Record Found",
        //             style: GoogleFonts.poppins(
        //               fontSize: 12,
        //               color: Colors.black,
        //               fontWeight: FontWeight.w300,
        //             ),
        //           ),
        //         ),
        // ),
      ),
    );
  }
}
