import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/lab_screens/lab_investigations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Services {
  String? title;
  String? imagePath;
  Color? color;
  Function()? onPressed;
  Services({this.title, this.imagePath, this.color, this.onPressed});
}

List<Services> services = [
  Services(
      title: 'Home Sample',
      imagePath: Images.bloodSample,
      color: ColorManager.kPrimaryColor,
      onPressed: () async {
        Get.to(() => const LabInvestigations(
              title: 'Home Sample',
              isHomeSamle: true,
            ));
      }),
  Services(
      title: 'Lab Investigation Booking',
      imagePath: Images.microscope,
      color: ColorManager.kyellowContainer,
      onPressed: () async {
        Get.to(() => const LabInvestigations(
              title: 'Lab Investigation Booking',
            ));
      }),
  // Services(
  //     title: 'Image Booking',
  //     imagePath: Images.imaging,
  //     color: ColorManager.kCyanBlue,
  //     onPressed: () async {
  //       Get.to(() => const NoDataFound());
  //     }),
  // Services(
  //     title: 'Doctor Consultant',
  //     imagePath: Images.doc1,
  //     color: ColorManager.kRedColor,
  //     onPressed: () async {
  //      Get.to(() => const NoDataFound());
  //     }),
];
