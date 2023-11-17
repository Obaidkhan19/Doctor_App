// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'dart:io';

import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/data/controller/auth_controller.dart';
import 'package:doctormobileapplication/data/controller/controller.dart';
import 'package:doctormobileapplication/data/repositories/auth_repository/auth_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/cities_model.dart';
import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/genders_model.dart';
import 'package:doctormobileapplication/models/provinces_model.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:doctormobileapplication/utils/textfield_masks/masks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../components/dropdown_data_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String? countryCode;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var contr = Get.put<AuthController>(AuthController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Image.asset(
          Images.logo,
          height: Get.height * 0.08,
        ),
      ),
      body: GetBuilder<AuthController>(builder: (cont) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    const BackgroundLogoimage(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Register Now',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: contr.file != null
                                  ? DecorationImage(
                                      image: FileImage(File(contr.file!.path)),
                                      fit: BoxFit.cover)
                                  : const DecorationImage(
                                      image: AssetImage(Images.profile),
                                      fit: BoxFit.cover)),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.green,
                                child: IconButton(
                                    onPressed: () {
                                      contr.pickImage();
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 15,
                                    )),
                              )),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        AuthTextField(
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return 'Enter your full name';
                            }
                            return null;
                          },
                          controller: contr.fullname,
                          hintText: 'Full Name',
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        IntlPhoneField(
                          initialCountryCode: '966',
                          controller: contr.phone,
                          disableLengthCheck: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            disabledBorder: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: ColorManager.kGreyColor)),
                            border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: ColorManager.kGreyColor)),
                          ),
                          languageCode: "en",
                          onSaved: (newValue) {},
                          onSubmitted: (p0) {
                            cont.phone.text = p0;
                            log(cont.phone.text);
                          },
                          onCountryChanged: (country) {
                            setState(() {
                              countryCode = country.dialCode;
                            });
                          },
                          validator: (value) {
                            if (!value!.isValidNumber()) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        AuthTextField(
                          validator: (value) {
                            if (value!.isEmpty || !value.isEmail) {
                              return 'Please Enter a valid email';
                            }
                            return null;
                          },
                          controller: cont.email,
                          hintText: 'Email',
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        AuthTextField(
                          validator: (value) {
                            return null;
                          },
                          hintText: contr.formatArrival == null
                              ? 'Date of birth'
                              : cont.formatArrival.toString(),
                          suffixIcon: IconButton(
                              onPressed: () async {
                                FamilyScreensController.i.selectDateAndTime(
                                    context,
                                    AuthController.arrival,
                                    cont.formatArrival);
                              },
                              icon: Image.asset(Images.dropdown)),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        GetBuilder<AuthController>(builder: (cont) {
                          return Row(
                            children: [
                              Flexible(
                                child: DropdownDataWidget<GendersData>(
                                    boxBorder: Border.all(
                                        color: ColorManager.kGreyColor),
                                    fillColor: Colors.transparent,
                                    textColor: ColorManager.kGreyColor,
                                    hint: 'select Gender',
                                    items: AuthController.i.genders!,
                                    selectedValue:
                                        AuthController.i.selectedGender,
                                    onChanged: (value) {
                                      cont.updateGender(value!);
                                    },
                                    itemTextExtractor: (value) => value.name!),
                              ),
                            ],
                          );
                        }),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        AuthTextField(
                          formatters: [Masks().maskFormatter],
                          controller: cont.identity,
                          hintText: 'Enter your Identity number',
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: DropdownDataWidget<Countries>(
                                  boxBorder: Border.all(
                                      color: ColorManager.kGreyColor),
                                  fillColor: Colors.transparent,
                                  textColor: ColorManager.kGreyColor,
                                  hint: 'select Country',
                                  items: AuthController.i.mycountries!,
                                  selectedValue:
                                      AuthController.i.selectedCountry,
                                  onChanged: (value) async {
                                    cont.updateSelectedCountry(value!);
                                    AuthController.i.provinces =
                                        await AuthRepo.getProvinces(value.id!);
                                    if (AuthController.i.provinces.isNotEmpty &&
                                        AuthController.i.provinces != null) {
                                      setState(() {
                                        AuthController.i.selectedProvince =
                                            null;
                                        AuthController.i.selectedCity = null;
                                      });
                                    }
                                  },
                                  itemTextExtractor: (value) => value.name!),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: DropdownDataWidget<Provinces>(
                                  boxBorder: Border.all(
                                      color: ColorManager.kGreyColor),
                                  fillColor: Colors.transparent,
                                  textColor: ColorManager.kGreyColor,
                                  hint: 'select Province',
                                  items: AuthController.i.provinces,
                                  selectedValue:
                                      AuthController.i.selectedProvince,
                                  onChanged: (value) async {
                                    log('province id ${value!.id}');
                                    AuthController.i.cities =
                                        await AuthRepo.getCities(value.id!);
                                    if (AuthController.i.cities != null &&
                                        AuthController.i.cities.isEmpty) {
                                      setState(() {
                                        AuthController.i.selectedCity = null;
                                      });
                                    }
                                    cont.updateSelectedProvince(value);
                                    AuthController.i.update();
                                  },
                                  itemTextExtractor: (value) => value.name!),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: DropdownDataWidget<Cities>(
                                  boxBorder: Border.all(
                                      color: ColorManager.kGreyColor),
                                  fillColor: Colors.transparent,
                                  textColor: ColorManager.kGreyColor,
                                  hint: 'select Ciry',
                                  items: cont.cities,
                                  selectedValue: cont.selectedCity,
                                  onChanged: (value) {
                                    setState(() {
                                      AuthController.i.selectedCity = value;
                                    });
                                    AuthController.i.update();
                                  },
                                  itemTextExtractor: (value) => value.name!),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        const AuthTextField(
                          hintText: 'Street',
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        AuthTextField(
                          controller: cont.password,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Password';
                            }
                            return null;
                          },
                          hintText: 'Password',
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        AuthTextField(
                          controller: cont.retypePassword,
                          obscureText: true,
                          validator: (value) {
                            if (cont.password.text !=
                                cont.retypePassword.text) {
                              return 'Passwords do not match';
                            }
                            if (value!.isEmpty) {
                              return 'Please confirm Password before proceeding';
                            }
                            return null;
                          },
                          hintText: 'Confirm Password',
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        PrimaryButton(
                            title: 'Register',
                            onPressed: () {
                              // log('$countryCode${cont.phone.text}');
                              // if (_formKey.currentState!.validate() &&
                              //     AuthController.i.file != null) {
                              //   AuthRepo.signup(
                              //       name: cont.fullname.text,
                              //       email: cont.email.text,
                              //       id: cont.identity.text,
                              //       phoneNumber:
                              //           ' $countryCode${cont.phone.text}',
                              //       cityId: AuthController.i.selectedCity!.id,
                              //       file: AuthController.i.file,
                              //       genderId:
                              //           AuthController.i.selectedGender!.id,
                              //       selectedDate:
                              //           AuthController.i.formatArrival!.string,
                              //       password: cont.password.text,
                              //       retypePassword: cont.retypePassword.text);
                              // } else {
                              //   showSnackbar(context,
                              //       'Fill all the fields and add your profile picture');
                              // }
                            },
                            color: ColorManager.kPrimaryColor,
                            textcolor: ColorManager.kWhiteColor),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        SignupOrLoginText(
                          onTap: () => Get.to(() => const LoginScreen()),
                          pre: 'Already have an account?',
                          suffix: 'Login',
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
