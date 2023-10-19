// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:doctormobileapplication/components/custom_textfields.dart';
import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/components/success_or_failed.dart';
import 'package:doctormobileapplication/data/controller/my_appointments_controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/helpers/enums.dart';
import 'package:doctormobileapplication/helpers/values_manager.dart';
import 'package:doctormobileapplication/screens/family_screens/family_members.dart';
import 'package:doctormobileapplication/screens/specialists_screen/specialist_details.dart';
import 'package:doctormobileapplication/screens/specialists_screen/specialists_screen.dart';
import 'package:doctormobileapplication/utils/card_utils/card_utils.dart';

bool? isPaymentComplete = false;

class AppointmentCreation extends StatefulWidget {
  const AppointmentCreation({super.key});

  @override
  State<AppointmentCreation> createState() => _AppointmentCreationState();
}

class _AppointmentCreationState extends State<AppointmentCreation> {
  CardType? cardType;
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController cardHolderController = TextEditingController();

  void getCardTypeFrmNumber() {
    if (cardNumberController.text.length <= 6) {
      String input = CardUtils.getCleanedNumber(cardNumberController.text);
      CardType type = CardUtils.getCardTypeFrmNumber(input);
      if (type != cardType) {
        setState(() {
          cardType = type;
        });
      }
    }
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    cardNumberController.addListener(
      () {
        getCardTypeFrmNumber();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller =
        Get.put<MyAppointmentsController>(MyAppointmentsController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(
            title: 'Book Appointment',
          )),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DoctorWidget(),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Text(
                'Select Date',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorManager.kblackColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
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
                                fontWeight: FontWeight.w900,
                                fontSize: 12),
                        dayTextStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                color: ColorManager.kPrimaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                        monthTextStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                color: ColorManager.kPrimaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                        deactivatedColor: ColorManager.kPrimaryLightColor,
                        height: Get.height * 0.16,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: ColorManager.kPrimaryColor,
                        selectedTextColor: Colors.white,
                        onDateChange: (date) {},
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              GridView.builder(
                  shrinkWrap: true,
                  itemCount: 8,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 25,
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: ((context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: ColorManager.kPrimaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        '11 : 00',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorManager.kWhiteColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      )),
                    );
                  })),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Text(
                'Write your problem',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorManager.kblackColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              const CustomTextField(
                maxlines: 5,
                hintText: '',
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
               const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PositionedButtonWidget(
                    bottom: 0,
                    icon: Icons.video_call_outlined,
                    alignment: Alignment.centerRight,
                    iconColor: Color(0xFFF21F61),
                    borderColor: Color(0xFFF21F61),
                    buttonText: 'Get Appointment',
                  ),
                  PositionedButtonWidget(
                    bottom: 0,
                    isImage: true,
                    imagePath: Images.clinic,
                    alignment: Alignment.centerLeft,
                    iconColor: Color(0xFF0B8AA0),
                    borderColor: Color(0xFF0B8AA0),
                    buttonText: 'Consult at Clinic',
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              CustomTextField(
                hintText: 'Payment Method',
                readonly: true,
                isSizedBoxAvailable: false,
                suffixIcon: InkWell(
                    onTap: () async {
                      PaymentMethodDialogue(context);
                    },
                    child: Image.asset(Images.masterCard)),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              PrimaryButton(
                  fontSize: 14,
                  title: 'Book Appointment',
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setstate) {
                            return Material(
                              type: MaterialType.transparency,
                              color: Colors.transparent,
                              child: AlertDialog(
                                backgroundColor: Colors.transparent,
                                content: Column(
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.08,
                                    ),
                                    const AppointSuccessfulOrFailedWidget(
                                      titleImage: false,
                                      image: Images.cross,
                                      successOrFailedHeader: 'Oops, Failed!',
                                      appoinmentFailedorSuccessSmalltext:
                                          'Appointment failed please check your internet connection then try again.',
                                      firstButtonText: 'Try Again',
                                      secondButtonText: 'Cancel',
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                        });
                  },
                  color: ColorManager.kPrimaryColor,
                  textcolor: ColorManager.kWhiteColor)
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> PaymentMethodDialogue(BuildContext context) {
    return showDialog(
                        context: context,
                        builder: (context) {
                          return Material(
                              type: MaterialType.transparency,
                              shape: const RoundedRectangleBorder(),
                              color: ColorManager.kWhiteColor,
                              child: AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Image.asset(
                                                Images.crossicon))),
                                    SizedBox(
                                      height: Get.height * 0.04,
                                    ),
                                    Text(
                                      'Payment Method',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color:
                                                  ColorManager.kPrimaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w900),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.09,
                                    ),
                                    buildStyledContainer(
                                        'Pay from your Wallet',
                                        context,
                                        false,
                                        () {}),
                                    SizedBox(height: Get.height * 0.01),
                                    buildStyledContainer(
                                        'Pay Online', context, true, () {
                                      Get.back();
                                      paymentDialogue(context);
                                    }),
                                    SizedBox(height: Get.height * 0.01),
                                    buildStyledContainer('Pay at Clinic',
                                        context, false, () {}),
                                    SizedBox(height: Get.height * 0.01),
                                    // Add more containers as needed
                                  ],
                                ),
                              ));
                        });
  }

  paymentDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setstate) {
            return Material(
              type: MaterialType.transparency,
              color: ColorManager.kWhiteColor,
              child: AlertDialog(
                content: Column(
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Image.asset(Images.crossicon))),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text(
                      'Add Top up Credit',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: ColorManager.kPrimaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: Get.height * 0.08,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Choose your topup amount',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: ColorManager.kPrimaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900),
                        ),
                        Image.asset(Images.masterCard)
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    CreditCardFormField(
                      controller: cardNumberController,
                      hintText: 'Enter Credit Card Number',
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                        CardNumberInputFormatter(),
                      ],
                      validator: CardUtils.validateCardNum,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CreditCardFormField(
                          controller: expiryDateController,
                          hintText: 'Expiry Date MM/YY',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                            CardMonthInputFormatter(),
                          ],
                        )),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Expanded(
                          child: CreditCardFormField(
                            controller: cvvController,
                            hintText: 'CVV',
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    CreditCardFormField(
                      controller: cardHolderController,
                      hintText: 'Card Holder Name',
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text(
                      'To verify your credit/debit card, a small amount will be charged from you, after verification amount will be added to your wallet',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorManager.kblackColor,
                          fontWeight: FontWeight.w300,
                          fontSize: 10),
                    ),
                    const Spacer(),
                    GetBuilder<MyAppointmentsController>(builder: (cont) {
                      return PrimaryButton(
                          title: 'Confirm',
                          onPressed: () {
                            cont.updatePayment(true);
                            log('pressed');
                            Get.back();
                          },
                          color: ColorManager.kPrimaryColor,
                          textcolor: ColorManager.kWhiteColor);
                    })
                  ],
                ),
              ),
            );
          });
        });
  }

  buildStyledContainer(String text, BuildContext context,
      bool? hasMasterCardImage, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: ColorManager.kPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,
                style: const TextStyle(
                    fontSize: 12, color: ColorManager.kWhiteColor)),
            if (hasMasterCardImage!)
              Image.asset(Images.masterCard, width: 40, height: 20),
          ],
        ),
      ),
    );
  }
}

class CreditCardFormField extends StatelessWidget {
  const CreditCardFormField({
    super.key,
     this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.validator,
  });

  final TextEditingController? controller;
  final String hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      style: const TextStyle(
        color: ColorManager.kPrimaryColor,
        fontWeight: FontWeight.w900,
      ),
      decoration: InputDecoration(
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w300,
          color: ColorManager.kblackColor,
          fontSize: 12,
        ),
        hintText: hintText,
        filled: true,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorManager.kPrimaryLightColor),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: ColorManager.kPrimaryLightColor),
        ),
        fillColor: ColorManager.kPrimaryLightColor,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorManager.kPrimaryLightColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
