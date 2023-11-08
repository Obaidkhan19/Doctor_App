import 'package:doctormobileapplication/screens/profile/add_award.dart';
import 'package:flutter/material.dart';

import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/profile/add_bank.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AwardsDetail extends StatefulWidget {
  const AwardsDetail({super.key});

  @override
  State<AwardsDetail> createState() => _AwardsDetailState();
}

class _AwardsDetailState extends State<AwardsDetail> {
  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  var awards = Get.put<ProfileController>(ProfileController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (contr) => Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            top: Get.height * 0.04,
          ),
          child: awards.awardsList.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: awards.awardsList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      color: ColorManager.kPrimaryColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.04,
                            vertical: Get.height * 0.02),
                        child: const Column(
                          children: [],
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
            Get.to(() => const AddAward());
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
