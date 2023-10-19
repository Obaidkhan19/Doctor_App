import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/screens/family_screens/family_members.dart';

double screenWidth = MediaQuery.of(Get.context!).size.width;

class HealthSummary extends StatelessWidget {
  const HealthSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          title: 'Health Summary',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 300,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 2,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    return dataWidget(context);
                  }),
              Container(
                padding: const EdgeInsets.all(AppPadding.p16),
                decoration:
                    const BoxDecoration(color: ColorManager.kPrimaryLightColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Diagnostics',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: ColorManager.kPrimaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900),
                        ),
                        Text(
                          'Status',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: ColorManager.kPrimaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text(
                      'Test',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorManager.kPrimaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'X-Ray KUB',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: ColorManager.kPrimaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900),
                        ),
                        const Icon(Icons.folder_copy_sharp)
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  dataWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Glucose',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: ColorManager.kPrimaryColor, fontWeight: FontWeight.w900),
        ),
        Container(
          width: Get.width * 0.5,
          padding: const EdgeInsets.all(AppPadding.p10)
              .copyWith(top: 30, bottom: 30),
          decoration: BoxDecoration(
              color: ColorManager.kPrimaryLightColor,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '19-07-99',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorManager.kPrimaryColor,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Container(
                padding: const EdgeInsets.all(AppPadding.p4)
                    .copyWith(left: 15, right: 15),
                decoration: BoxDecoration(
                    color: ColorManager.kWhiteColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Random \n 132',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 10, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Text(
                      'Fasting \n 106',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 10, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Text(
                'mg/dl',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorManager.kPrimaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        PrimaryButton(
          title: 'Connect',
          onPressed: () {},
          color: ColorManager.kPrimaryColor,
          textcolor: ColorManager.kWhiteColor,
          fontSize: 12,
        )
      ],
    );
  }
}
