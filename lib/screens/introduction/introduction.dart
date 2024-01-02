import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/localDB/local_db.dart';

class Introduction extends StatelessWidget {
  const Introduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(AppPadding.p24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              Text(
                'Take Care of Your health!',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 45),
              ),
              Row(
                children: [
                  const Text('With'),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    appName,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: ColorManager.kPrimaryColor, fontSize: 16),
                  ),
                ],
              ),
              Container(
                height: Get.height * 0.6,
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage(
                          Images.docImagesmaleFemale,
                        ),
                        fit: BoxFit.contain)),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Text(
                'Manage your health ease with us',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: ColorManager.kPrimaryDark),
              ),
              SizedBox(
                height: Get.height * 0.07,
              ),
              PrimaryButton(
                  height: 40,
                  title: 'Go',
                  onPressed: () {
                    LocalDb().saveIsFirstTime(false);
                    Get.to(() => const LoginScreen());
                  },
                  color: ColorManager.kPrimaryColor,
                  textcolor: ColorManager.kWhiteColor),
            ],
          ),
        ),
      ),
    );
  }
}
