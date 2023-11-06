import 'package:doctormobileapplication/data/controller/profile_controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/profile/add_bank.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberShip extends StatefulWidget {
  const MemberShip({super.key});

  @override
  State<MemberShip> createState() => _MemberShipState();
}

class _MemberShipState extends State<MemberShip> {
  _getDoctorBasicInfo() async {
    ProfileRepo pr = ProfileRepo();
    await pr.getDoctorBasicInfo();
  }

  var membership = Get.put<ProfileController>(ProfileController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (contr) => Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            top: Get.height * 0.04,
          ),

          // membershiplist
          child: membership.membershipList.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: membership.membershipList.length,
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
            Get.to(() => const AddBank());
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
