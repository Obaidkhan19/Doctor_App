import 'dart:math';
import 'dart:ui';

import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/allergies.dart';
import 'package:doctormobileapplication/screens/family_screens/family_members.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// snwwe.com   cc
class UserHealthSummary extends StatefulWidget {
  const UserHealthSummary({super.key});

  @override
  State<UserHealthSummary> createState() => _UserHealthSummaryState();
}

class _UserHealthSummaryState extends State<UserHealthSummary> {
  List<Allergies> allergiesList = [];

  addinlist() {
    allergiesList.add(Allergies(
        id: "1",
        name: "Peanut Allergy",
        code: "PA",
        comments: "No peanuts allowed"));
    allergiesList.add(Allergies(
        id: "2",
        name: "Lactose Intolerance",
        code: "LI",
        comments: "Avoid dairy products"));

    allergiesList.add(Allergies(
        id: "3",
        name: "Intolerance",
        code: "LI",
        comments: "Avoid dairy products"));

    allergiesList.add(Allergies(
        id: "4",
        name: "Lactose",
        code: "LI",
        comments: "Avoid dairy products"));

    allergiesList.add(Allergies(
        id: "5",
        name: "Intolerance",
        code: "LI",
        comments: "Avoid dairy products"));

    allergiesList.add(Allergies(
        id: "6",
        name: "Intolerance",
        code: "LI",
        comments: "Avoid dairy products"));

    allergiesList.add(Allergies(
        id: "7",
        name: "Intolerance",
        code: "LI",
        comments: "Avoid dairy products"));

    allergiesList.add(Allergies(
        id: "8",
        name: "Intolerance",
        code: "LI",
        comments: "Avoid dairy products"));
  }

  @override
  void initState() {
    super.initState();
    addinlist();
  }

  @override
  void dispose() {
    super.dispose();
    allergiesList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          title: 'Mr. Shaikh Zahid',
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.04, right: Get.width * 0.03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.02),
              // 1 ROW
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'glucose'.tr,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: ColorManager.kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorManager.kLightBlue,
                          ),
                          width: Get.width * 0.3,
                          height: Get.height * 0.12,
                          child: Column(
                            children: [
                              SizedBox(height: Get.height * 0.02),
                              Text(
                                '19-07-2023',
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  color: ColorManager.kPrimaryColor,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.02,
                                    right: Get.width * 0.02),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorManager.kWhiteColor,
                                  ),
                                  height: Get.height * 0.035,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'random'.tr,
                                            style: GoogleFonts.poppins(
                                              fontSize: 8,
                                              color: ColorManager.kblackColor,
                                            ),
                                          ),
                                          Text(
                                            'fasting'.tr,
                                            style: GoogleFonts.poppins(
                                              fontSize: 8,
                                              color: ColorManager.kblackColor,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            '132',
                                            style: GoogleFonts.poppins(
                                              fontSize: 8,
                                              color: ColorManager.kRedColor,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            '106',
                                            style: GoogleFonts.poppins(
                                              fontSize: 8,
                                              color: ColorManager.KgreenColor,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Text(
                                'mg/dl',
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  color: ColorManager.kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  // 2  column

                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'bloodpressure'.tr,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: ColorManager.kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorManager.kLightBlue,
                          ),
                          width: Get.width * 0.3,
                          height: Get.height * 0.12,
                          child: Column(
                            children: [
                              SizedBox(height: Get.height * 0.02),
                              Text(
                                '19-07-2023',
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  color: ColorManager.kPrimaryColor,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.02,
                                    right: Get.width * 0.02),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorManager.kWhiteColor,
                                  ),
                                  height: Get.height * 0.035,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '120 / ',
                                        style: GoogleFonts.poppins(
                                          fontSize: 8,
                                          color: ColorManager.KgreenColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '100',
                                        style: GoogleFonts.poppins(
                                          fontSize: 8,
                                          color: ColorManager.kRedColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Text(
                                'mmHg',
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  color: ColorManager.kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  // 3  column

                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'measurements'.tr,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: ColorManager.kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorManager.kLightBlue,
                          ),
                          width: Get.width * 0.3,
                          height: Get.height * 0.12,
                          child: Column(
                            children: [
                              SizedBox(height: Get.height * 0.02),
                              Text(
                                '19-07-2023',
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  color: ColorManager.kPrimaryColor,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.02,
                                    right: Get.width * 0.02),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorManager.kWhiteColor,
                                  ),
                                  height: Get.height * 0.035,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            'height'.tr,
                                            style: GoogleFonts.poppins(
                                              fontSize: 8,
                                              color: ColorManager.kblackColor,
                                            ),
                                          ),
                                          Text(
                                            'weight'.tr,
                                            style: GoogleFonts.poppins(
                                              fontSize: 8,
                                              color: ColorManager.kblackColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            '196',
                                            style: GoogleFonts.poppins(
                                              fontSize: 8,
                                              color: ColorManager.KgreenColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '75',
                                            style: GoogleFonts.poppins(
                                              fontSize: 8,
                                              color: ColorManager.kOrangeColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Text(
                                'cm/kg',
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  color: ColorManager.kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

              // 2 ROW
              SizedBox(
                height: Get.height * 0.03,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Sp02%',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: ColorManager.kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorManager.kLightBlue,
                          ),
                          width: Get.width * 0.3,
                          height: Get.height * 0.12,
                          child: Column(
                            children: [
                              SizedBox(height: Get.height * 0.02),
                              Text(
                                '19-07-2023',
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  color: ColorManager.kPrimaryColor,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.02,
                                    right: Get.width * 0.02),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorManager.kWhiteColor,
                                  ),
                                  height: Get.height * 0.035,
                                  width: Get.width * 0.5,
                                  child: Center(
                                    child: Text(
                                      '96',
                                      style: GoogleFonts.poppins(
                                          fontSize: 8,
                                          color: ColorManager.kRedColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  // 2  column

                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'pulse'.tr,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: ColorManager.kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorManager.kLightBlue,
                          ),
                          width: Get.width * 0.3,
                          height: Get.height * 0.12,
                          child: Column(
                            children: [
                              SizedBox(height: Get.height * 0.02),
                              Text(
                                '19-07-2023',
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  color: ColorManager.kPrimaryColor,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.02,
                                    right: Get.width * 0.02),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorManager.kWhiteColor,
                                  ),
                                  height: Get.height * 0.035,
                                  width: Get.width * 0.5,
                                  child: Center(
                                    child: Text(
                                      '86',
                                      style: GoogleFonts.poppins(
                                          fontSize: 8,
                                          color: ColorManager.kYellowColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Text(
                                'BPM',
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  color: ColorManager.kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  // 3  column

                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'temperature'.tr,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: ColorManager.kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorManager.kLightBlue,
                          ),
                          width: Get.width * 0.3,
                          height: Get.height * 0.12,
                          child: Column(
                            children: [
                              SizedBox(height: Get.height * 0.02),
                              Text(
                                '19-07-2023',
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  color: ColorManager.kPrimaryColor,
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.02,
                                    right: Get.width * 0.02),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorManager.kWhiteColor,
                                  ),
                                  height: Get.height * 0.035,
                                  width: Get.width * 0.5,
                                  child: Center(
                                    child: Text(
                                      '96',
                                      style: GoogleFonts.poppins(
                                          fontSize: 8,
                                          color: ColorManager.kYellowColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: Get.height * 0.01),
                              Image.asset(AppImages.foreignheight),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              // ECG

              SizedBox(height: Get.height * 0.03),
              Center(
                child: Text(
                  'ecg'.tr,
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: ColorManager.kPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.kLightBlue,
                ),
                width: Get.width * 1,
                height: Get.height * 0.28,
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.01),
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width * 0.41,
                        ),
                        Text(
                          '19-07-2023',
                          style: GoogleFonts.poppins(
                            fontSize: 8,
                            color: ColorManager.kPrimaryColor,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.3,
                        ),
                        Text(
                          '86',
                          style: GoogleFonts.poppins(
                            fontSize: 8,
                            color: ColorManager.KgreenColor,
                          ),
                        ),
                      ],
                    ),
                    CustomPaint(
                      size: const Size(330, 180), // Adjust the size as needed
                      painter: EcgPainter(),
                    ),
                  ],
                ),
              ),

              // ALLERGIES

              SizedBox(height: Get.height * 0.02),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.kLightBlue,
                ),
                width: Get.width * 1,
                //  height: Get.height * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.02),
                    Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.03),
                      child: Text(
                        'allergies'.tr,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: ColorManager.kPrimaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Wrap(
                          children: <Widget>[
                            for (int index = 0;
                                index < allergiesList.length;
                                index++)
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  height: Get.height * 0.05,
                                  margin: const EdgeInsets.all(8.0),
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: ColorManager.kPrimaryColor,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        allergiesList[index].name.toString(),
                                        style: const TextStyle(
                                          fontSize: 9,
                                          color: ColorManager.kWhiteColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.03,
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: SizedBox(
                                          height: Get.height * 0.04,
                                          width: Get.width * 0.04,
                                          child:
                                              Image.asset(AppImages.whitecross),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                  ],
                ),
              ),

              SizedBox(height: Get.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}

class EcgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = ColorManager.kRedColor
      ..strokeWidth = 2;

    final double centerY = size.height / 2;
    final double amplitude = size.height / 3;
    final double period = size.width / 17;
    double? previousX, previousY;

    for (double x = 0; x < size.width; x += 1.0) {
      final double y = centerY + amplitude * sin((x / period) * (2 * pi));
      if (previousX != null && previousY != null) {
        canvas.drawLine(Offset(previousX, previousY), Offset(x, y), paint);
      }
      previousX = x;
      previousY = y;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
