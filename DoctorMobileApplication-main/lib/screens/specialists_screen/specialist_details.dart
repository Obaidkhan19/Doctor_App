import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/font_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/models/search_models.dart';
import 'package:doctormobileapplication/screens/family_screens/family_members.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../no_data_found/no_data_found.dart';

class SpecialistDetails extends StatelessWidget {
  final String? title;
  final Search? doctors;
  const SpecialistDetails({super.key, this.doctors, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CustomAppBar(
            title: 'Cardiology Specialist',
          )),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DoctorWidget(
                doctor: doctors,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  customColumn(context,
                      backgroundColor: ColorManager.kPrimaryColor,
                      icon: Icons.people_outline,
                      title: '5000+',
                      subtitle: 'Patients'),
                  customColumn(context,
                      icon: Icons.auto_graph_sharp,
                      title: '${doctors!.numberofExpereinceyear}',
                      subtitle: 'Years Experience',
                      backgroundColor: Colors.green),
                  customColumn(context,
                      icon: Icons.star_outline_outlined,
                      title: '4.5',
                      subtitle: 'Ratings',
                      backgroundColor: ColorManager.kyellowContainer),
                  customColumn(context,
                      icon: Icons.chat_outlined,
                      title: '${doctors?.noOfVotes}',
                      subtitle: 'Reviews'),
                ],
              ),
              const Divider(
                thickness: 2,
              ),
              Text(
                'Description',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorManager.kblackColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                AppConstants.description,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: ColorManager.kblackColor, fontSize: 12),
              ),
              const Divider(
                thickness: 2,
              ),
              Text(
                'Working Time',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                'Monday - Saturday, 09:00 AM - 16:00 PM ',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeightManager.regular),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Text(
                'Online & Clinic Consultation Charges',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Text(
                    'Online',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.green, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    ' - AED ${doctors!.onlineVideoConsultationFee} & ',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorManager.kblackColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Clinic',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorManager.kRedColor,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${doctors?.consultancyFee}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorManager.kblackColor,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              PrimaryButton(
                  fontSize: 13,
                  title: 'Book your Appointment',
                  onPressed: () {
                    Get.to(() => NoDataFound(
                          Title: 'your Booked Appointment',
                        ));
                  },
                  color: ColorManager.kPrimaryColor,
                  textcolor: ColorManager.kWhiteColor)
            ],
          ),
        ),
      ),
    );
  }

  customColumn(BuildContext context,
      {IconData? icon,
      String? title,
      String? subtitle,
      Color? backgroundColor}) {
    return SizedBox(
      height: Get.height * 0.2,
      width: Get.width * 0.22,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
              backgroundColor: backgroundColor,
              radius: 25,
              child: Icon(
                icon,
                size: 25,
                color: ColorManager.kWhiteColor,
              )),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Text(
            '$title',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorManager.kPrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 12),
          ),
          Text(
            '$subtitle',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class DoctorWidget extends StatelessWidget {
  final Search? doctor;
  const DoctorWidget({
    super.key,
    this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Get.height * 0.15,
            width: Get.width * 0.25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: AssetImage(Images.profile), fit: BoxFit.contain)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: Get.width * 0.4,
                      child: Text(
                        '${doctor?.name}',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorManager.kblackColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    const Icon(
                      Icons.favorite,
                      color: ColorManager.kRedColor,
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  'Cardiology',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 12),
                ),
                Text(
                  'Health Care Hospital',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
