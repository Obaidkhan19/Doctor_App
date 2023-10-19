// import 'package:doctormobileapplication/components/CustomFormField.dart';
// import 'package:doctormobileapplication/components/custom_textfield.dart';
// import 'package:doctormobileapplication/helpers/color_manager.dart';
// import 'package:doctormobileapplication/screens/appointment_configuration/dropdown_alert.dart';
// import 'package:doctormobileapplication/utils/AppImages.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// class PastConsultation extends StatefulWidget {
//   const PastConsultation({super.key});

//   @override
//   State<PastConsultation> createState() => _PastConsultationState();
// }

// class _PastConsultationState extends State<PastConsultation> {
//   TextEditingController searchController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: InkWell(
//           splashColor: Colors.transparent,
//           highlightColor: Colors.transparent,
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Image.asset(
//             AppImages.back,
//           ),
//         ),
//         title: Text(
//           'Past Consultations',
//           textAlign: TextAlign.center,
//           style: GoogleFonts.raleway(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             height: 1.175,
//             color: ColorManager.kblackColor,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage(AppImages.background_image),
//                 alignment: Alignment.centerLeft),
//           ),
//           child: Padding(
//             padding: EdgeInsets.only(
//                 left: Get.width * 0.03, right: Get.width * 0.03),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.05,
//                   child: Row(
//                     children: [
//                       SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.75,
//                           child: TextInputField(
//                               controller: searchController,
//                               labelText: "Search",
//                               icon: Icons.search,
//                               color: ColorManager.kPrimaryColor,
//                               radius: 30)),
//                       SizedBox(
//                         width: Get.width * 0.03,
//                       ),
//                       InkWell(
//                         onTap: () {},
//                         child: Container(
//                             width: MediaQuery.of(context).size.width * 0.12,
//                             height: MediaQuery.of(context).size.height * 0.055,
//                             decoration: BoxDecoration(
//                               color: const Color(0xfff1272d3),
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                             child: Center(
//                               child:
//                                   //      Icon(
//                                   //   Icons.search,
//                                   //   color: ColorManager.kWhiteColor,
//                                   //   size: MediaQuery.of(context).size.height * 0.035,
//                                   // ),
//                                   InkWell(
//                                 onTap: () {
//                                   _showAlertDialog(context);
//                                 },
//                                 child: SizedBox(
//                                   height: Get.height * 0.035,
//                                   child: Image.asset(
//                                     AppImages.filter_logo,
//                                     color: ColorManager.kWhiteColor,
//                                   ),
//                                 ),
//                               ),
//                             )),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _showAlertDialog(BuildContext context) {
//     final dateFormatalert = DateFormat('yyyy-MM-dd');
//     DateTime dateTimealert = DateTime.now().subtract(const Duration(days: 30));
//     DateTime dateTime2alert = DateTime.now();
//     bool isOnline1 = false;
//     String barnchselectedoption = '';
//     List<String> branchList = [
//       'A',
//       'B',
//       'C',
//       'D',
//       'E',
//       'F',
//       'G',
//       'H',
//       'I',
//     ];

//     String hospitalselectedoption = '';
//     List<String> hospitalList = [
//       'Hospital 1',
//       'Hospital 2',
//       'Hospital 3',
//     ];

//     // Create a simple alert dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Padding(
//           padding:
//               EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
//           child: StatefulBuilder(builder: (context, setState) {
//             return AlertDialog(
//               insetPadding: EdgeInsets.zero,
//               content: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Center(
//                           child: Text(
//                             "Search Consultancy",
//                             style: GoogleFonts.poppins(
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                               color: ColorManager.kPrimaryColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           Get.back();
//                         },
//                         icon: const Icon(Icons.cancel_outlined),
//                         iconSize: 25,
//                         color: ColorManager.kblackColor,
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.05,
//                   ),
//                   Row(
//                     children: [
//                       SizedBox(
//                           width: MediaQuery.of(context).size.width / 2.78,
//                           child: Align(
//                             alignment: Alignment.topLeft,
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: Get.width * 0.03,
//                               ),
//                               child: CupertinoTextField(
//                                 readOnly: true,
//                                 controller: TextEditingController(
//                                   text: dateFormatalert.format(dateTimealert),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: ColorManager.kPrimaryColor,
//                                     width: 1.0,
//                                   ),
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: CupertinoColors.white,
//                                 ),
//                                 prefix: const Icon(
//                                   Icons.calendar_month,
//                                   color: CupertinoColors.black,
//                                 ),
//                                 style: const TextStyle(
//                                   fontSize: 10,
//                                   color: CupertinoColors.black,
//                                 ),
//                                 onTap: () {
//                                   showCupertinoModalPopup(
//                                     context: context,
//                                     builder: (BuildContext context) => Center(
//                                       child: SizedBox(
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.3,
//                                         child: CupertinoDatePicker(
//                                           backgroundColor: Colors.white,
//                                           initialDateTime: dateTimealert,
//                                           onDateTimeChanged:
//                                               (DateTime newTime) {
//                                             setState(
//                                                 () => dateTimealert = newTime);
//                                           },
//                                           use24hFormat: true,
//                                           mode: CupertinoDatePickerMode.date,
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           )),
//                       Text(
//                         'To',
//                         style: GoogleFonts.poppins(
//                             fontSize: 10, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width / 2.78,
//                         child: Align(
//                           alignment: Alignment.topLeft,
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: Get.width * 0.03,
//                             ),
//                             child: CupertinoTextField(
//                               readOnly: true,
//                               controller: TextEditingController(
//                                 text: dateFormatalert.format(dateTime2alert),
//                               ),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: ColorManager.kPrimaryColor,
//                                   width: 1.0,
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: CupertinoColors.white,
//                               ),
//                               prefix: const Icon(
//                                 Icons
//                                     .calendar_month, // You can replace this with your desired icon
//                                 color: CupertinoColors.black,
//                               ),
//                               style: const TextStyle(
//                                 fontSize: 10,
//                                 color: CupertinoColors.black,
//                               ),
//                               onTap: () {
//                                 showCupertinoModalPopup(
//                                   context: context,
//                                   builder: (BuildContext context) => Center(
//                                     child: SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.3,
//                                       child: CupertinoDatePicker(
//                                         backgroundColor: Colors.white,
//                                         initialDateTime: dateTime2alert,
//                                         onDateTimeChanged: (DateTime newTime) {
//                                           setState(
//                                               () => dateTime2alert = newTime);
//                                         },
//                                         use24hFormat: true,
//                                         mode: CupertinoDatePickerMode.date,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   // ONLINE
//                   SizedBox(
//                     height: Get.height * 0.02,
//                   ),
//                   Row(
//                     children: [
//                       Checkbox(
//                         // value: controller.isOnline,
//                         value: isOnline1,
//                         activeColor: ColorManager.kPrimaryColor,
//                         onChanged: (value) {
//                           setState(() {
//                             isOnline1 = value!;
//                           });
//                         },
//                       ),
//                       Text(
//                         '   Online',
//                         style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             color: ColorManager.kGreyColor,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.01,
//                   ),
//                   Text(
//                     '   Branch',
//                     style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       color: ColorManager.kblackColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   CustomAlertDropDownWidget(
//                     list: branchList,
//                     selected: barnchselectedoption,
//                     hinttext: 'Select',
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.01,
//                   ),
//                   Text(
//                     '   Hospital/Clinic',
//                     style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       color: ColorManager.kblackColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   CustomAlertDropDownWidget(
//                     list: hospitalList,
//                     selected: hospitalselectedoption,
//                     hinttext: 'Select',
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.01,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: ColorManager.kPrimaryColor,
//                       fixedSize: const Size(380, 4),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(
//                             10), // Set the border radius here
//                       ),
//                     ),
//                     child: Text(
//                       'Search Consultancy',
//                       style: GoogleFonts.poppins(
//                           fontSize: 12, color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }),
//         );
//       },
//     );
//   }
// }
