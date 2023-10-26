import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/data/controller/ConsultingQueue_Controller.dart';
import 'package:doctormobileapplication/data/repositories/callrepo.dart';
import 'package:doctormobileapplication/models/consultingqueuewaithold.dart';
import 'package:doctormobileapplication/utils/AppImages.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:doctormobileapplication/utils/testing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Callwatingscreen extends StatefulWidget {
  consultingqueuewaitholdresponse? data;
  Callwatingscreen({super.key, required this.data});

  @override
  State<Callwatingscreen> createState() => _CallwatingscreenState();
}

class _CallwatingscreenState extends State<Callwatingscreen> {
int val=0;

opencall() async{
 val = Callrepo().callOpenPrescription(context, widget.data!);

}

  @override
  void initState() {

  opencall();
   Timer.periodic(const Duration(seconds: 1), (timer) async { 
  if(ConsultingQueueController.i.checkcallresponse==true)
  {
    timer.cancel();
    ConsultingQueueController.i.updatecallresponse(false);
     Get.to( ()=> MyHomePage(title: widget.data!.chatURL));
    Get.back();
  }
 });
        super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(     
      body: SizedBox(
        width: Get.width * 1,
        height: Get.height * 1,
        child: Container(
          width: Get.width * 1,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.helpful_background_logo),
              alignment: Alignment.centerLeft,
            ),
          ),
          child:  Center(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
               CircleAvatar(
                
              child: widget.data!
                                                                      .patientImagePath !=
                                                                  null
                                                              ? ClipRRect(
                                                                borderRadius: BorderRadius.circular(20),
                                                                child: CachedNetworkImage(
                                                                  height: Get.width*0.2,
                                                                    imageUrl:baseURL +
                                                                        widget.data?.
                                                                            patientImagePath,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Image.asset(
                                                                            Images
                                                                                .avator),
                                                                  ),
                                                              ) : ClipRRect(
                                                                borderRadius: BorderRadius.circular(20),
                                                                child: Image.asset(
                                                                  height: Get.width*0.2,
                                                                    Images
                                                                        .avator),
                                                              ),
              ),
              SizedBox(
                height: Get.height*0.05,
              ),
              Text(widget.data?.patientName??"Patient Name"),
              SizedBox(
                height: Get.height*0.05,
              ),
              const Text("Waiting for the Patient...")
            ],
          )),
        ),
      ),
    );
  }
}
