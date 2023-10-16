import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/image_container.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/font_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/models/search_models.dart';
import 'package:doctormobileapplication/screens/family_screens/family_members.dart';
import 'package:doctormobileapplication/screens/specialists_screen/specialist_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../no_data_found/no_data_found.dart';

class Specialists extends StatelessWidget {
  final List<Search>? doctors;
  final String? title;
  const Specialists({super.key, this.doctors, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 0.08),
          child: CustomAppBar(
            title: '$title Specialists',
          )),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const ImageContainer(
                    color: ColorManager.kWhiteColor,
                    isSvg: false,
                    backgroundColor: ColorManager.kPrimaryColor,
                    imagePath: Images.heart,
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  const Expanded(
                    child: CustomTextField(
                      prefixIcon: Icon(
                        Icons.search,
                        color: ColorManager.kPrimaryColor,
                      ),
                      isSizedBoxAvailable: false,
                      hintText: 'Search Doctor',
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: doctors!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final doctor = doctors![index];
                    return specialistsContainer(context, doctor: doctor);
                  })
            ],
          ),
        ),
      ),
    );
  }

  specialistsContainer(BuildContext context, {Search? doctor, String? title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30).copyWith(top: 5),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
            onTap: () {
              Get.to(() => SpecialistDetails(
                    doctors: doctor,
                    title: title,
                  ));
            },
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFFDBEAF8)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 10),
                        child: Image.asset(Images.favoriteIcon),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.all(AppPadding.p8)
                              .copyWith(left: 20, right: 20),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              color: ColorManager.kyellowContainer),
                          child: Text(
                            'Monday - Saturday | 9:00 AM - 6:00 PM',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 12,
                                    color: ColorManager.kblackColor,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10)
                                .copyWith(left: 0),
                        leading: Container(
                          height: Get.height * 0.2,
                          width: Get.width * 0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    'http://192.168.88.254:324/File/Download${doctor?.picturePath}',
                                  ),
                                  fit: BoxFit.contain)),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: ColorManager.kyellowContainer,
                            ),
                            Text('4.5')
                          ],
                        ),
                        subtitle: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10)
                              .copyWith(
                            left: 0,
                          ),
                          padding: const EdgeInsets.all(AppPadding.p10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorManager.kPrimaryColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      '${doctor?.qualification}',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: ColorManager.kWhiteColor,
                                              fontSize: 14),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Experience',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: ColorManager.kWhiteColor,
                                            fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Text(
                                    ': ${doctor?.numberofExpereinceyear} Years',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color:
                                                ColorManager.kyellowContainer,
                                            fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              isOnlineOrOffline(doctor!.isOnline!)!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: doctor.isOnline == true
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeightManager.bold),
                            ),
                            Text(
                              '${doctor.name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: ColorManager.kblackColor),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                ],
              ),
            ),
          ),
          const PositionedButtonWidget(
            icon: Icons.video_call_outlined,
            offset: 10,
            alignment: Alignment.centerRight,
            iconColor: Color(0xFFF21F61),
            borderColor: Color(0xFFF21F61),
            buttonText: 'Get Appointment',
          ),
          const PositionedButtonWidget(
            isImage: true,
            imagePath: Images.clinic,
            offset: 10,
            alignment: Alignment.centerLeft,
            iconColor: Color(0xFF0B8AA0),
            borderColor: Color(0xFF0B8AA0),
            buttonText: 'Consult at Clinic',
          ),
        ],
      ),
    );
  }
}

class PositionedButtonWidget extends StatelessWidget {
  final double? bottom;
  final String? imagePath;
  final bool? isImage;
  final IconData? icon;
  final double? offset;
  final Alignment? alignment;
  final Color? iconColor;
  final Color? borderColor;
  final String? buttonText;

  const PositionedButtonWidget({
    Key? key,
    this.bottom,
    this.imagePath,
    this.isImage = false,
    this.icon,
    this.offset,
    this.alignment,
    this.iconColor,
    this.borderColor,
    this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom ?? -20,
      right: alignment == Alignment.centerRight ? offset : null,
      left: alignment == Alignment.centerLeft ? offset : null,
      child: InkWell(
        onTap: () {
          Get.to(() => NoDataFound());
        },
        child: Container(
          height: Get.height * 0.07,
          decoration: BoxDecoration(
            color: ColorManager.kPrimaryColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 5,
              color: Colors.white,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(AppPadding.p8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: ColorManager.kGreyColor,
                    blurRadius: 0.8,
                    spreadRadius: 1,
                    offset: Offset(-2, 2))
              ],
              border: Border.all(
                color: borderColor!,
              ),
              color: ColorManager.kWhiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isImage == true)
                  Image.asset(imagePath!)
                else
                  Icon(
                    icon,
                    color: borderColor,
                    size: 20,
                  ),
                SizedBox(width: Get.width * 0.005),
                Text(
                  '$buttonText',
                  style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                      color: borderColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? isOnlineOrOffline(bool value) {
  if (value == true) {
    return "Online";
  } else {
    return "Offline";
  }
}
