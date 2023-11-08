import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/profile/add_experience.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ExperienceDetail extends StatefulWidget {
  const ExperienceDetail({super.key});

  @override
  State<ExperienceDetail> createState() => _ExperienceDetailState();
}

class _ExperienceDetailState extends State<ExperienceDetail> {
  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  var experience = Get.put<ProfileController>(ProfileController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (contr) => Scaffold(
        body: Container(
          color: ColorManager.kWhiteColor,
          padding: EdgeInsets.only(
            top: Get.height * 0.04,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Text('Degree',
                          style: GoogleFonts.poppins(
                            color: ColorManager.kWhiteColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          )),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      const Row(
                        children: [],
                      )
                    ],
                  ),
                  const Column(
                    children: [],
                  ),
                  const Column(
                    children: [],
                  ),
                ],
              )
            ],
          ),
        ),
        //   child:
        //   experience.experienceList.isNotEmpty
        //       ? ListView.builder(
        //           scrollDirection: Axis.vertical,
        //           itemCount: experience.experienceList.length,
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
        //                           "Title                     :",
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
        //                           width: Get.width * 0.45,
        //                           child: Text(
        //                             ProfileController
        //                                     .i.experienceList[index].title ??
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
        //                           "Organization :",
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
        //                           width: Get.width * 0.45,
        //                           child: Text(
        //                             ProfileController.i.experienceList[index]
        //                                     .organizationName ??
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
        //                           "Date                     :",
        //                           style: GoogleFonts.poppins(
        //                             fontSize: 14,
        //                             color: ColorManager.kWhiteColor,
        //                             fontWeight: FontWeight.bold,
        //                           ),
        //                         ),
        //                         SizedBox(
        //                           width: Get.width * 0.04,
        //                         ),
        //                         Text(
        //                           (ProfileController.i.experienceList[index]
        //                                       .fromDate !=
        //                                   null)
        //                               ? DateFormat('MM-dd-y').format(
        //                                   DateTime.parse(ProfileController
        //                                       .i.experienceList[index].fromDate!
        //                                       .split("T")[0]))
        //                               : "-",
        //                           style: GoogleFonts.poppins(
        //                             fontSize: 12,
        //                             color: ColorManager.kWhiteColor,
        //                             fontWeight: FontWeight.w600,
        //                           ),
        //                         ),
        //                         Text(
        //                           " To ",
        //                           style: GoogleFonts.poppins(
        //                             fontSize: 12,
        //                             color: ColorManager.kWhiteColor,
        //                             fontWeight: FontWeight.w600,
        //                           ),
        //                         ),
        //                         Text(
        //                           (ProfileController
        //                                       .i.experienceList[index].toDate !=
        //                                   null)
        //                               ? DateFormat('MM-dd-y').format(
        //                                   DateTime.parse(ProfileController
        //                                       .i.experienceList[index].toDate!
        //                                       .split("T")[0]))
        //                               : "-",
        //                           style: GoogleFonts.poppins(
        //                             fontSize: 12,
        //                             color: ColorManager.kWhiteColor,
        //                             fontWeight: FontWeight.w600,
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

        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorManager.kPrimaryColor,
          onPressed: () {
            Get.to(() => const AddExperience());
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
