import 'package:doctormobileapplication/screens/dashboard/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/font_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';

class FamilyMembers extends StatelessWidget {
  const FamilyMembers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80), child: CustomAppBar()),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20).copyWith(top: 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              PrimaryButton(
                  title: ' Add Family Members',
                  onPressed: () {},
                  color: ColorManager.kPrimaryColor,
                  fontSize: FontSize.s14,
                  textcolor: ColorManager.kWhiteColor),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p10),
                      child: customListTile(context),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  ListTile customListTile(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      tileColor: ColorManager.kPrimaryLightColor,
      title: Text(
        'Muhammad Yousuf',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: ColorManager.kPrimaryColor,
            fontSize: 14,
            fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'Mr. No. 123 4567 8901234 5',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: ColorManager.kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 10),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: ColorManager.kPrimaryColor,
            height: Get.height * 0.06,
            width: 2,
          ),
          SizedBox(
            width: Get.width * 0.02,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '38 years',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 11,
                    color: ColorManager.kPrimaryColor,
                    fontWeight: FontWeightManager.medium),
              ),
              Text(
                'Family head',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 11,
                    color: ColorManager.kPrimaryColor,
                    fontWeight: FontWeightManager.medium),
              ),
            ],
          ),
        ],
      ),
      leading: const CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(Images.docImagesmaleFemale),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final String? title;
  const CustomAppBar({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.kWhiteColor,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios,
              size: 20, color: ColorManager.kPrimaryColor)),
      centerTitle: true,
      title: Text(
        '$title',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    );
  }
}
