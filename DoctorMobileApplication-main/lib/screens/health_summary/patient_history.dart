import 'package:doctormobileapplication/components/images.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/screens/family_screens/family_members.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientHistory extends StatefulWidget {
  const PatientHistory({super.key});

  @override
  State<PatientHistory> createState() => _PatientHistoryState();
}

class _PatientHistoryState extends State<PatientHistory> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          title: 'Patient History',
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintStyle: const TextStyle(
                    color: ColorManager.kPrimaryColor, fontSize: 10),
                hintText: 'Enter MRN:',
                filled: true,
                disabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: ColorManager.kPrimaryLightColor),
                    borderRadius: BorderRadius.circular(8)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: ColorManager.kPrimaryLightColor),
                ),
                fillColor: ColorManager.kPrimaryLightColor,
                prefixIcon: const Icon(
                  Icons.search,
                  color: ColorManager.kPrimaryColor,
                  size: 25,
                ),
                border: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorManager.kPrimaryLightColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(0.0),
                  ),
                ),
              ),
              controller: searchController,
              onChanged: (val) {},
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 4,
                    surfaceTintColor: ColorManager.kWhiteColor,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                image: DecorationImage(
                                  image: AssetImage(Images.profile),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: Get.width * 0.03),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Abu Yousuf',
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: ColorManager.kPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'MRN: ',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: ColorManager.kblackColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'A24589',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: ColorManager.kblackColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
