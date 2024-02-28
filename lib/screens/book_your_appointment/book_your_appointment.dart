import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/data/controller/specialities_controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/font_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/models/search_models.dart';
import 'package:doctormobileapplication/screens/family_screens/family_members.dart';
import 'package:doctormobileapplication/screens/specialists_screen/specialists_screen.dart';

import '../../components/images.dart';

class BookyourAppointment extends StatefulWidget {
  const BookyourAppointment({super.key});

  @override
  State<BookyourAppointment> createState() => _BookyourAppointmentState();
}

class _BookyourAppointmentState extends State<BookyourAppointment> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(Get.height * 0.08),
            child: const CustomAppBar(
              title: 'Book your Appointment',
            )),
        body: GetBuilder<SpecialitiesController>(builder: (cont) {
          return SpecialitiesController.i.isLoading == false
              ? SafeArea(
                  minimum: const EdgeInsets.all(AppPadding.p20),
                  child: SingleChildScrollView(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const CustomTextField(
                        //   hintText: 'Search for departments',
                        //   prefixIcon: Icon(
                        //     Icons.search,
                        //     color: ColorManager.kPrimaryColor,
                        //   ),
                        // ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        GetBuilder<SpecialitiesController>(builder: (cont) {
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cont.doctors.length,
                              itemBuilder: (context, index) {
                                final doctor = cont.doctors[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: ListTile(
                                    onTap: () async {
                                      log('over here');
                                      List<Search> search =
                                          await SpecialitiesController.i
                                              .getDoctors(doctor.id!);
                                      Get.to(() => Specialists(
                                            doctors: search,
                                            title: doctor.name,
                                          ));
                                    },
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: ColorManager.kPrimaryColor,
                                            width: 0.4),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    leading: const CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(Images.covid),
                                    ),
                                    title: Text(
                                      '${doctor.name}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: ColorManager.kblackColor,
                                              fontWeight:
                                                  FontWeightManager.bold),
                                    ),
                                    subtitle: Text(
                                      '${doctor.subSpecialities}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight:
                                                  FontWeightManager.light,
                                              fontSize: 12),
                                    ),
                                  ),
                                );
                              });
                        })
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        }));
  }
}
