import 'dart:async';

import 'package:doctormobileapplication/components/primary_button.dart';
import 'package:doctormobileapplication/data/controller/erx_controller.dart';
import 'package:doctormobileapplication/data/repositories/Consulting_Queue_repo/perscribe_medicine_repo.dart';
import 'package:doctormobileapplication/helpers/color_manager.dart';
import 'package:doctormobileapplication/models/medicincematrix.dart';
import 'package:doctormobileapplication/models/medicines.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    barrierDismissible: true,
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
                          style: GoogleFonts.poppins(
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
                        hintStyle: GoogleFonts.poppins(
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
                          //    final isChecked = controller.selectedfollowup;
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
                                style: GoogleFonts.poppins(fontSize: 10),
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
  List<dynamic> checkboxselectedItems,
  bool trailingvisibility,
  String listname,
) async {
  TextEditingController search = TextEditingController();
  String title = "";
  Completer<List<dynamic>> completer = Completer<List<dynamic>>();
  List dataList = checkboxselectedItems;

  // add checkbox list in datelist
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(builder:
          (BuildContext context, void Function(void Function()) setState) {
        return GetBuilder<ERXController>(
          builder: (contx) => StatefulBuilder(
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
                        SizedBox(
                          height: Get.height * 0.07,
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              hintStyle: GoogleFonts.poppins(
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
                            onFieldSubmitted: (value) async {
                              PrescribeMedicinRepo pmr = PrescribeMedicinRepo();
                              if (listname == 'complaints') {
                                controller.updatecomplaintdata(
                                  await pmr.getComplaints(search.text),
                                );
                                list = controller.complaintsList;
                                checkboxselectedItems =
                                    controller.checkboxselectedcomplaintssList;
                                setState(() {});
                              } else if (listname == "primary") {
                                controller.updatePrimarydiagnosislist(
                                  await pmr.getPrimaryDiagnosis(search.text),
                                );
                                list = controller.primarydiagnosisList;
                                checkboxselectedItems = controller
                                    .checkboxselectedprimarydiagnosisList;
                                setState(() {});
                              } else if (listname == "secondary") {
                                controller.updateSecondarydiagnosislist(
                                  await pmr.getSecondaryDiagnosis(search.text),
                                );
                                list = controller.secondaryDiagnosisList;
                                checkboxselectedItems = controller
                                    .checkboxselectedsecondarydiagnosisList;
                                setState(() {});
                              } else if (listname == "diagnostics") {
                                controller.updatediagnosticslist(
                                  await pmr.getDiagnostics(search.text),
                                );
                                list = controller.diagnosticsList;
                                checkboxselectedItems =
                                    controller.checkboxselectediagnosticsList;
                                setState(() {});
                              } else if (listname == "investigation") {
                                controller.updateInvestigationlist(
                                  await pmr.getInvestigations(search.text),
                                );
                                list = controller.investigationList;
                                checkboxselectedItems = controller
                                    .checkboxselectedinvestigationList;
                                setState(() {});
                              } else if (listname == "procedures") {
                                controller.updateProcedureslist(
                                  await pmr.getProcedures(search.text),
                                );
                                list = controller.proceduresList;
                                checkboxselectedItems =
                                    controller.checkboxselectedproceduresList;
                                setState(() {});
                              } else if (listname == "instruction") {
                                controller.updateInstructionlist(
                                  await pmr.getInstruction(search.text),
                                );
                                list = controller.instructionList;
                                checkboxselectedItems =
                                    controller.checkboxselectedinstructionList;
                                setState(() {});
                              }
                            },
                            onChanged: (val) async {
                              int length = search.text.length;
                              PrescribeMedicinRepo pmr = PrescribeMedicinRepo();
                              if (length == 0) {
                                if (listname == 'complaints') {
                                  controller.updatecomplaintdata(
                                    await pmr.getComplaints(""),
                                  );
                                  list = controller.complaintsList;
                                  checkboxselectedItems = controller
                                      .checkboxselectedcomplaintssList;
                                  setState(() {});
                                } else if (listname == "primary") {
                                  controller.updatePrimarydiagnosislist(
                                    await pmr.getPrimaryDiagnosis(""),
                                  );
                                  list = controller.primarydiagnosisList;
                                  checkboxselectedItems = controller
                                      .checkboxselectedprimarydiagnosisList;
                                  setState(() {});
                                } else if (listname == "secondary") {
                                  controller.updateSecondarydiagnosislist(
                                    await pmr.getSecondaryDiagnosis(""),
                                  );
                                  list = controller.secondaryDiagnosisList;
                                  checkboxselectedItems = controller
                                      .checkboxselectedsecondarydiagnosisList;
                                  setState(() {});
                                } else if (listname == "diagnostics") {
                                  controller.updatediagnosticslist(
                                    await pmr.getDiagnostics(""),
                                  );
                                  list = controller.diagnosticsList;
                                  checkboxselectedItems =
                                      controller.checkboxselectediagnosticsList;
                                  setState(() {});
                                } else if (listname == "investigation") {
                                  controller.updateInvestigationlist(
                                    await pmr.getInvestigations(""),
                                  );
                                  list = controller.investigationList;
                                  checkboxselectedItems = controller
                                      .checkboxselectedinvestigationList;
                                  setState(() {});
                                } else if (listname == "procedures") {
                                  controller.updateProcedureslist(
                                    await pmr.getProcedures(""),
                                  );
                                  list = controller.proceduresList;
                                  checkboxselectedItems =
                                      controller.checkboxselectedproceduresList;
                                  setState(() {});
                                } else if (listname == "instruction") {
                                  controller.updateInstructionlist(
                                    await pmr.getInstruction(""),
                                  );
                                  list = controller.instructionList;
                                  checkboxselectedItems = controller
                                      .checkboxselectedinstructionList;
                                  setState(() {});
                                }
                              }
                            },
                            // onChanged: (val) {
                            //   title = val;
                            //   setState(() {
                            //     title = val;
                            //   });
                            // },
                          ),
                        ),
                        if (list.isNotEmpty)
                          SizedBox(
                            height: Get.height * 0.4,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: ((context, index) {
                                bool isSelected = dataList.any((selectedItem) =>
                                    selectedItem.id == list[index].id);

                                // if (search.text.isEmpty ||
                                //     list[index]
                                //         .name!
                                //         .toLowerCase()
                                //         .contains(title.toLowerCase())) {
                                return ListTile(
                                  dense: true,
                                  minVerticalPadding: 0,
                                  contentPadding: EdgeInsets.zero,
                                  visualDensity: const VisualDensity(
                                      horizontal: 0, vertical: -4),
                                  title: Row(
                                    children: [
                                      Checkbox(
                                        activeColor: ColorManager.kPrimaryColor,
                                        visualDensity: const VisualDensity(
                                            horizontal: 0.01, vertical: 0.0),
                                        value: isSelected,
                                        onChanged: (bool? value) {
                                          ERXController
                                              .i.selectedComplaintsList;

                                          if (value != null) {
                                            if (value) {
                                              dataList.add(list[index]);
                                              // if user remove and then add item again so remove that id from delete list
                                              if (ERXController.i.deletedidlist
                                                  .contains(list[index].id)) {
                                                ERXController.i.deletedidlist
                                                    .remove(list[index].id);
                                              }
                                            } else {
                                              // find the index of item to remove
                                              int indexOfItemToRemove =
                                                  dataList.indexWhere(
                                                (selectedItem) =>
                                                    selectedItem.id ==
                                                    list[index].id,
                                              );
                                              ERXController.i.deletedidlist
                                                  .add(list[index].id);
                                              if (indexOfItemToRemove != -1) {
                                                dataList.removeAt(
                                                    indexOfItemToRemove);
                                              }
                                            }
                                          }
                                          ERXController
                                              .i.selectedComplaintsList;

                                          setState(() {});
                                        },
                                      ),
                                      if (trailingvisibility == false)
                                        SizedBox(
                                          width: Get.width * 0.42,
                                          child: Text(
                                            list[index].name.toString(),
                                            style: GoogleFonts.poppins(
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
                                            style: GoogleFonts.poppins(
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
                                            context,
                                            list[index].id ?? "",
                                            list[index].comments ?? "",
                                            listname);
                                      },
                                      icon: const Icon(Icons.add_box_outlined),
                                    ),
                                  ),
                                );
                                // }
                                //  else {
                                //   return Container();
                                // }
                              }),
                            ),
                          ),
                        if (list.isEmpty)
                          Center(child: Text('NoRecordFound'.tr)),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        PrimaryButton(
                          title: 'Save',
                          fontSize: 12,
                          height: Get.height * 0.05,
                          width: Get.width * 0.55,
                          onPressed: () async {
                            if (listname == "primary") {
                              for (int i = 0;
                                  i < ERXController.i.deletedidlist.length;
                                  i++) {
                                ERXController.i
                                    .deleteselectedprimarydiagnosisList(
                                        ERXController.i.deletedidlist[i]);
                              }
                            }

                            if (listname == "secondary") {
                              for (int i = 0;
                                  i < ERXController.i.deletedidlist.length;
                                  i++) {
                                ERXController.i
                                    .deleteselectedsecondaryDiagnosisList(
                                        ERXController.i.deletedidlist[i]);
                              }
                            }

                            if (listname == "complaints") {
                              for (int i = 0;
                                  i < ERXController.i.deletedidlist.length;
                                  i++) {
                                ERXController.i.deleteSelectedComplaintsList(
                                    ERXController.i.deletedidlist[i]);
                              }
                            }

                            if (listname == "diagnostics") {
                              for (int i = 0;
                                  i < ERXController.i.deletedidlist.length;
                                  i++) {
                                ERXController.i.deleteSelecteddiagnosticsList(
                                    ERXController.i.deletedidlist[i]);
                              }
                            }

                            if (listname == "investigation") {
                              for (int i = 0;
                                  i < ERXController.i.deletedidlist.length;
                                  i++) {
                                ERXController.i.deleteselectedInvestigationList(
                                    ERXController.i.deletedidlist[i]);
                              }
                            }
                            if (listname == "procedures") {
                              for (int i = 0;
                                  i < ERXController.i.deletedidlist.length;
                                  i++) {
                                ERXController.i.deleteSelectedProceduresList(
                                    ERXController.i.deletedidlist[i]);
                              }
                            }

                            if (listname == "instruction") {
                              for (int i = 0;
                                  i < ERXController.i.deletedidlist.length;
                                  i++) {
                                ERXController.i.deleteSelectedinstructionList(
                                    ERXController.i.deletedidlist[i]);
                              }
                            }

                            completer.complete(dataList);
                            Get.back();
                            ERXController.i.deletedidlist.clear();

                            //

                            PrescribeMedicinRepo pmr = PrescribeMedicinRepo();

                            if (listname == 'complaints') {
                              controller.updatecomplaintdata(
                                await pmr.getComplaints(""),
                              );
                              list = controller.complaintsList;
                              checkboxselectedItems =
                                  controller.checkboxselectedcomplaintssList;
                              setState(() {});
                            } else if (listname == "primary") {
                              controller.updatePrimarydiagnosislist(
                                await pmr.getPrimaryDiagnosis(""),
                              );
                              list = controller.primarydiagnosisList;
                              checkboxselectedItems = controller
                                  .checkboxselectedprimarydiagnosisList;
                              setState(() {});
                            } else if (listname == "secondary") {
                              controller.updateSecondarydiagnosislist(
                                await pmr.getSecondaryDiagnosis(""),
                              );
                              list = controller.secondaryDiagnosisList;
                              checkboxselectedItems = controller
                                  .checkboxselectedsecondarydiagnosisList;
                              setState(() {});
                            } else if (listname == "diagnostics") {
                              controller.updatediagnosticslist(
                                await pmr.getDiagnostics(""),
                              );
                              list = controller.diagnosticsList;
                              checkboxselectedItems =
                                  controller.checkboxselectediagnosticsList;
                              setState(() {});
                            } else if (listname == "investigation") {
                              controller.updateInvestigationlist(
                                await pmr.getInvestigations(""),
                              );
                              list = controller.investigationList;
                              checkboxselectedItems =
                                  controller.checkboxselectedinvestigationList;
                              setState(() {});
                            } else if (listname == "procedures") {
                              controller.updateProcedureslist(
                                await pmr.getProcedures(""),
                              );
                              list = controller.proceduresList;
                              checkboxselectedItems =
                                  controller.checkboxselectedproceduresList;
                              setState(() {});
                            } else if (listname == "instruction") {
                              controller.updateInstructionlist(
                                await pmr.getInstruction(""),
                              );
                              list = controller.instructionList;
                              checkboxselectedItems =
                                  controller.checkboxselectedinstructionList;
                              setState(() {});
                            }
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
          ),
        );
      });
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
                        style: GoogleFonts.poppins(
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
                    style: GoogleFonts.poppins(
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
                      //    controller.deleteSelectedfollowup();
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
                      'delete'.tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
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
                  'doyouwanttodeleteit'.tr,
                  style: GoogleFonts.poppins(
                    textStyle: GoogleFonts.poppins(
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                PrimaryButton(
                  title: 'yes'.tr,
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
                      controller.deletefollowup();
                    } else if (name == 'instructions') {
                      controller.deleteSelectedinstructionList(id);
                    } else if (name == 'medicines') {
                      controller.deleteSelectedmedicineList(id);
                    } else if (name == 'complaint') {
                      controller.deleteComplaintList(id);
                    } else if (name == 'finding') {
                      controller.deleteFindingList(id);
                    } else if (name == 'complaints') {
                      controller.deleteSelectedComplaintsList(id);
                    }
                    // for edit profile
                    //  else if (name == 'designation') {
                    //   EditProfileController.i.deleteSelectedComplaintsList(id);
                    // }

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

deleteMedicine(
  BuildContext context,
  int medicineindex,
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
                      'delete'.tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
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
                  'doyouwanttodeleteit'.tr,
                  style: GoogleFonts.poppins(
                    textStyle: GoogleFonts.poppins(
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                PrimaryButton(
                  title: 'yes'.tr,
                  fontSize: 14,
                  height: Get.height * 0.06,
                  width: Get.width * 0.5,
                  onPressed: () {
                    controller.removefinalmedindex(medicineindex);
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

deleteSelectedObject(
  BuildContext context,
  dynamic selectedItems,
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
                      'delete'.tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
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
                  'doyouwanttodeleteit'.tr,
                  style: GoogleFonts.poppins(
                    textStyle: GoogleFonts.poppins(
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                PrimaryButton(
                  title: 'yes'.tr,
                  fontSize: 14,
                  height: Get.height * 0.06,
                  width: Get.width * 0.5,
                  onPressed: () {
                    if (name == 'followup') {
                      controller.deletefollowup();
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
addComment(
    BuildContext context, String id, String comment, String listname) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      ERXController.i.trailingtextController.text = comment;
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
                      'comment'.tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        textStyle: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.bold),
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
                  'addcomments'.tr,
                  style: GoogleFonts.poppins(
                    textStyle: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),

                SizedBox(
                  height: Get.height * 0.03,
                ),

                // Textfield
                TextField(
                  controller: controller.trailingtextController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                      ),
                    ),
                    hintText: controller.trailingtextController.text == ""
                        ? 'typeyourcommenthere'.tr
                        : controller.trailingtextController.text,
                  ),
                ),

                SizedBox(
                  height: Get.height * 0.04,
                ),
                PrimaryButton(
                  title: 'save'.tr,
                  fontSize: 14,
                  height: Get.height * 0.05,
                  width: Get.width * 0.5,
                  onPressed: () {
                    //  print(object)
                    if (listname == "primary") {
                      controller.updateprimarycomments(id,
                          controller.trailingtextController.text.toString());
                      Get.back();
                    }

                    if (listname == "secondary") {
                      controller.updatesecondartcomments(id,
                          controller.trailingtextController.text.toString());
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
  ERXController.i
      .updatemedicineroutes(ERXController.i.medicinelst.medicineRoutes![0]);
  ERXController.i.updateDateList(ERXController.i.medicinelst.dateList![0]);
  ERXController.i.updatedayList(
    ERXController.i.medicinelst.dayList![0],
  );
  ERXController.i
      .updatemedicineDosages(ERXController.i.medicinelst.medicineDosages![0]);
  ERXController.i
      .updatemedfrequency(ERXController.i.medicinelst.medicineFrequencies![0]);
  String medtitle = "";
  TextEditingController medController = TextEditingController();
  Completer<dynamic> completer = Completer<dynamic>();
  controller.medicineList.sort((a, b) => a.name!.compareTo(b.name!));

  await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: SingleChildScrollView(
              child: SizedBox(
                height: Get.height * 0.54,
                width: Get.width * 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        hintStyle: GoogleFonts.poppins(
                            color: ColorManager.kPrimaryColor),
                        hintText: 'search'.tr,
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
                      controller: medController,
                      onFieldSubmitted: (value) async {
                        PrescribeMedicinRepo pmr = PrescribeMedicinRepo();
                        controller.updateMedicinelist(
                          await pmr.getMedicines(medController.text),
                        );
                        setState(() {});
                      },
                      onChanged: (val) async {
                        int length = medController.text.length;
                        PrescribeMedicinRepo pmr = PrescribeMedicinRepo();
                        if (length == 0) {
                          controller.updateMedicinelist(
                            await pmr.getMedicines(""),
                          );
                        }
                        setState(() {});
                      },
                      // onChanged: (val) {
                      //   medtitle = val;
                      //   setState(() {
                      //     medtitle = val;
                      //   });
                      // },
                    ),
                    SizedBox(
                      height: Get.height * 0.009,
                    ),
                    GetBuilder<ERXController>(builder: (context) {
                      return SizedBox(
                        height: Get.height * 0.15,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.medicineList.length,
                          itemBuilder: (context, index) {
                            // if (medController.text.isEmpty ||
                            //     controller.medicineList[index].name!
                            //         .toLowerCase()
                            //         .contains(medtitle.toLowerCase()))
                            //         {

                            final medicine = controller.medicineList[index];
                            final isSelected = controller.selectedmedicineList
                                .contains(medicine);

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.005),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Already Selected")));
                                    } else {
                                      controller.selectedmedicineList.clear();
                                      controller.selectedmedicineList
                                          .add(medicine);
                                    }
                                  });
                                },
                                child: Container(
                                  color: isSelected
                                      ? ColorManager.kPrimaryColor
                                      : ColorManager.kWhiteColor,
                                  child: Text(
                                    medicine.name ?? "",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: isSelected
                                          ? ColorManager.kWhiteColor
                                          : ColorManager.kblackColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                  ),
                                ),
                              ),
                            );
                            //  }
                            // else {
                            //   return Container();
                            // }
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
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Text(
                              'route'.tr,
                              style: GoogleFonts.raleway(
                                textStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.005,
                            ),
                            InkWell(
                              onTap: () async {
                                await showRoutes(context);
                              },
                              child: Container(
                                height: Get.height * 0.05,
                                width: Get.width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: ColorManager.kGreyColor,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: Get.height * 0.013,
                                      left: Get.width * 0.01),
                                  child: GetBuilder<ERXController>(
                                      builder: (context) {
                                    return Text(
                                      ERXController.i.medicineRoutes != null
                                          ? ERXController.i.medicineRoutes!
                                              .englishDefinition!
                                          : "Routes",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 10,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Text(
                              'duration'.tr,
                              style: GoogleFonts.raleway(
                                textStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.005,
                            ),
                            InkWell(
                              onTap: () async {
                                await showDuration(context);
                              },
                              child: Container(
                                height: Get.height * 0.05,
                                width: Get.width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: ColorManager.kGreyColor,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: Get.height * 0.013,
                                      left: Get.width * 0.01),
                                  child: GetBuilder<ERXController>(
                                      builder: (context) {
                                    return Text(
                                      ERXController.i.dayList != null &&
                                              ERXController.i.dateList != null
                                          ? "${ERXController.i.dateList!.englishCounting!} ${ERXController.i.dayList!.englishDay!}"
                                          : "Duration",
                                      style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 10,
                                      ),
                                    );
                                  }),
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
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Text(
                              'frequency'.tr,
                              style: GoogleFonts.raleway(
                                textStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.005,
                            ),
                            InkWell(
                              onTap: () async {
                                await showfrequency(context);
                              },
                              child: Container(
                                height: Get.height * 0.05,
                                width: Get.width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: ColorManager.kGreyColor,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: Get.height * 0.013,
                                      left: Get.width * 0.01),
                                  child: GetBuilder<ERXController>(
                                      builder: (context) {
                                    return Text(
                                      ERXController.i.medicineFrequencies !=
                                              null
                                          ? ERXController.i.medicineFrequencies!
                                              .numericDisplay!
                                          : "Frequency",
                                      style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 10,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Text(
                              'dosage'.tr,
                              style: GoogleFonts.raleway(
                                textStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.005,
                            ),
                            InkWell(
                              onTap: () async {
                                await showdosages(context);
                              },
                              child: Container(
                                height: Get.height * 0.05,
                                width: Get.width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: ColorManager.kGreyColor,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: Get.height * 0.013,
                                      left: Get.width * 0.01),
                                  child: GetBuilder<ERXController>(
                                      builder: (context) {
                                    return Text(
                                      ERXController.i.medicineDosages != null
                                          ? ERXController
                                              .i.medicineDosages!.dosageValue!
                                              .toString()
                                          : "Dosages",
                                      style: GoogleFonts.poppins(
                                        color: ColorManager.kblackColor,
                                        fontSize: 10,
                                      ),
                                    );
                                  }),
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
                        title: 'save'.tr,
                        fontSize: 14,
                        height: Get.height * 0.06,
                        onPressed: () async {
                          if (controller.selectedmedicineList.isNotEmpty) {
                            if (controller.medicineRoutes != null) {
                              if (controller.medicineFrequencies != null) {
                                if (controller.dateList != null &&
                                    controller.dayList != null) {
                                  if (controller.medicineDosages != null) {
                                    ERXController.i.selectedlst.dateList!
                                        .add(controller.dateList!);
                                    ERXController.i.selectedlst.dayList!
                                        .add(controller.dayList!);
                                    ERXController.i.selectedlst.medicineDosages!
                                        .add(controller.medicineDosages!);
                                    ERXController
                                        .i.selectedlst.medicineFrequencies!
                                        .add(controller.medicineFrequencies!);
                                    ERXController.i.selectedlst.medicineRoutes!
                                        .add(controller.medicineRoutes!);

                                    ERXController.i.updateselectedlst(
                                      medicinematric(
                                          dateList: ERXController
                                              .i.selectedlst.dateList!,
                                          dayList: ERXController
                                              .i.selectedlst.dayList!,
                                          medicineDosages: ERXController
                                              .i.selectedlst.medicineDosages!,
                                          medicineFrequencies: ERXController.i
                                              .selectedlst.medicineFrequencies!,
                                          medicineRoutes: ERXController
                                              .i.selectedlst.medicineRoutes!),
                                    );
                                    controller.updatefinalmed(
                                        selectedMedicineList[0]);
                                    // Medicine

                                    completer.complete(selectedMedicine);
                                    PrescribeMedicinRepo pmr =
                                        PrescribeMedicinRepo();
                                    controller.updateMedicinelist(
                                      await pmr.getMedicines(""),
                                    );

                                    Get.back();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'SelectDosagesFirst'.tr,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: ColorManager.kRedColor,
                                        textColor: ColorManager.kWhiteColor,
                                        fontSize: 14.0);
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'SelectDuarationFirst'.tr,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: ColorManager.kRedColor,
                                      textColor: ColorManager.kWhiteColor,
                                      fontSize: 14.0);
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'SelectFrequencyFirst'.tr,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: ColorManager.kRedColor,
                                    textColor: ColorManager.kWhiteColor,
                                    fontSize: 14.0);
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'SelectRouteFirst'.tr,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: ColorManager.kRedColor,
                                  textColor: ColorManager.kWhiteColor,
                                  fontSize: 14.0);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: 'SelectMedicineFirst'.tr,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: ColorManager.kRedColor,
                                textColor: ColorManager.kWhiteColor,
                                fontSize: 14.0);
                          }
                        },
                        color: ColorManager.kPrimaryColor,
                        textcolor: ColorManager.kWhiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  ).then((val) async {
    PrescribeMedicinRepo pmr = PrescribeMedicinRepo();
    controller.updateMedicinelist(
      await pmr.getMedicines(""),
    );
  });
  return completer.future;
}

showRoutes(
  BuildContext context,
) async {
  await showDialog(
    barrierDismissible: true,
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
                  ERXController.i.medicinelst.medicineRoutes!.isNotEmpty
                      ? Wrap(
                          direction: Axis
                              .horizontal, // Make sure items are laid out horizontally
                          runSpacing: 8.0,
                          children: <Widget>[
                            for (int index = 0;
                                index <
                                    ERXController
                                        .i.medicinelst.medicineRoutes!.length;
                                index++)
                              InkWell(
                                onTap: () {
                                  ERXController.i.updatemedicineroutes(
                                      ERXController.i.medicinelst
                                          .medicineRoutes![index]);
                                  Get.back();
                                },
                                child: Card(
                                  elevation: 4,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.01,
                                        right: Get.width * 0.01),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          ERXController
                                                  .i
                                                  .medicinelst
                                                  .medicineRoutes?[index]
                                                  .englishDefinition ??
                                              "",
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color: ColorManager.kblackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                      : const Center(child: Text("No Medicine Found")),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

showDuration(
  BuildContext context,
) async {
  await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            height: Get.height * 0.7,
            width: Get.width * 0.8,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ERXController.i.medicinelst.dayList!.isNotEmpty
                        ? Wrap(
                            direction: Axis
                                .horizontal, // Make sure items are laid out horizontally
                            runSpacing: 8.0,
                            children: <Widget>[
                              for (int index = 0;
                                  index <
                                      ERXController
                                          .i.medicinelst.dayList!.length;
                                  index++)
                                ERXController.i.medicinelst.dayList![index]
                                            .englishDay ==
                                        ""
                                    ? SizedBox(
                                        width: Get.width * 0.67,
                                        child: InkWell(
                                          onTap: () {
                                            ERXController.i.updateDateList(
                                                ERXController.i.medicinelst
                                                    .dateList![0]);
                                            ERXController.i.updatedayList(
                                              ERXController
                                                  .i.medicinelst.dayList![0],
                                            );

                                            Get.back();
                                          },
                                          child: Card(
                                            child: Center(
                                              child: Text(ERXController
                                                  .i
                                                  .medicinelst
                                                  .dateList![0]
                                                  .englishCounting
                                                  .toString()),
                                            ),
                                          ),
                                        ))
                                    : SizedBox(
                                        width: Get.width * 0.69,
                                        child: Card(
                                          color: Colors.grey.shade100,
                                          elevation: 4,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: Get.width * 0.01,
                                                right: Get.width * 0.01),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: Get.height * 0.03,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      ERXController
                                                              .i
                                                              .medicinelst
                                                              .dayList?[index]
                                                              .englishDay ??
                                                          "",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 16,
                                                        color: ColorManager
                                                            .kblackColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            Get.height * 0.2,
                                                        width: Get.width * 0.44,
                                                        child: GridView(
                                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    6,
                                                                crossAxisSpacing:
                                                                    4.0,
                                                                mainAxisSpacing:
                                                                    4.0),
                                                            children: List.generate(
                                                                ERXController
                                                                    .i
                                                                    .medicinelst
                                                                    .dateList!
                                                                    .length,
                                                                (i) {
                                                              final data =
                                                                  ERXController
                                                                      .i
                                                                      .medicinelst
                                                                      .dateList![i];
                                                              if (data.englishCounting
                                                                      .toString()
                                                                      .toLowerCase() !=
                                                                  "continue") {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    ERXController
                                                                        .i
                                                                        .updateDateList(ERXController
                                                                            .i
                                                                            .medicinelst
                                                                            .dateList![i]);
                                                                    ERXController
                                                                        .i
                                                                        .updatedayList(
                                                                      ERXController
                                                                          .i
                                                                          .medicinelst
                                                                          .dayList![index],
                                                                    );
                                                                    Get.back();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        color: Colors
                                                                            .grey
                                                                            .shade300),
                                                                    height:
                                                                        Get.height *
                                                                            0.15,
                                                                    width:
                                                                        Get.width *
                                                                            0.3,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        data.englishCounting!,
                                                                        style: GoogleFonts
                                                                            .poppins(),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              } else {
                                                                return const SizedBox
                                                                    .shrink();
                                                              }
                                                            })))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                            ],
                          )
                        : const Center(child: Text("No Medicine Found")),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

showdosages(
  BuildContext context,
) async {
  await showDialog(
    barrierDismissible: true,
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
                  ERXController.i.medicinelst.medicineDosages!.isNotEmpty
                      ? Wrap(
                          direction: Axis
                              .horizontal, // Make sure items are laid out horizontally
                          runSpacing: 8.0,
                          children: <Widget>[
                            for (int index = 0;
                                index <
                                    ERXController
                                        .i.medicinelst.medicineDosages!.length;
                                index++)
                              InkWell(
                                onTap: () {
                                  ERXController.i.updatemedicineDosages(
                                      ERXController.i.medicinelst
                                          .medicineDosages![index]);
                                  Get.back();
                                },
                                child: Card(
                                  elevation: 4,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.01,
                                        right: Get.width * 0.01),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Builder(builder: (context) {
                                          return Text(
                                            ERXController
                                                    .i
                                                    .medicinelst
                                                    .medicineDosages?[index]
                                                    .dosageValue
                                                    .toString() ??
                                                "",
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: ColorManager.kblackColor,
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                      : const Center(child: Text("No Medicine Found")),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

showfrequency(
  BuildContext context,
) async {
  await showDialog(
    barrierDismissible: true,
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
                  ERXController.i.medicinelst.medicineFrequencies!.isNotEmpty
                      ? Wrap(
                          direction: Axis
                              .horizontal, // Make sure items are laid out horizontally
                          runSpacing: 8.0,
                          children: <Widget>[
                            for (int index = 0;
                                index <
                                    ERXController.i.medicinelst
                                        .medicineFrequencies!.length;
                                index++)
                              InkWell(
                                onTap: () {
                                  ERXController.i.updatemedfrequency(
                                      ERXController.i.medicinelst
                                          .medicineFrequencies![index]);
                                  Get.back();
                                },
                                child: Card(
                                  elevation: 4,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.01,
                                        right: Get.width * 0.01),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          ERXController
                                                  .i
                                                  .medicinelst
                                                  .medicineFrequencies?[index]
                                                  .numericDisplay ??
                                              "",
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color: ColorManager.kblackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                      : const Center(child: Text("No Medicine Found")),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

// addMedicine(
//   BuildContext context,
//   List<dynamic> medicinelist,
//   List<dynamic> selectedMedicineList,
//   String selectedMedicine,
// ) async {
//   String medtitle = "";
//   TextEditingController medController = TextEditingController();
//   Completer<dynamic> completer = Completer<dynamic>();
//   controller.medicineList.sort((a, b) => a.name!.compareTo(b.name!));

//   // String selectedgroup = 'Select';
//   // List<String> groupList = [
//   //   'Select',
//   //   'Med 1',
//   // ];
//   await showDialog(
//     barrierDismissible: true,
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(15.0))),
//             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//             content: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: Get.height * 0.01,
//                   ),
//                   // Medicines
//                   Center(
//                     child: Text(
//                       'Medicines',
//                       style: GoogleFonts.poppins(
//                         textStyle: GoogleFonts.poppins(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.01,
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(
//                       contentPadding:
//                           const EdgeInsets.symmetric(horizontal: 20),
//                       hintStyle:
//                           const TextStyle(color: ColorManager.kPrimaryColor),
//                       hintText: 'Search',
//                       filled: true,
//                       disabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8)),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                               color: ColorManager.kPrimaryLightColor),
//                           borderRadius: BorderRadius.circular(8)),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: const BorderSide(
//                             color: ColorManager.kPrimaryLightColor),
//                       ),
//                       fillColor: ColorManager.kPrimaryLightColor,
//                       prefixIcon: const Icon(
//                         Icons.search,
//                         color: ColorManager.kPrimaryColor,
//                       ),
//                       border: const OutlineInputBorder(
//                         borderSide:
//                             BorderSide(color: ColorManager.kPrimaryLightColor),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(0.0),
//                         ),
//                       ),
//                     ),
//                     controller: medController,
//                     onChanged: (val) {
//                       medtitle = val;
//                       setState(() {
//                         medtitle = val;
//                       });
//                     },
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.009,
//                   ),
//                   GetBuilder<ERXController>(builder: (context) {
//                     return SizedBox(
//                       height: Get.height * 0.15,
//                       child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: controller.medicineList.length,
//                         itemBuilder: (context, index) {
//                           if (medController.text.isEmpty ||
//                               controller.medicineList[index].name!
//                                   .toLowerCase()
//                                   .contains(medtitle.toLowerCase())) {
//                             final medicine = controller.medicineList[index];
//                             final isSelected = controller.selectedmedicineList
//                                 .contains(medicine);
//                             return InkWell(
//                               onTap: () {
//                                 setState(() {
//                                   if (isSelected) {
//                                     controller.selectedmedicineList.clear();
//                                     selectedMedicine = "";
//                                   } else {
//                                     controller.selectedmedicineList.clear();
//                                     controller.selectedmedicineList
//                                         .add(medicine);
//                                     selectedMedicine = medicine.name ?? "";
//                                   }
//                                 });
//                               },
//                               child: Container(
//                                 color: isSelected
//                                     ? ColorManager.kPrimaryColor
//                                     : ColorManager.kWhiteColor,
//                                 child: Text(
//                                   medicine.name ?? "",
//                                   style: TextStyle(
//                                     fontSize: 10,
//                                     color: isSelected
//                                         ? ColorManager.kWhiteColor
//                                         : ColorManager.kblackColor,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 4,
//                                 ),
//                               ),
//                             );
//                           } else {
//                             return Container();
//                           }
//                         },
//                       ),
//                     );
//                   }),
//                   SizedBox(
//                     height: Get.height * 0.009,
//                   ),
//                   Row(children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: Get.height * 0.01,
//                           ),
//                           Text(
//                             '  Routes',
//                             style: GoogleFonts.raleway(
//                               textStyle: GoogleFonts.poppins(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: Get.height * 0.005,
//                           ),
//                           InkWell(
//                             onTap: () {
//                               showRoutes(context);
//                             },
//                             child: Container(
//                               height: Get.height * 0.05,
//                               width: Get.width * 0.5,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 border: Border.all(
//                                   color: ColorManager.kGreyColor,
//                                 ),
//                               ),
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                     top: Get.height * 0.013,
//                                     left: Get.width * 0.01),
//                                 child: const Text(
//                                   'external use',
//                                   style: TextStyle(
//                                     color: ColorManager.kblackColor,
//                                     fontSize: 10,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: Get.height * 0.01,
//                           ),
//                           Text(
//                             '  Duration',
//                             style: GoogleFonts.raleway(
//                               textStyle: GoogleFonts.poppins(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: Get.height * 0.005,
//                           ),
//                           Container(
//                             height: Get.height * 0.05,
//                             width: Get.width * 0.5,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               border: Border.all(
//                                 color: ColorManager.kGreyColor,
//                               ),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.only(
//                                   top: Get.height * 0.013,
//                                   left: Get.width * 0.01),
//                               child: const Text(
//                                 '2 Week',
//                                 style: TextStyle(
//                                   color: ColorManager.kblackColor,
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: Get.width * 0.009,
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: Get.height * 0.01,
//                           ),
//                           Text(
//                             '  Frequency',
//                             style: GoogleFonts.raleway(
//                               textStyle: GoogleFonts.poppins(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: Get.height * 0.005,
//                           ),
//                           Container(
//                             height: Get.height * 0.05,
//                             width: Get.width * 0.5,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               border: Border.all(
//                                 color: ColorManager.kGreyColor,
//                               ),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.only(
//                                   top: Get.height * 0.013,
//                                   left: Get.width * 0.01),
//                               child: const Text(
//                                 '1',
//                                 style: TextStyle(
//                                   color: ColorManager.kblackColor,
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: Get.height * 0.01,
//                           ),
//                           Text(
//                             '  Dosage',
//                             style: GoogleFonts.raleway(
//                               textStyle: GoogleFonts.poppins(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: Get.height * 0.005,
//                           ),
//                           Container(
//                             height: Get.height * 0.05,
//                             width: Get.width * 0.5,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               border: Border.all(
//                                 color: ColorManager.kGreyColor,
//                               ),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.only(
//                                   top: Get.height * 0.013,
//                                   left: Get.width * 0.01),
//                               child: const Text(
//                                 'OD',
//                                 style: TextStyle(
//                                   color: ColorManager.kblackColor,
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ]),
//                   SizedBox(height: Get.height * 0.04),
//                   Center(
//                     child: PrimaryButton(
//                       title: 'Save',
//                       fontSize: 14,
//                       height: Get.height * 0.06,
//                       onPressed: () {
//                         Get.back();
//                         completer.complete(selectedMedicine);
//                       },
//                       color: ColorManager.kPrimaryColor,
//                       textcolor: ColorManager.kWhiteColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
//   return completer.future;
// }

// showRoutes(
//   BuildContext context,
// ) async {
//   await showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(15.0))),
//             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//             content: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Wrap(
//                     direction: Axis
//                         .horizontal, // Make sure items are laid out horizontally
//                     runSpacing: 8.0,
//                     children: <Widget>[
//                       for (int index = 0;
//                           index <
//                               ERXController
//                                   .i.medicedata!.medicineRoutes!.length;
//                           index++)
//                         InkWell(
//                           onTap: () {
//                             // select route
//                           },
//                           child: Card(
//                             elevation: 4,
//                             child: Padding(
//                               padding: EdgeInsets.only(
//                                   left: Get.width * 0.01,
//                                   right: Get.width * 0.01),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Text(
//                                     ERXController
//                                             .i
//                                             .medicedata!
//                                             .medicineRoutes![index]
//                                             .englishDefinition ??
//                                         "",
//                                     style: const TextStyle(
//                                       fontSize: 10,
//                                       color: ColorManager.kblackColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }

// 4 alert dialog to select for each medicine
medicineRowitems(
  BuildContext context,
) async {
  await showDialog(
    barrierDismissible: true,
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
    barrierDismissible: true,
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
                      style: GoogleFonts.poppins(
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
                  style: GoogleFonts.poppins(
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
                          style: GoogleFonts.poppins(
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
                              style: GoogleFonts.poppins(
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
                          style: GoogleFonts.poppins(
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
                              style: GoogleFonts.poppins(
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
                          style: GoogleFonts.poppins(
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
                              style: GoogleFonts.poppins(
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
                          style: GoogleFonts.poppins(
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
                              style: GoogleFonts.poppins(
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
