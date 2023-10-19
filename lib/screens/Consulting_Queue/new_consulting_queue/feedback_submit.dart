import 'package:confetti/confetti.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/new_consulting_queue/consulting_queue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackSubmitScreen extends StatefulWidget {
  const FeedbackSubmitScreen({super.key});

  @override
  State<FeedbackSubmitScreen> createState() => _FeedbackSubmitScreenState();
}

class _FeedbackSubmitScreenState extends State<FeedbackSubmitScreen> {
  final confController = ConfettiController();
  bool isPlaying = false;
  @override
  void dispose() {
    super.dispose();
    confController.stop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    confController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height * 0.15,
          ),
          ConfettiWidget(
            confettiController: confController,
            shouldLoop: true,
            blastDirectionality: BlastDirectionality.explosive,
            gravity: 0.3,
            numberOfParticles: 30,
          ),
          SizedBox(
            height: Get.height * 0.15,
          ),
          Center(child: Image.asset(Images.feedbacksubmit)),
          SizedBox(
            height: Get.height * 0.03,
          ),
          Text(
            'thankyouforthefeedback'.tr,
            style: GoogleFonts.poppins(
                fontSize: 15,
                color: ColorManager.kblackColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: Get.height * 0.25,
          ),
          Center(
            child: InkWell(
              onTap: () {
                confController.stop();
                Get.to(() => const ConsultingQueueScreen());
              },
              child: Container(
                height: Get.height * 0.07,
                width: Get.width * 0.8,
                decoration: BoxDecoration(
                  color: ColorManager.kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'gotoconsultingqueue'.tr,
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: ColorManager.kWhiteColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
