import 'dart:async';

import 'package:doctormobileapplication/components/consulting_queue_dropdown.dart';
import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/data/controller/erx_controller.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/medicines.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future<String?> searchableDropdownRadioButton(
    BuildContext context, String selectedoption, List<dynamic> list) async {
  TextEditingController search = TextEditingController();
  String title = "";
  //String selectedValuename = "";
  String selectedvalueid = "";

  Completer<String?> completer = Completer();

  showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            width: Get.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: Get.width * 0.05),
                        Text(
                          'Search',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.raleway(
                            textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.close_outlined,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: ColorManager.kPrimaryColor),
                        hintText: 'Search',
                        filled: true,
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: ColorManager.kPrimaryLightColor),
                            borderRadius: BorderRadius.circular(8)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: ColorManager.kPrimaryLightColor),
                        ),
                        fillColor: ColorManager.kPrimaryLightColor,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: ColorManager.kPrimaryColor,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorManager.kPrimaryLightColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(0.0),
                          ),
                        ),
                      ),
                      controller: search,
                      onChanged: (val) {
                        title = val;
                        setState(() {
                          title = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: Get.height * 0.4,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: ((context, index) {
                          final isChecked = controller.selectedfollowup;
                          if (search.text.isEmpty ||
                              list[index]
                                  .name!
                                  .toLowerCase()
                                  .contains(title.toLowerCase())) {
                            return RadioListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                              title: Text(
                                list[index].name.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                              value: list[index].name.toString(),
                              //value: isChecked,
                              groupValue: selectedvalueid,
                              onChanged: (value) {
                                setState(() {
                                  selectedvalueid = value.toString();
                                });
                              },
                            );
                          } else {
                            return Container();
                          }
                        }),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    PrimaryButton(
                      title: 'Save',
                      fontSize: 12,
                      height: Get.height * 0.07,
                      width: Get.width * 0.5,
                      onPressed: () {
                        Navigator.of(context).pop(selectedvalueid);
                      },
                      color: ColorManager.kPrimaryColor,
                      textcolor: ColorManager.kWhiteColor,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  ).then((value) {
    selectedvalueid = value ?? "";
    completer.complete(selectedvalueid);
  });

  return completer.future;
}

Future<dynamic> searchableDropdownCheckBox(
  BuildContext context,
  List<dynamic> list,
  List<dynamic> selectedItems,
  bool trailingvisibility,
  String listname,
) async {
  TextEditingController search = TextEditingController();
  String title = "";
  Completer<List<dynamic>> completer = Completer<List<dynamic>>();

  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            width: Get.width,
            height: MediaQuery.of(context).size.height * 0.7,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: Get.width * 0.05),
                        Text(
                          'Search',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.raleway(
                            textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.close_outlined,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: ColorManager.kPrimaryColor),
                        hintText: 'Search',
                        filled: true,
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: ColorManager.kPrimaryLightColor),
                            borderRadius: BorderRadius.circular(8)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: ColorManager.kPrimaryLightColor),
                        ),
                        fillColor: ColorManager.kPrimaryLightColor,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: ColorManager.kPrimaryColor,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorManager.kPrimaryLightColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(0.0),
                          ),
                        ),
                      ),
                      controller: search,
                      onChanged: (val) {
                        title = val;
                        setState(() {
                          title = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: Get.height * 0.4,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: ((context, index) {
                          final isChecked = selectedItems.contains(list[index]);
                          if (search.text.isEmpty ||
                              list[index]
                                  .name!
                                  .toLowerCase()
                                  .contains(title.toLowerCase())) {
                            return ListTile(
                              dense: true,
                              minVerticalPadding: 0,
                              contentPadding: EdgeInsets.zero,
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: -4),
                              title: Row(
                                children: [
                                  Checkbox(
                                    visualDensity: const VisualDensity(
                                        horizontal: 0.01, vertical: 0.0),
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (value != null) {
                                          if (value) {
                                            selectedItems.add(list[index]);
                                          } else {
                                            selectedItems.remove(list[index]);
                                          }
                                        }
                                      });
                                    },
                                  ),
                                  if (trailingvisibility == false)
                                    SizedBox(
                                      width: Get.width * 0.42,
                                      child: Text(
                                        list[index].name.toString(),
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  if (trailingvisibility == true)
                                    SizedBox(
                                      width: Get.width * 0.32,
                                      child: Text(
                                        list[index].name.toString(),
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    )
                                ],
                              ),
                              trailing: Visibility(
                                visible: trailingvisibility,
                                child: IconButton(
                                  onPressed: () {
                                    addComment(
                                        context, list[index].id, listname);
                                  },
                                  icon: const Icon(Icons.add_box_outlined),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    PrimaryButton(
                      title: 'Save',
                      fontSize: 12,
                      height: Get.height * 0.07,
                      width: Get.width * 0.5,
                      onPressed: () {
                        Get.back();
                        completer.complete(selectedItems);

                        // Navigator.of(context).pop(selectedItems);
                      },
                      color: ColorManager.kPrimaryColor,
                      textcolor: ColorManager.kWhiteColor,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
  //return selectedItems;
  return completer.future;
}

final controller = Get.put(ERXController());
final cmt = TextEditingController();
// DELETE
deleteSelectedRadio(
  BuildContext context,
) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return GetBuilder<ERXController>(
        builder: (cont) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: Get.width * 0.05),
                      Text(
                        'Delete',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                          textStyle: GoogleFonts.poppins(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.close_outlined,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Text(
                    'Do you want to delete it?',
                    style: GoogleFonts.raleway(
                      textStyle: GoogleFonts.poppins(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  PrimaryButton(
                    title: 'Yes',
                    fontSize: 14,
                    height: Get.height * 0.06,
                    width: Get.width * 0.5,
                    onPressed: () {
                      controller.deleteSelectedfollowup();
                      Get.back();
                    },
                    color: ColorManager.kPrimaryColor,
                    textcolor: ColorManager.kWhiteColor,
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

// DELETE
deleteSelected(
  BuildContext context,
  List<dynamic> selectedItems,
  String id,
  String name,
) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: Get.width * 0.05),
                    Text(
                      'Delete',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(
                        textStyle: GoogleFonts.poppins(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close_outlined,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  'Do you want to delete it?',
                  style: GoogleFonts.raleway(
                    textStyle: GoogleFonts.poppins(
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                PrimaryButton(
                  title: 'Yes',
                  fontSize: 14,
                  height: Get.height * 0.06,
                  width: Get.width * 0.5,
                  onPressed: () {
                    if (name == 'complaints') {
                      controller.deleteSelectedComplaintsList(id);
                    } else if (name == 'pd') {
                      controller.deleteselectedprimarydiagnosisList(id);
                    } else if (name == 'sd') {
                      controller.deleteselectedsecondaryDiagnosisList(id);
                    } else if (name == 'diagnostics') {
                      controller.deleteSelecteddiagnosticsList(id);
                    } else if (name == 'Investigations') {
                      controller.deleteselectedInvestigationList(id);
                    } else if (name == 'procedures') {
                      controller.deleteSelectedProceduresList(id);
                    } else if (name == 'followup') {
                      controller.deleteSelectedfollowup();
                    } else if (name == 'instructions') {
                      controller.deleteSelectedinstructionList(id);
                    } else if (name == 'medicines') {
                      controller.deleteSelectedmedicineList(id);
                    } else if (name == 'complaint') {
                      controller.deleteComplaintList(id);
                    } else if (name == 'finding') {
                      controller.deleteFindingList(id);
                    }

                    Get.back();
                  },
                  color: ColorManager.kPrimaryColor,
                  textcolor: ColorManager.kWhiteColor,
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

// ADD COMMENT
addComment(BuildContext context, String id, String listname) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: Get.width * 0.05),
                    Text(
                      'Comment',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(
                        textStyle: GoogleFonts.poppins(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close_outlined,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  'Add Comments',
                  style: GoogleFonts.raleway(
                    textStyle: GoogleFonts.poppins(
                      fontSize: 12,
                    ),
                  ),
                ),

                SizedBox(
                  height: Get.height * 0.03,
                ),

                // Textfield
                TextField(
                  controller: controller.trailingtextController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                      ),
                    ),
                    hintText: 'Type your comment here',
                  ),
                ),

                SizedBox(
                  height: Get.height * 0.04,
                ),
                PrimaryButton(
                  title: 'Save',
                  fontSize: 14,
                  height: Get.height * 0.06,
                  width: Get.width * 0.5,
                  onPressed: () {
                    //  print(object)
                    if (listname == "primary") {
                      controller.updateprimarycomments(
                          id, controller.trailingtextController.text);
                      Get.back();
                    }

                    if (listname == "secondary") {
                      controller.updatesecondartcomments(
                          id, controller.trailingtextController.text);
                      Get.back();
                    }
                  },
                  color: ColorManager.kPrimaryColor,
                  textcolor: ColorManager.kWhiteColor,
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

addMedicine(
  BuildContext context,
  List<dynamic> medicinelist,
  List<dynamic> selectedMedicineList,
  String selectedMedicine,
) async {
  String medtitle = "";
  TextEditingController medController = TextEditingController();
  Completer<dynamic> completer = Completer<dynamic>();
  controller.medicineList.sort((a, b) => a.name!.compareTo(b.name!));

  String selectedgroup = 'Select';
  List<String> groupList = [
    'Select',
    'Med 1',
  ];
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: Get.width * 0.05),
                      Text(
                        'Search',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                          textStyle: GoogleFonts.poppins(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.close_outlined,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Text(
                    'Group',
                    style: GoogleFonts.raleway(
                      textStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ConsultingQueueDropDownWidget(
                    list: groupList,
                    selected: selectedgroup,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      hintStyle: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: ColorManager.kPrimaryColor),
                      hintText: 'Search',
                      filled: true,
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: ColorManager.kPrimaryLightColor),
                          borderRadius: BorderRadius.circular(8)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: ColorManager.kPrimaryLightColor),
                      ),
                      fillColor: ColorManager.kPrimaryLightColor,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: ColorManager.kPrimaryColor,
                      ),
                      border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: ColorManager.kPrimaryLightColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(0.0),
                        ),
                      ),
                    ),
                    controller: medController,
                    onChanged: (val) {
                      medtitle = val;
                      setState(() {
                        medtitle = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: Get.height * 0.009,
                  ),
                  Text(
                    'Select Medicines',
                    style: GoogleFonts.raleway(
                      textStyle: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GetBuilder<ERXController>(builder: (context) {
                    return SizedBox(
                      height: Get.height * 0.15,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.medicineList.length,
                        itemBuilder: (context, index) {
                          if (medController.text.isEmpty ||
                              controller.medicineList[index].name!
                                  .toLowerCase()
                                  .contains(medtitle.toLowerCase())) {
                            final medicine = controller.medicineList[index];
                            final isSelected = controller.selectedmedicineList
                                .contains(medicine);
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    controller.selectedmedicineList.clear();
                                    selectedMedicine = "";
                                  } else {
                                    controller.selectedmedicineList.clear();
                                    controller.selectedmedicineList
                                        .add(medicine);
                                    selectedMedicine = medicine.name ?? "";
                                  }
                                });
                              },
                              child: Container(
                                color: isSelected
                                    ? ColorManager.kPrimaryColor
                                    : ColorManager.kWhiteColor,
                                child: Text(
                                  medicine.name ?? "",
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    );
                  }),
                  SizedBox(
                    height: Get.height * 0.009,
                  ),
                  Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '  Routes',
                            style: GoogleFonts.raleway(
                              textStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: Get.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: ColorManager.kGreyColor,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'external use',
                                style: TextStyle(
                                  color: ColorManager.kPrimaryColor,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.009,
                          ),
                          Text(
                            '  Duration',
                            style: GoogleFonts.raleway(
                              textStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: Get.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: ColorManager.kGreyColor,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                '11 weeks',
                                style: TextStyle(
                                  color: ColorManager.kPrimaryColor,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.009,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '  Frequency',
                            style: GoogleFonts.raleway(
                              textStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: Get.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: ColorManager.kGreyColor,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                '1',
                                style: TextStyle(
                                  color: ColorManager.kPrimaryColor,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.009,
                          ),
                          Text(
                            '  Dosage',
                            style: GoogleFonts.raleway(
                              textStyle: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: Get.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: ColorManager.kGreyColor,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Q.M',
                                style: TextStyle(
                                  color: ColorManager.kPrimaryColor,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  SizedBox(height: Get.height * 0.04),
                  Center(
                    child: PrimaryButton(
                      title: 'Save',
                      fontSize: 14,
                      height: Get.height * 0.06,
                      width: Get.width * 0.5,
                      onPressed: () {
                        Get.back();
                        completer.complete(selectedMedicine);
                      },
                      color: ColorManager.kPrimaryColor,
                      textcolor: ColorManager.kWhiteColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
  return completer.future;
}

// 4 alert dialog to select for each medicine
medicineRowitems(
  BuildContext context,
) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: Get.width * 0.05),
                      Text(
                        'Search',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                          textStyle: GoogleFonts.poppins(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.close_outlined,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

// DELETE
deleteSelectedMedicine(
  BuildContext context,
  Medicines1 medicineobject,
) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: Get.width * 0.05),
                    Text(
                      'Delete',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(
                        textStyle: GoogleFonts.poppins(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close_outlined,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  medicineobject.name ?? "",
                  style: GoogleFonts.raleway(
                    textStyle: GoogleFonts.poppins(
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Row(children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '  Routes',
                          style: GoogleFonts.raleway(
                            textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: Get.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: ColorManager.kGreyColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              medicineobject.route!,
                              style: const TextStyle(
                                color: ColorManager.kPrimaryColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.009,
                        ),
                        Text(
                          '  Duration',
                          style: GoogleFonts.raleway(
                            textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: Get.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: ColorManager.kGreyColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              medicineobject.possibleDurations!,
                              style: const TextStyle(
                                color: ColorManager.kPrimaryColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.009,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '  Frequency',
                          style: GoogleFonts.raleway(
                            textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: Get.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: ColorManager.kGreyColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              medicineobject.frequency!,
                              style: const TextStyle(
                                color: ColorManager.kPrimaryColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.009,
                        ),
                        Text(
                          '  Dosage',
                          style: GoogleFonts.raleway(
                            textStyle: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: Get.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: ColorManager.kGreyColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              medicineobject.dosage!,
                              style: const TextStyle(
                                color: ColorManager.kPrimaryColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PrimaryButton(
                      title: 'Delete',
                      fontSize: 14,
                      height: Get.height * 0.06,
                      width: Get.width * 0.5,
                      onPressed: () {
                        // controller.deleteSelectedfollowup();
                        Get.back();
                      },
                      color: ColorManager.kPrimaryColor,
                      textcolor: ColorManager.kWhiteColor,
                    ),
                    PrimaryButton(
                      title: 'Save',
                      fontSize: 14,
                      height: Get.height * 0.06,
                      width: Get.width * 0.5,
                      onPressed: () {
                        // controller.deleteSelectedfollowup();
                        Get.back();
                      },
                      color: ColorManager.kPrimaryColor,
                      textcolor: ColorManager.kWhiteColor,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
