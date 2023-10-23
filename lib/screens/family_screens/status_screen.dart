// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/font_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/screens/family_screens/family_members.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/image_container.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CustomAppBar(),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppPadding.p20),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: ColorManager.kPrimaryColor),
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                  'Record Found',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorManager.kWhiteColor,
                      fontWeight: FontWeightManager.bold),
                )),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                const RecordWidget(title: 'Full Name', name: 'Daud Yousaf'),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                const RecordWidget(title: 'Fathers Name', name: 'M.Yousaf'),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                const RecordWidget(title: 'Date of birth', name: '04-02-2001'),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                const RecordWidget(title: 'Age', name: '24 years'),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                const RecordWidget(title: 'ID', name: '1234 5678 90'),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                CustomTextField(
                  hintText: 'Your Relation',
                  suffixIcon: IconButton(
                      onPressed: () {}, icon: Image.asset(Images.dropdown)),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        fillColor: ColorManager.kWhiteColor,
                        hintText: 'Documents proof',
                        readonly: true,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    const ImageContainer(
                      color: ColorManager.kWhiteColor,
                      isSvg: true,
                    )
                  ],
                )
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: PrimaryButton(
              title: 'Add Family Member',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Material(
                          type: MaterialType.transparency,
                          shape: const RoundedRectangleBorder(),
                          color: ColorManager.kWhiteColor,
                          child: AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Image.asset(Images.crossicon)),
                                SizedBox(
                                  height: Get.height * 0.04,
                                ),
                                Text(
                                  'Family Member Add Request',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: ColorManager.kPrimaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900),
                                ),
                                SizedBox(
                                  height: Get.height * 0.04,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: const CircleAvatar(
                                    radius: 35,
                                    backgroundImage: AssetImage(Images.profile),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Text(
                                  'Muhammad Yousaf',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: ColorManager.kPrimaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Text(
                                  'Mr. No 1234 567890',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: ColorManager.kPrimaryColor,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                Text(
                                  AppConstants.requestText,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: ColorManager.kblackColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  height: Get.height * 0.05,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: PrimaryButton(
                                            height: Get.height * 0.06,
                                            title: 'Accept',
                                            fontSize: 12,
                                            onPressed: () {},
                                            color: ColorManager.kPrimaryColor,
                                            textcolor:
                                                ColorManager.kWhiteColor)),
                                    SizedBox(
                                      width: Get.width * 0.05,
                                    ),
                                    Expanded(
                                        child: PrimaryButton(
                                            border: Border.all(
                                                color:
                                                    ColorManager.kPrimaryColor),
                                            height: Get.height * 0.06,
                                            title: 'Deny',
                                            fontSize: 12,
                                            onPressed: () {},
                                            color: ColorManager.kWhiteColor,
                                            textcolor:
                                                ColorManager.kPrimaryColor)),
                                  ],
                                )
                              ],
                            ),
                          ));
                    });
              },
              color: ColorManager.kPrimaryColor,
              textcolor: ColorManager.kWhiteColor,
              fontSize: 14,
              fontweight: FontWeight.w900,
            ),
          )
        ],
      ),
    );
  }
}

class RecordWidget extends StatelessWidget {
  final String? title;
  final String? name;

  const RecordWidget({Key? key, this.title, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                '$title',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
              ),
            ),
            Text(
              ':',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              width: Get.width * 0.07,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
