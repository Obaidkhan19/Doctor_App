// import 'package:doctormobileapplication/components/custom_textfields.dart';
// import 'package:doctormobileapplication/components/images.dart';
// import 'package:doctormobileapplication/components/primary_button.dart';
// import 'package:doctormobileapplication/components/searchable_dropdown.dart';
// import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
// import 'package:doctormobileapplication/data/repositories/auth_repository/profile_repo.dart';
// import 'package:doctormobileapplication/helpers/color_manager.dart';
// import 'package:doctormobileapplication/models/degree.dart';
// import 'package:doctormobileapplication/screens/auth_screens/login.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// class AddExperience extends StatefulWidget {
//   const AddExperience({super.key});

//   @override
//   State<AddExperience> createState() => _AddExperienceState();
// }

// class _AddExperienceState extends State<AddExperience> {
//   var edit = Get.put<EditProfileController>(EditProfileController());

//   _getLocations() async {
//     ProfileRepo pr = ProfileRepo();
//     EditProfileController.i.updatelocationList(
//       await pr.getLocations(),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getLocations();
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
//           'Add Experience',
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
//                 AuthTextField(
//                   controller: edit.jobtitle,
//                   hintText: 'Job Title',
//                 ),
//                 SizedBox(
//                   height: Get.height * 0.02,
//                 ),
//                 RegisterCustomTextField(
//                   onTap: () async {
//                     Degrees generic = await searchabledropdown(
//                         context, edit.locationList ?? []);
//                     edit.selectedlocation = null;
//                     edit.updateselectedlocation(generic);

//                     if (generic != '') {
//                       edit.selectedlocation = generic;
//                       edit.selectedlocation =
//                           (generic == '') ? null : edit.selectedlocation;
//                     }
//                   },
//                   readonly: true,
//                   suffixIcon: IconButton(
//                       onPressed: () async {
//                         Degrees generic = await searchabledropdown(
//                             context, edit.locationList ?? []);
//                         edit.selectedlocation = null;
//                         edit.updateselectedlocation(generic);

//                         if (generic != '') {
//                           edit.selectedlocation = generic;
//                           edit.selectedlocation =
//                               (generic == '') ? null : edit.selectedlocation;
//                         }
//                       },
//                       icon: Image.asset(Images.dropdown)),
//                   hintText: edit.selectedlocation?.name == ""
//                       ? 'Location'.tr
//                       : edit.selectedlocation?.name ?? "Select Location",
//                 ),
//                 RegisterCustomTextField(
//                   onTap: () async {
//                     await edit.selectexperiencefromDateAndTime(
//                         context,
//                         EditProfileController.experiencefrom,
//                         edit.formateexperiencefrom);
//                   },
//                   readonly: true,
//                   hintText:
//                       edit.formattedexperiencefrom.toString().split("T")[0] ==
//                               DateTime.now().toString().split(" ")[0]
//                           ? "Select From Date"
//                           : DateFormat('MM-dd-y').format(DateTime.parse(edit
//                               .formattedexperiencefrom
//                               .toString()
//                               .split(" ")[0])),
//                 ),
//                 Row(
//                   children: <Widget>[
//                     Checkbox(
//                       value: edit.currentlyworkingisChecked,
//                       onChanged: (bool? value) {
//                         setState(() {
//                           edit.currentlyworkingisChecked = value!;
//                         });
//                       },
//                       checkColor: ColorManager.kWhiteColor,
//                       activeColor: ColorManager.kPrimaryColor,
//                     ),
//                     Text(
//                       'Currently Working',
//                       style: GoogleFonts.poppins(
//                           fontSize: 12,
//                           color: ColorManager.kPrimaryColor,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 Visibility(
//                   visible: edit.currentlyworkingisChecked == false,
//                   child: RegisterCustomTextField(
//                     onTap: () async {
//                       await edit.selectexperiencetoDateAndTime(
//                           context,
//                           EditProfileController.experienceto,
//                           edit.formateexperienceto);
//                     },
//                     readonly: true,
//                     hintText:
//                         edit.formattedexperienceto.toString().split("T")[0] ==
//                                 DateTime.now().toString().split(" ")[0]
//                             ? "Select To Date"
//                             : DateFormat('MM-dd-y').format(DateTime.parse(edit
//                                 .formattedexperienceto
//                                 .toString()
//                                 .split(" ")[0])),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     edit.picksingleexperiencefile();
//                   },
//                   child: Container(
//                     width: Get.width * 1, // Adjust the width as needed
//                     height: Get.height * 0.07,
//                     decoration: BoxDecoration(
//                       color: ColorManager.kPrimaryColor,
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: Center(
//                       child: Text(
//                         'Attachment',
//                         style: GoogleFonts.poppins(
//                           color: ColorManager.kWhiteColor,
//                           fontSize: 15,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: Get.height * 0.02,
//                 ),
//                 AuthTextField(
//                   controller: edit.experienceDescription,
//                   hintText: 'Description',
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
