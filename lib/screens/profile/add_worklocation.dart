// import 'package:doctormobileapplication/components/custom_textfields.dart';
// import 'package:doctormobileapplication/components/images.dart';
// import 'package:doctormobileapplication/components/primary_button.dart';
// import 'package:doctormobileapplication/components/searchable_dropdown.dart';
// import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
// import 'package:doctormobileapplication/data/repositories/Consulting_Queue_repo/consultingQueue_repo.dart';
// import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
// import 'package:doctormobileapplication/helpers/color_manager.dart';
// import 'package:doctormobileapplication/models/cities_model.dart';
// import 'package:doctormobileapplication/models/countries_model.dart';
// import 'package:doctormobileapplication/models/hospital_clinic.dart';
// import 'package:doctormobileapplication/models/provinces_model.dart';
// import 'package:doctormobileapplication/screens/auth_screens/login.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AddWorklocation extends StatefulWidget {
//   const AddWorklocation({super.key});

//   @override
//   State<AddWorklocation> createState() => _AddWorklocationState();
// }

// class _AddWorklocationState extends State<AddWorklocation> {
//   var edit = Get.put<EditProfileController>(EditProfileController());

//   _getHospital() async {
//     ConsultingQueueRepo cqr = ConsultingQueueRepo();
//     EditProfileController.i.updatehospitallist(
//       await cqr.getHospitalORClinic(),
//     );
//   }

//   _getCountries() async {
//     ProfileRepo pr = ProfileRepo();
//     EditProfileController.i.updateworklocationcountriesList(
//       await pr.getCountries(),
//     );
//   }

//   _getProvinces(cid) async {
//     ProfileRepo pr = ProfileRepo();
//     cid ??= EditProfileController.i.selectedcountry?.id;
//     EditProfileController.i.updateworklocationstateList(
//       await pr.getProvinces(cid),
//     );
//   }

//   _getCities(cid) async {
//     ProfileRepo pr = ProfileRepo();
//     cid ??= EditProfileController.i.selectedcity?.id;
//     EditProfileController.i.updateworklocationcitiesList(
//       await pr.getCities(cid),
//     );
//   }

//   @override
//   void initState() {
//     _getHospital();
//     _getCountries();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           color: ColorManager.kPrimaryColor,
//           onPressed: () {
//             Get.back(result: true);
//           },
//         ),
//         title: Text(
//           'Add WorkLocation',
//           style: GoogleFonts.poppins(
//               fontSize: 17,
//               fontWeight: FontWeight.w600,
//               color: ColorManager.kPrimaryColor),
//         ),
//         centerTitle: true,
//       ),
//       body: GetBuilder<EditProfileController>(
//         builder: (contr) => Padding(
//           padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Row(
//                   children: <Widget>[
//                     Checkbox(
//                       value: edit.newworklocationisChecked,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           edit.newworklocationisChecked = value!;
//                         });
//                       },
//                       checkColor: ColorManager.kWhiteColor,
//                       activeColor: ColorManager.kPrimaryColor,
//                     ),
//                     Text(
//                       'Add New Work Location',
//                       style: GoogleFonts.poppins(
//                           fontSize: 12,
//                           color: ColorManager.kPrimaryColor,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 Visibility(
//                   visible: edit.newworklocationisChecked == false,
//                   child: RegisterCustomTextField(
//                     onTap: () async {
//                       edit.selectedhospital = null;
//                       HospitalORClinics generic = await searchabledropdown(
//                           context, edit.hospitalList ?? []);
//                       edit.selectedhospital = null;
//                       edit.updateselectedhospital(generic);

//                       if (generic != '') {
//                         edit.selectedhospital = generic;
//                         edit.selectedhospital =
//                             (generic == '') ? null : edit.selectedhospital;
//                       }
//                       setState(() {});
//                     },
//                     readonly: true,
//                     suffixIcon: IconButton(
//                         onPressed: () async {
//                           edit.selectedhospital = null;
//                           HospitalORClinics generic = await searchabledropdown(
//                               context, edit.hospitalList ?? []);
//                           edit.selectedhospital = null;
//                           edit.updateselectedhospital(generic);

//                           if (generic != '') {
//                             edit.selectedhospital = generic;
//                             edit.selectedhospital =
//                                 (generic == '') ? null : edit.selectedhospital;
//                           }
//                           setState(() {});
//                         },
//                         icon: Image.asset(Images.dropdown)),
//                     hintText: edit.selectedhospital?.name == ""
//                         ? 'Hospital'.tr
//                         : edit.selectedhospital?.name ?? "Select Hospital",
//                   ),
//                 ),
//                 Visibility(
//                   visible: edit.newworklocationisChecked == false,
//                   child: AuthTextField(
//                     controller: edit.worklocationpreference,
//                     hintText: 'Preference',
//                   ),
//                 ),
//                 Visibility(
//                   visible: edit.newworklocationisChecked == true,
//                   child: AuthTextField(
//                     controller: edit.newworklocationname,
//                     hintText: 'Name',
//                   ),
//                 ),
//                 Visibility(
//                     visible: edit.newworklocationisChecked == true,
//                     child: SizedBox(
//                       height: Get.height * 0.02,
//                     )),
//                 Visibility(
//                   visible: edit.newworklocationisChecked == true,
//                   child: RegisterCustomTextField(
//                     validator: (value) {
//                       if (value == "Country") {
//                         return 'pleaseselectyourcountry'.tr;
//                       }
//                       return null;
//                     },
//                     onTap: () async {
//                       edit.selectedworklocationcountry = null;
//                       edit.selectedworklocationCities = null;
//                       edit.worklocationcitiesList.clear();

//                       edit.selectedworklocationstate = null;
//                       Countries generic = await searchabledropdown(
//                           context, edit.worklocationcountriesList ?? []);
//                       edit.selectedworklocationcountry = null;
//                       edit.updateselectedworklocationcountry(generic);

//                       if (generic != '') {
//                         edit.selectedworklocationcountry = generic;
//                         edit.selectedworklocationcountry = (generic == '')
//                             ? null
//                             : edit.selectedworklocationcountry;
//                       }
//                       String cid =
//                           edit.selectedworklocationcountry?.id.toString() ?? "";
//                       setState(() {
//                         _getProvinces(cid);
//                       });
//                     },
//                     readonly: true,
//                     hintText: edit.selectedworklocationcountry?.name == ""
//                         ? 'country'.tr
//                         : edit.selectedworklocationcountry?.name ??
//                             "Select country",
//                   ),
//                 ),
//                 Visibility(
//                   visible: edit.newworklocationisChecked == true,
//                   child: RegisterCustomTextField(
//                     validator: (value) {
//                       if (value == "Province") {
//                         return 'Please select your State'.tr;
//                       }
//                       return null;
//                     },
//                     readonly: true,
//                     onTap: () async {
//                       edit.selectedworklocationstate = null;
//                       edit.selectedworklocationCities = null;
//                       Provinces generic = await searchabledropdown(
//                           context, edit.worklocationstateList ?? []);
//                       edit.selectedworklocationstate = null;
//                       edit.updateselectedworklocationstate(generic);

//                       if (generic != '') {
//                         edit.selectedworklocationstate = generic;
//                         edit.selectedworklocationstate = (generic == '')
//                             ? null
//                             : edit.selectedworklocationstate;
//                       }
//                       String cid =
//                           edit.selectedworklocationstate?.id.toString() ?? "";
//                       setState(() {
//                         _getCities(cid);
//                       });
//                     },
//                     hintText: edit.selectedworklocationstate?.name == ""
//                         ? 'State'
//                         : edit.selectedworklocationstate?.name == null
//                             ? 'State'
//                             : edit.selectedworklocationstate?.name ?? "",
//                   ),
//                 ),
//                 Visibility(
//                   visible: edit.newworklocationisChecked == true,
//                   child: RegisterCustomTextField(
//                     validator: (value) {
//                       if (value == "City") {
//                         return 'pleaseselectyourcity'.tr;
//                       }
//                       return null;
//                     },
//                     readonly: true,
//                     onTap: () async {
//                       edit.selectedworklocationCities = null;
//                       Cities generic = await searchabledropdown(
//                           context, edit.worklocationcitiesList ?? []);
//                       edit.selectedworklocationCities = null;
//                       edit.updateselectedworklocationCities(generic);

//                       if (generic != '') {
//                         edit.selectedworklocationCities = generic;
//                         edit.selectedworklocationCities = (generic == '')
//                             ? null
//                             : edit.selectedworklocationCities;
//                       }
//                       setState(() {});
//                     },
//                     hintText: edit.selectedworklocationCities?.name == ""
//                         ? 'City'
//                         : edit.selectedworklocationCities?.name == null
//                             ? 'City'
//                             : edit.selectedworklocationCities?.name ?? "",
//                   ),
//                 ),
//                 Visibility(
//                   visible: edit.newworklocationisChecked == true,
//                   child: AuthTextField(
//                     controller: edit.newworklocationnameaddress,
//                     hintText: 'Address',
//                   ),
//                 ),
//                 SizedBox(height: Get.height * 0.03),
//                 PrimaryButton(
//                     fontSize: 15,
//                     title: 'Add'.tr,
//                     onPressed: () async {},
//                     color: ColorManager.kPrimaryColor,
//                     textcolor: ColorManager.kWhiteColor),
//                 SizedBox(height: Get.height * 0.03),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
