import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/success_or_failed.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:doctormobileapplication/utils/constants.dart';

class SuccessFulAppointScreen extends StatelessWidget {
  const SuccessFulAppointScreen({super.key});

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
          const BackgroundLogoimage(),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: ListView(
              children:   [
                AppointSuccessfulOrFailedWidget(
                  image: Images.correct,
                  successOrFailedHeader: 'Congratulations!',
                  appoinmentFailedorSuccessSmalltext: AppConstants.appointmentSuccessful,
                  firstButtonText: 'OK',
                  secondButtonText: 'Cancel',

                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

