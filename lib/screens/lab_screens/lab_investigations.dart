// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/dropdown_data_widget.dart';
import 'package:doctormobileapplication/components/image_container.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/radio_button.dart';
import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/data/controller/google_maps_controller.dart';
import 'package:doctormobileapplication/data/controller/lab_investigations_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/models/packages_model.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:doctormobileapplication/screens/family_screens/family_members.dart';
import 'package:doctormobileapplication/screens/success_and_failure_screens/successful_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/lab_tests_model.dart';

class LabInvestigations extends StatefulWidget {
  final bool? isHomeSamle;
  final String? title;
  const LabInvestigations({super.key, this.title, this.isHomeSamle});

  @override
  State<LabInvestigations> createState() => _LabInvestigationsState();
}

class _LabInvestigationsState extends State<LabInvestigations> {
  @override
  void initState() {
    LabInvestigationController.i.selectedLabtest =
        LabInvestigationController.i.labtests?[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> customSummaryWidgets = [
      const DetailsRow(
        title: 'Test Sample',
        description: 'Oral Glucose Tolerance',
      ),
      const DetailsRow(
        title: 'Date & Hour',
        description: 'Aug 19, 2023 || 9:00 AM - 10 AM',
      ),
      const DetailsRow(
        title: 'Package',
        description: 'Home Sampling',
      ),
      DetailsRow(
        title: 'Prescribed By',
        description: '${LabInvestigationController.i.selectedalue}',
      ),
      const DetailsRow(
        title: 'Address',
        description: 'RawalPindi, Pakistan',
      ),
    ];

    List<Widget> onlinePayWidgets = [
      DetailsRow(
        title: 'Total Amount ',
        description:
            'AED ${LabInvestigationController.i.selectedLabtest!.actualPrice}',
      ),
      const DetailsRow(
        title: 'Home Sampling Charges',
        description: 'AED 00',
      ),
      SizedBox(
        height: Get.height * 0.01,
      ),
      const Divider(
        color: ColorManager.kGreyColor,
      ),
      SizedBox(
        height: Get.height * 0.01,
      ),
      const DetailsRow(
        title: 'Sub total',
        description: 'AED 35',
      ),
      const DetailsRow(
        title: 'Prescribed By',
        description: 'AED 00',
      ),
      const DetailsRow(
        title: 'Grand Total',
        description: 'AED 35',
      ),
    ];

    var cont =
        Get.put<LabInvestigationController>(LabInvestigationController());
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            title: '${widget.title}',
          )),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: GetBuilder<LabInvestigationController>(builder: (cont) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const ImageContainer(
                      isSvg: false,
                      imagePath: Images.microscope,
                      color: ColorManager.kWhiteColor,
                      backgroundColor: ColorManager.kPrimaryColor,
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    GetBuilder<LabInvestigationController>(builder: (cont) {
                      return Flexible(
                        child: DropdownDataWidget<Data>(
                            hint: 'Lab Tests',
                            items: cont.labtests!,
                            selectedValue: cont.selectedLabtest,
                            onChanged: (value) {
                              cont.updateLabTest(value!);
                            },
                            itemTextExtractor: (value) => value.name!),
                      );
                    }),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    addIcon(),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  children: [
                    GetBuilder<LabInvestigationController>(builder: (cont) {
                      return Flexible(
                        child: DropdownDataWidget<LabPackages>(
                            hint: 'Lab Tests',
                            items: cont.labPackages!,
                            selectedValue: cont.selectedLabPackage,
                            onChanged: (value) {
                              cont.updateSelectedLabPackage(value!);
                            },
                            itemTextExtractor: (value) =>
                                value.packageGroupName!),
                      );
                    }),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ColorManager.kPrimaryLightColor),
                        child: DatePicker(
                          DateTime.now(),
                          dateTextStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: ColorManager.kPrimaryColor,
                                  fontWeight: FontWeight.w900),
                          dayTextStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: ColorManager.kPrimaryColor,
                                  fontWeight: FontWeight.w300),
                          monthTextStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: ColorManager.kPrimaryColor,
                                  fontWeight: FontWeight.w300),
                          deactivatedColor: ColorManager.kPrimaryLightColor,
                          height: Get.height * 0.18,
                          initialSelectedDate: DateTime.now(),
                          selectionColor: ColorManager.kPrimaryColor,
                          selectedTextColor: Colors.white,
                          onDateChange: (date) {
                            cont.updateSelectedDatae(date);
                            log('${cont.selectedDate}');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                GetBuilder<LabInvestigationController>(builder: (cont) {
                  return CustomTextField(
                    hintText: cont.formattedSelectedTime != null
                        ? '${cont.formattedSelectedTime}'
                        : "Schedule",
                    readonly: true,
                    isSizedBoxAvailable: false,
                    suffixIcon: InkWell(
                        onTap: () {
                          cont.selectTime(
                              context,
                              LabInvestigationController.selectedTime,
                              cont.formattedSelectedTime);
                        },
                        child: Image.asset(Images.dropdown)),
                    suffixStyle: const TextStyle(
                        color: ColorManager.kGreyColor, fontSize: 12),
                  );
                }),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                CustomTextField(
                  controller: cont.description,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ).copyWith(top: 15),
                  maxlines: 4,
                  hintText: 'Description',
                  isSizedBoxAvailable: false,
                  suffixStyle: const TextStyle(
                      color: ColorManager.kGreyColor, fontSize: 12),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                widget.isHomeSamle == true
                    ? GetBuilder<AddressController>(builder: (cont) {
                        return CustomTextField(
                          prefixIcon: IconButton(
                              onPressed: () {
                                // AddressController.i.markers.clear();
                                // AddressController.i.markers.add(Marker(
                                //     markerId: const MarkerId('1'),
                                //     position: LatLng(
                                //         AddressController.i.latitude!,
                                //         AddressController.i.longitude!)));
                                // Get.to(() => const GoogleMaps());
                              },
                              icon: const Icon(
                                Icons.pin_drop_outlined,
                                color: ColorManager.kPrimaryColor,
                              )),
                          hintText: cont.address == null
                              ? 'Address'
                              : '${cont.address}',
                          readonly: true,
                          isSizedBoxAvailable: false,
                          suffixStyle: const TextStyle(
                              color: ColorManager.kGreyColor, fontSize: 12),
                        );
                      })
                    : const SizedBox.shrink(),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                CustomTextField(
                  prefixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.payment,
                        color: ColorManager.kPrimaryColor,
                      )),
                  hintText: 'Payment Method',
                  readonly: true,
                  suffixIcon: InkWell(
                      onTap: () async {
                        bool? isLogin = await LocalDb().getLoginStatus();
                        if (isLogin == true) {
                          showSnackbar(
                              context, 'payment Functionality Coming Soon');
                        } else {
                          Get.to(() => const LoginScreen());
                        }
                      },
                      child: Image.asset(Images.masterCard)),
                  isSizedBoxAvailable: false,
                  suffixStyle: const TextStyle(
                      color: ColorManager.kGreyColor, fontSize: 12),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  'Prescribed by',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorManager.kPrimaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                const RadioButtonRow(),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Visibility(
                  visible: cont.selectedalue == 1,
                  child: CustomTextField(
                    hintText: 'Select Doctor',
                    suffixIcon: Image.asset(Images.dropdown),
                  ),
                ),
                Visibility(
                  visible: cont.selectedalue == 2,
                  child: Column(
                    children: [
                      const CustomTextField(
                        hintText: 'Doctor Name',
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      PrimaryButton(
                          title: 'Attach Prescription',
                          onPressed: () {},
                          fontSize: 14,
                          color: ColorManager.kPrimaryColor,
                          textcolor: ColorManager.kWhiteColor),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Visibility(
                  visible: cont.selectedalue == 0 ||
                      cont.selectedalue == 1 ||
                      cont.selectedalue == 2,
                  child: SummaryContainer(
                    title: 'Summary',
                    summaryWidgets: customSummaryWidgets,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Visibility(
                  visible: cont.selectedalue == 0 ||
                      cont.selectedalue == 1 ||
                      cont.selectedalue == 2,
                  child: SummaryContainer(
                    title: 'Online Pay',
                    isOnlinePay: true,
                    summaryWidgets: onlinePayWidgets,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Visibility(
                  visible: cont.selectedalue == 0 ||
                      cont.selectedalue == 1 ||
                      cont.selectedalue == 2,
                  child: PrimaryButton(
                      title: 'Appointment Confirm',
                      fontSize: 14,
                      onPressed: () {
                        Get.to(() => const SuccessFulAppointScreen());
                      },
                      color: ColorManager.kPrimaryColor,
                      textcolor: ColorManager.kWhiteColor),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  addIcon() {
    return const ImageContainer(
      imagePath: Images.add,
      isSvg: false,
      color: ColorManager.kWhiteColor,
      backgroundColor: ColorManager.kPrimaryColor,
    );
  }
}

class SummaryContainer extends StatelessWidget {
  final String? title;
  final bool? isOnlinePay;
  final List<Widget> summaryWidgets;

  const SummaryContainer({
    Key? key,
    this.isOnlinePay = false,
    this.title,
    required this.summaryWidgets, // Pass a List of Widget objects
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 14, fontWeight: FontWeight.w900),
        ),
        SizedBox(height: Get.height * 0.02),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: ColorManager.kGreyColor),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: summaryWidgets, // Use the passed list of widgets
          ),
        ),
      ],
    );
  }
}

class DetailsRow extends StatelessWidget {
  final String? title;
  final String? description;
  const DetailsRow({
    super.key,
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w300, fontSize: 12),
            ),
            Text(
              '$description',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w900, fontSize: 12),
            )
          ],
        ),
        SizedBox(
          height: Get.height * 0.02,
        )
      ],
    );
  }
}
