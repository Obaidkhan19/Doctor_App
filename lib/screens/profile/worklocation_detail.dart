import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/profile/add_worklocation.dart';
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

  var bankdetail = Get.put<ProfileController>(ProfileController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (contr) => Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            top: Get.height * 0.04,
          ),
          child: bankdetail.bankDetailList.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: bankdetail.bankDetailList.length,
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
                                  "Hospital/Clinic :",
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
                                  width: Get.width * 0.43,
                                  child: Text(
                                    ProfileController
                                            .i
                                            .appointmentConfigurationList[index]
                                            .workLocation ??
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
                                  "Preference          :",
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
                                  width: Get.width * 0.43,
                                  child: Text(
                                    // ProfileController
                                    //         .i.bankDetailList[index].bankName ??
                                    //     "",
                                    "Add preference value",
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
            Get.to(() => const AddWorklocation());
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
