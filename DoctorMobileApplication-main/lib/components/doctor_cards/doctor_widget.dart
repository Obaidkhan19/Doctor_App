import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/text_container.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/font_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';

class DoctorsAppointmentCard extends StatelessWidget {
  final String statusText;
  final Color statusColor;
  final String name;
  final String date;
  final String time;
  final String type;
  final String rating;
  final bool showButtons;

  final void Function() onBookAgainPressed;
  final void Function() onLeaveReviewPressed;

  const DoctorsAppointmentCard({
    Key? key,
    required this.statusText,
    required this.statusColor,
    required this.name,
    required this.date,
    required this.time,
    required this.type,
    required this.rating,
    required this.showButtons,
    required this.onBookAgainPressed,
    required this.onLeaveReviewPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppPadding.p4),
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorManager.kPrimaryLightColor),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                      height: Get.height * 0.15,
                      width: Get.width * 0.6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage(
                              Images.profile,
                            ),
                          )))),
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextContainer(color: statusColor, text: statusText),
                                Text(
                                  name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: ColorManager.kblackColor,
                                          fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        const Divider(
                          height: 2,
                          thickness: 2,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Text(
                          type,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: ColorManager.kblackColor,
                                  fontWeight: FontWeightManager.bold,
                                  fontSize: 12),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$date | $time',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: ColorManager.kblackColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: ColorManager.kPrimaryColor,
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: ColorManager.kyellowContainer,
                                    ),
                                    Text(
                                      rating,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager.kblackColor,
                                          ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
          if (showButtons)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: Get.width * 0.02,
                ),
                Flexible(
                  child: PrimaryButton(
                      fontweight: FontWeight.bold,
                      radius: 5,
                      fontSize: 12,
                      height: Get.height * 0.05,
                      border: Border.all(color: ColorManager.kPrimaryColor),
                      title: 'Book Again',
                      onPressed: onBookAgainPressed,
                      color: ColorManager.kPrimaryLightColor,
                      textcolor: ColorManager.kPrimaryColor),
                ),
                SizedBox(
                  width: Get.width * 0.08,
                ),
                Flexible(
                  child: PrimaryButton(
                      radius: 5,
                      fontSize: 12,
                      height: Get.height * 0.05,
                      border: Border.all(color: ColorManager.kPrimaryColor),
                      title: 'Leave a Review',
                      onPressed: onLeaveReviewPressed,
                      color: ColorManager.kPrimaryColor,
                      textcolor: ColorManager.kWhiteColor),
                ),
                SizedBox(
                  width: Get.width * 0.02,
                ),
              ],
            )
        ],
      ),
    );
  }
}
