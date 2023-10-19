import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/screens/dashboard/menu_drawer.dart';

import 'primary_button.dart';

class AppointSuccessfulOrFailedWidget extends StatelessWidget {
  final bool? titleImage;
  final String? image;
  final String? successOrFailedHeader;
  final String? appoinmentFailedorSuccessSmalltext;
  final String? firstButtonText;
  final String? secondButtonText;

  const AppointSuccessfulOrFailedWidget({
    super.key,
    this.image,
    this.successOrFailedHeader,
    this.appoinmentFailedorSuccessSmalltext,
    this.firstButtonText,
    this.secondButtonText,
    this.titleImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p20),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 5,
              blurStyle: BlurStyle.inner,
              color: Colors.grey[300]!,
              blurRadius: 10,
              offset: const Offset(-2, 2), // Shadow position
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          color: ColorManager.kWhiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         titleImage == true ? Image.asset(
            Images.bike,
          ) : const SizedBox.shrink(),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Image.asset(image!),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Text(
            '$successOrFailedHeader',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 22,
                color: ColorManager.kblackColor,
                fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Text(
            '$appoinmentFailedorSuccessSmalltext',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 13, color: ColorManager.kblackColor),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          PrimaryButton(
              fontSize: 12,
              title: '$firstButtonText',
              onPressed: () {
                Get.to(()=> const DrawerScreen());
              },
              color: ColorManager.kPrimaryColor,
              textcolor: ColorManager.kWhiteColor),
          SizedBox(
            height: Get.height * 0.02,
          ),
          PrimaryButton(
              fontSize: 12,
              title: '$secondButtonText',
              onPressed: () {
                Get.back();
              },
              color: ColorManager.kPrimaryLightColor,
              textcolor: ColorManager.kPrimaryColor),
        ],
      ),
    );
  }
}
