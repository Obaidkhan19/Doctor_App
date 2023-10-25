import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/success_or_failed.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/utils/constants.dart';

class AppointmentFailed extends StatelessWidget {
  const AppointmentFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            Images.logo,
            height: Get.height * 0.08,
          ),
        ),
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(AppPadding.p20),
              children:  [
                AppointSuccessfulOrFailedWidget(
                  image: Images.cross,
                  successOrFailedHeader: 'OOPS, Failed!',
                  appoinmentFailedorSuccessSmalltext:
                      AppConstants.appointMentFailed,
                  firstButtonText: 'Try Again',
                  secondButtonText: 'Cancel',
                )
              ],
            )
          ],
        ));
  }
}
