// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/data/controller/controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/screens/family_screens/family_members.dart';

class AddFamilyMember extends StatelessWidget {
  const AddFamilyMember({super.key});

  @override
  Widget build(BuildContext context) {
    var contr = Get.put<FamilyScreensController>(FamilyScreensController());
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50), child: CustomAppBar()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: SingleChildScrollView(
            child: GetBuilder<FamilyScreensController>(
              builder: (contr) {
                return Column(
                  children: [
                    const CustomTextField(
                      hintText: 'Mr. No',
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const CustomTextField(
                      hintText: 'Your Relation',
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    PrimaryButton(
                        title: 'Connect Family Member',
                        onPressed: () {},
                        fontweight: FontWeight.w900,
                        fontSize: 14,
                        color: ColorManager.kPrimaryColor,
                        textcolor: ColorManager.kWhiteColor),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Text(
                      'Add Family Member',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 13, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      'Personal Information',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    const CustomTextField(
                      hintText: 'Full Name',
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const CustomTextField(
                      hintText: 'Fathers Name',
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                     CustomTextField(
                      suffixIcon: IconButton(onPressed: (){
                        contr.selectDateAndTime(context, FamilyScreensController.arrival, contr.formatArrival);
                      }, icon: const Icon(Icons.arrow_drop_down)),
                      hintText: '${contr.formatArrival}',
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const CustomTextField(
                      hintText: 'Phone Numbers',
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                     CustomTextField(
                      hintText: 'Relation',
                      suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_drop_down)),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const CustomTextField(
                      hintText: 'ID 123 4567 8910',
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                     CustomTextField(
                      hintText: 'Gender',
                      suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_drop_down)),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                     CustomTextField(
                      hintText: 'Martial Status',
                      suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_drop_down)),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const CustomTextField(
                      hintText: 'Blodd Group',
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const CustomTextField(
                      hintText: 'Address',
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    PrimaryButton(
                        title: 'Add Family Member ',
                        onPressed: () {},
                        color: ColorManager.kPrimaryColor,
                        textcolor: ColorManager.kWhiteColor)
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}


