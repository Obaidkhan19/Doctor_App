// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctormobileapplication/components/dots_indicator.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/data/controller/specialities_controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/font_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/models/services_model.dart';
import 'package:doctormobileapplication/screens/book_your_appointment/book_your_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  int pageIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(AppPadding.p24).copyWith(top: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.03,
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        if (ZoomDrawer.of(context)!.isOpen()) {
                          ZoomDrawer.of(context)!.close();
                        } else {
                          ZoomDrawer.of(context)!.open();
                        }
                      },
                      child: Image.asset(Images.menuIcon)),
                  SizedBox(
                    width: Get.width * 0.04,
                  ),
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFFEF4F7),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(Images.docImagesmaleFemale),
                      radius: 25,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Abu Yousaf!',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      Text(
                        'Good Morning',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: ColorManager.kGreyColor),
                      ),
                    ],
                  ),
                  // const Spacer(),
                  // InkWell(
                  //     onTap: () {
                  //       Get.to(() => NoDataFound());
                  //     },
                  //     child: Image.asset(Images.notification)),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  // InkWell(
                  //     onTap: () {
                  //       Get.to(() => NoDataFound());
                  //     },
                  //     child: Image.asset(Images.favoriteIcon))
                ],
              ),
              SizedBox(
                height: Get.height * 0.1,
              ),
              bookAppointmentContainer(context),
              SizedBox(
                height: Get.height * 0.08,
              ),
              Text(
                'Services',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: ColorManager.kPrimaryColor, fontSize: 14),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              CarouselSlider.builder(
                  carouselController: CarouselController(),
                  itemCount: services.length,
                  itemBuilder: (context, index, realIndex) {
                    final service = services[index];
                    return InkWell(
                      onTap: service.onPressed,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: service.color,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(service.imagePath!),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                Flexible(
                                  child: Text(service.title!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: ColorManager.kWhiteColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    initialPage: 2,
                    aspectRatio: 16 / 9,
                    enableInfiniteScroll: false,
                    height: Get.height * 0.18,
                    viewportFraction: 0.37,
                    onPageChanged: (index, reason) {
                      setState(() {
                        pageIndex = index;
                      });
                    },
                  )),
              SizedBox(
                height: Get.height * 0.02,
              ),
              DotsIndicatorRow(
                pageIndex: pageIndex,
                activeColor: ColorManager.kPrimaryColor,
                inactiveColor: const Color(0xFFDBEAF8),
              ),
              SizedBox(
                height: Get.height * 0.015,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Expanded(
              //       child: PrimaryButton(
              //         height: Get.height * 0.09,
              //         icon: Image.asset(Images.reports),
              //         title: 'Reports',
              //         fontSize: 12,
              //         onPressed: () {
              //           Get.to(() => NoDataFound());
              //         },
              //         color: ColorManager.kPrimaryColor,
              //         textcolor: ColorManager.kWhiteColor,
              //         primaryIcon: true,
              //       ),
              //     ),
              //     SizedBox(
              //       width: Get.width * 0.02,
              //     ),
              //     Expanded(
              //       child: PrimaryButton(
              //         height: Get.height * 0.09,
              //         icon: Image.asset(Images.docs),
              //         title: 'Packages',
              //         fontSize: 12,
              //         onPressed: () {
              //           Get.to(() => NoDataFound());
              //         },
              //         color: ColorManager.kyellowContainer,
              //         textcolor: ColorManager.kblackColor,
              //         primaryIcon: true,
              //       ),
              //     )
              //   ],
              // ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              availableDoctor(context),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  availableDoctor(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: Get.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFFDBEAF8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(Images.profile)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              color: ColorManager.kPrimaryColor),
                          child: Text(
                            'Today Available | 09:00 - 13:00',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 12,
                                    color: ColorManager.kWhiteColor),
                          ),
                        ),
                      ),
                      Text(
                        'Dr. Sheikh Hamid',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 16),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Get.width * 0.3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: ColorManager.kPrimaryColor),
                            child: Padding(
                              padding: const EdgeInsets.all(AppPadding.p4)
                                  .copyWith(left: AppPadding.p8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'General Consultation',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: ColorManager.kWhiteColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Text(
                                    '10:00 AM',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: ColorManager.kWhiteColor,
                                            fontSize: 10,
                                            fontFamily:
                                                GoogleFonts.mitr().fontFamily),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.05,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                color: ColorManager.kyellowContainer),
                            padding: const EdgeInsets.all(AppPadding.p8),
                            child: FittedBox(
                                child: Text(
                              'Token \n N/A',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontWeight: FontWeightManager.bold),
                            )),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                children: [
                  Container(
                    width: Get.width * 0.2,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(AppPadding.p4),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(5)),
                        color: ColorManager.kyellowContainer),
                    child: const Text('AED: 100'),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  Text(
                    'Online',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: ColorManager.kDarkBlue),
                  )
                ],
              )
            ],
          ),
        ),
        // Positioned(
        //     bottom: -20,
        //     right: 10,
        //     child: Container(
        //       height: Get.height * 0.08,
        //       decoration: BoxDecoration(
        //           color: ColorManager.kPrimaryColor,
        //           borderRadius: BorderRadius.circular(15),
        //           border: Border.all(
        //             width: 5,
        //             color: Colors.white,
        //           )),
        //       child: ElevatedButton(
        //           style: ElevatedButton.styleFrom(
        //               elevation: 10,
        //               side: BorderSide(
        //                   width: 1, color: ColorManager.kPrimaryColor),
        //               backgroundColor: ColorManager.kWhiteColor),
        //           onPressed: () {
        //             Get.to(() => NoDataFound());
        //           },
        //           child: Text(
        //             'Get Appointment',
        //             style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        //                 color: ColorManager.kPrimaryColor,
        //                 fontWeight: FontWeight.bold),
        //           )),
        //     ))
      ],
    );
  }

  bookAppointmentContainer(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          Images.container,
          width: Get.width,
          fit: BoxFit.cover,
          height: Get.height * 0.2,
        ),
        Positioned(
            bottom: 0,
            child: Image.asset(
              Images.docImage,
              fit: BoxFit.contain,
              height: Get.height * 0.4,
              width: Get.width * 0.4,
              alignment: Alignment.bottomCenter,
            )),
        Positioned(
            top: 0,
            right: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: Get.width * 0.2,
                    child: Text(
                      'Online & Offline',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorManager.kWhiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    )),
                Text(
                  'Consulation',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorManager.kyellowContainer,
                      fontWeight: FontWeight.w900,
                      fontSize: 12),
                )
              ],
            )),
        Positioned(
          bottom: -15,
          right: 20,
          child: InkWell(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: ColorManager.kWhiteColor, width: 7),
                  color: ColorManager.kWhiteColor,
                  borderRadius: BorderRadius.circular(10)),
              child: PrimaryButton(
                height: Get.height * 0.06,
                title: 'Book Now',
                onPressed: () async {
                  await SpecialitiesController.i.getSpecialities();
                  Get.to(() => BookyourAppointment());
                },
                color: ColorManager.kPrimaryColor,
                textcolor: ColorManager.kWhiteColor,
                fontSize: 12,
                width: Get.width * 0.3,
              ),
            ),
          ),
        )
      ],
    );
  }
}
