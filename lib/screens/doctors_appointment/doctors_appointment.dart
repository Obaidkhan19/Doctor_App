import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/components/appoint_ment_card/appointment.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/data/controller/my_appointments_controller.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/models/appointment_data.dart';
import 'package:doctormobileapplication/screens/family_screens/family_members.dart';
import '../../helpers/color_manager.dart';
import '../../helpers/font_manager.dart';
import '../../models/services_model.dart';

class DoctorsAppointment extends StatelessWidget {
  const DoctorsAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    var controller =
        Get.put<MyAppointmentsController>(MyAppointmentsController());
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: CustomAppBar(
          title: 'My Appointments',
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(AppPadding.p20),
        child: GetBuilder<MyAppointmentsController>(builder: (cont) {
          return Column(
            children: [
              CarouselSlider.builder(
                
                carouselController: CarouselController(),
                itemCount: services.length,
                itemBuilder: (context, index, realIndex) {
                  final service = services[index];
                  return InkWell(
                    onTap: () {
                      cont.updateAppointmentData(index);
                      log(cont.selectedAppointmentData.toString());
                    },
                    child: Center(
                      child: AnimatedOpacity(
                        opacity: 1.0,
                        duration: const Duration(seconds: 10),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: service.color,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(service.imagePath!),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Flexible(
                                child: Text(service.title!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: ColorManager.kWhiteColor,
                                          fontSize: 10,
                                        )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  initialPage: 2,
                  aspectRatio: 10 / 9,
                  enableInfiniteScroll: false,
                  height: Get.height * 0.18,
                  viewportFraction: 0.4,
                  enlargeFactor: 0.5,
                  onPageChanged: (index, reason) {
                    cont.updatePageIndex(index);
                    log(cont.pageIndex.toString());
                  },
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              const CustomTextField(
                hintText: 'Search',
                prefixIcon: Icon(
                  Icons.search,
                  color: ColorManager.kPrimaryColor,
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              TabBar(
                indicatorWeight: 3,
                labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14, fontWeight: FontWeightManager.semiBold),
                labelColor: ColorManager.kPrimaryColor,
                indicatorColor: ColorManager.kPrimaryColor,
                controller: controller.tabController,
                tabs: const [
                  Tab(
                    text: 'Upcoming',
                  ),
                  Tab(text: 'Completed'),
                  Tab(text: 'Cancelled'),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Expanded(
                child: cont.selectedAppointmentData == 3 ? TabBarView(
                  controller: controller.tabController,
                  children: [
                    buildAppointmentsList(
                      context,
                      [
                        AppointmentData(
                          statusText: 'Consult at Clinic',
                          statusColor: ColorManager.kOrangeColor,
                          name: 'Dr. Sheikh Hamid',
                          date: 'Aug 19,2023',
                          time: '10:00 AM',
                          type: 'Cardiology Specialist',
                          rating: '4.5',
                          showButtons: false,
                          onBookAgainPressed: () {},
                          onLeaveReviewPressed: () {},
                        ),
                        // Add more upcoming appointments here
                      ],
                    ),
                    buildAppointmentsList(
                      context,
                      [
                        AppointmentData(
                          statusText: 'Completed',
                          statusColor: Colors.green,
                          name: 'Dr Sheikh Hamid',
                          date: 'Aug 19, 2023',
                          time: '11:00 am',
                          type: 'Cardiology Specialist',
                          rating: '4.5',
                          showButtons: true,
                          onBookAgainPressed: () {},
                          onLeaveReviewPressed: () {},
                        ),
                      ],
                    ),
                    buildAppointmentsList(
                      context,
                      [
                        AppointmentData(
                          statusText: 'Cancelled',
                          statusColor: Colors.red,
                          name: 'Dr Sheikh Hamid',
                          date: 'Aug 19, 2023',
                          time: '11:00 AM',
                          type: 'Cardiology Specialist',
                          rating: '4.5',
                          showButtons: false,
                          onBookAgainPressed: () {},
                          onLeaveReviewPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ) : TabBarView(
                  controller: controller.tabController,
                  children: [
                    buildAppointmentsList(
                      context,
                      [
                        AppointmentData(
                          statusText: 'Rider Arriving Soon',
                          statusColor: ColorManager.kOrangeColor,
                          name: 'Dr. Sheikh Hamid',
                          date: 'Aug 19,2023',
                          time: '10:00 AM',
                          type: 'Home Sampling',
                          rating: '4.5',
                          showButtons: false,
                          onBookAgainPressed: () {},
                          onLeaveReviewPressed: () {},
                        ),
                      ],
                    ),
                    buildAppointmentsList(
                      context,
                      [
                        AppointmentData(
                          statusText: 'Completed',
                          statusColor: Colors.green,
                          name: 'Dr Sheikh Hamid',
                          date: 'Aug 19, 2023',
                          time: '11:00 am',
                          type: 'Home Sampling',
                          rating: '4.5',
                          showButtons: true,
                          onBookAgainPressed: () {},
                          onLeaveReviewPressed: () {},
                        ),
                      ],
                    ),
                    buildAppointmentsList(
                      context,
                      [
                        AppointmentData(
                          statusText: 'Cancelled',
                          statusColor: Colors.red,
                          name: 'Dr Sheikh Hamid',
                          date: 'Aug 19, 2023',
                          time: '11:00 AM',
                          type: 'Home Sampling',
                          rating: '4.5',
                          showButtons: false,
                          onBookAgainPressed: () {},
                          onLeaveReviewPressed: () {},
                        ),
                      ],
                    ),
                  ],
                )
              ),
            ],
          );
        }),
      ),
    );
  }

   buildAppointmentsList(
      BuildContext context, List<AppointmentData> appointmentDataList) {
    return ListView.builder(
      itemCount: appointmentDataList.length,
      itemBuilder: (context, index) {
        return AppointmentCard(
          statusText: appointmentDataList[index].statusText!,
          statusColor: appointmentDataList[index].statusColor!,
          name: appointmentDataList[index].name!,
          date: appointmentDataList[index].date!,
          time: appointmentDataList[index].time!,
          type: appointmentDataList[index].type!,
          rating: appointmentDataList[index].rating!,
          showButtons: appointmentDataList[index].showButtons!,
          onBookAgainPressed: appointmentDataList[index].onBookAgainPressed!,
          onLeaveReviewPressed: appointmentDataList[index].onLeaveReviewPressed!,
        );
      },
    );
  }
}





