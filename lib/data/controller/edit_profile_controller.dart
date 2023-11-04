import 'dart:io';

import 'package:doctormobileapplication/components/snackbar.dart';
import 'package:doctormobileapplication/models/blood_group.dart';
import 'package:doctormobileapplication/models/cities_model.dart';
import 'package:doctormobileapplication/models/countries_model.dart';
import 'package:doctormobileapplication/models/degree.dart';
import 'package:doctormobileapplication/models/designation.dart';
import 'package:doctormobileapplication/models/genders_model.dart';
import 'package:doctormobileapplication/models/hospital_clinic.dart';
import 'package:doctormobileapplication/models/institutes.dart';
import 'package:doctormobileapplication/models/marital_status.dart';
import 'package:doctormobileapplication/models/person_title.dart';
import 'package:doctormobileapplication/models/provinces_model.dart';
import 'package:doctormobileapplication/models/relation.dart';
import 'package:doctormobileapplication/models/religion.dart';
import 'package:doctormobileapplication/models/speciality.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditProfileController extends GetxController implements GetxService {
  static EditProfileController get i => Get.put(EditProfileController());
  String? newiamgepath;
  updateimagepath(String img) {
    newiamgepath = img;
    update();
  }

  bool ontap = false;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  updateIsloading(bool value) {
    _isLoading = value;
    update();
  }

  disposefile() {
    file = null;
  }

  List<HospitalORClinics> hospitalList = [];
  HospitalORClinics? selectedhospital;
  updatehospitallist(List<HospitalORClinics> hlist) {
    hospitalList = hlist;
    update();
  }

  updateselectedhospital(HospitalORClinics bran) {
    selectedhospital = bran;
    update();
  }

  PlatformFile? bankfile;
  Future<void> picksingleBankfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      bankfile = result.files.first;
    }
  }

  PlatformFile? experiencefile;
  Future<void> picksingleexperiencefile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      experiencefile = result.files.first;
    }
  }

  List<Specialities1> specialitiesList = [];
  List<Specialities1> selectedSpecialitiesList = [];
  Specialities1? selectedspecialities;
  updatespecialitiesList(List<Specialities1> slist) {
    specialitiesList = slist;

    update();
  }

  updateselectedspeciality(Specialities1 s) {
    selectedspecialities = s;
    selectedSpecialitiesList.add(s);
    update();
  }

  deleteSelectedspeciality() {
    selectedspecialities = null;
    update();
  }

  //
  List<Specialities1> subspecialitiesList = [];
  Specialities1? selectedsubspecialities;
  List<Specialities1> selectedSubSpecialitiesList = [];
  updatesubspecialitiesList(List<Specialities1> slist) {
    subspecialitiesList = slist;
    update();
  }

  updateselectedsubspeciality(Specialities1 s) {
    selectedsubspecialities = s;
    selectedSubSpecialitiesList.add(s);
    update();
  }

  deleteSelectedsubspeciality() {
    selectedsubspecialities = null;
    update();
  }

  static DateTime? arrival = DateTime.now();
  String? formattedArrival = arrival!.toIso8601String();
  RxString? formatearrival = DateFormat.yMMMd().format(arrival!).obs;
  Future<void> selectDateAndTime(
    BuildContext context,
    DateTime? date,
    RxString? formattedDate,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        confirmText: 'Ok',
        initialDate: date!,
        firstDate: DateTime(1950),
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != date) {
      date = pickedDate;
      formattedDate!.value = DateFormat.yMMMd().format(date);
      formattedDate.value = DateFormat.yMMMd().format(date);
      final iso8601Format = DateFormat("yyyy-MM-dd'T'00:00:00");
      formattedArrival = iso8601Format.format(date);
      calculateUserAge(date);
      update();
    }
  }

  Future<void> selecteducationstartDateAndTime(
    BuildContext context,
    DateTime? date,
    RxString? formattedDate,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        confirmText: 'Ok',
        initialDate: date!,
        firstDate: DateTime(1950),
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != date) {
      date = pickedDate;
      formattedDate!.value = DateFormat.yMMMd().format(date);
      formattedDate.value = DateFormat.yMMMd().format(date);
      final iso8601Format = DateFormat("yyyy-MM-dd'T'00:00:00");
      formatteddegreestart = iso8601Format.format(date);
      update();
    }
  }

  Future<void> selecteducationendDateAndTime(
    BuildContext context,
    DateTime? date,
    RxString? formattedDate,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        confirmText: 'Ok',
        initialDate: date!,
        firstDate: DateTime(1950),
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != date) {
      date = pickedDate;
      formattedDate!.value = DateFormat.yMMMd().format(date);
      formattedDate.value = DateFormat.yMMMd().format(date);
      final iso8601Format = DateFormat("yyyy-MM-dd'T'00:00:00");
      formatteddegreeend = iso8601Format.format(date);
      update();
    }
  }

  Future<void> selecteducationissueDateAndTime(
    BuildContext context,
    DateTime? date,
    RxString? formattedDate,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        confirmText: 'Ok',
        initialDate: date!,
        firstDate: DateTime(1950),
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != date) {
      date = pickedDate;
      formattedDate!.value = DateFormat.yMMMd().format(date);
      formattedDate.value = DateFormat.yMMMd().format(date);
      final iso8601Format = DateFormat("yyyy-MM-dd'T'00:00:00");
      formatteddegreeissue = iso8601Format.format(date);
      update();
    }
  }

  Future<void> selectexperiencefromDateAndTime(
    BuildContext context,
    DateTime? date,
    RxString? formattedDate,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        confirmText: 'Ok',
        initialDate: date!,
        firstDate: DateTime(1950),
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != date) {
      date = pickedDate;
      formattedDate!.value = DateFormat.yMMMd().format(date);
      formattedDate.value = DateFormat.yMMMd().format(date);
      final iso8601Format = DateFormat("yyyy-MM-dd'T'00:00:00");
      formattedexperiencefrom = iso8601Format.format(date);
      update();
    }
  }

  Future<void> selectexperiencetoDateAndTime(
    BuildContext context,
    DateTime? date,
    RxString? formattedDate,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        confirmText: 'Ok',
        initialDate: date!,
        firstDate: DateTime(1950),
        lastDate: DateTime(2024));
    if (pickedDate != null && pickedDate != date) {
      date = pickedDate;
      formattedDate!.value = DateFormat.yMMMd().format(date);
      formattedDate.value = DateFormat.yMMMd().format(date);
      final iso8601Format = DateFormat("yyyy-MM-dd'T'00:00:00");
      formattedexperienceto = iso8601Format.format(date);
      update();
    }
  }

  String radioselectedValue = "CGPA";

  updateradiovalue(value) {
    radioselectedValue = value;
    update();
  }

  bool inprogressisChecked = false;

  bool newworklocationisChecked = false;

  bool currentlyworkingisChecked = false;

  static DateTime? degreestart = DateTime.now();
  String? formatteddegreestart = degreestart!.toIso8601String();
  RxString? formatedegreestart = DateFormat.yMMMd().format(degreestart!).obs;

  static DateTime? degreeend = DateTime.now();
  String? formatteddegreeend = degreeend!.toIso8601String();
  RxString? formatedegreeend = DateFormat.yMMMd().format(degreeend!).obs;

  static DateTime? degreeissue = DateTime.now();
  String? formatteddegreeissue = degreeissue!.toIso8601String();
  RxString? formatedegreeissue = DateFormat.yMMMd().format(degreeissue!).obs;

  static DateTime? experiencefrom = DateTime.now();
  String? formattedexperiencefrom = experiencefrom!.toIso8601String();
  RxString? formateexperiencefrom =
      DateFormat.yMMMd().format(experiencefrom!).obs;

  static DateTime? experienceto = DateTime.now();
  String? formattedexperienceto = experienceto!.toIso8601String();
  RxString? formateexperienceto = DateFormat.yMMMd().format(experienceto!).obs;

  String userage = '';

  void calculateUserAge(DateTime? birthDate) {
    final currentDate = DateTime.now();
    final age = currentDate.year -
        birthDate!.year -
        (currentDate.month > birthDate.month ||
                (currentDate.month == birthDate.month &&
                    currentDate.day >= birthDate.day)
            ? 0
            : 1);
    userage = age.toString();
    if (age > 1) {
      userage = "$userage  Years";
    }
    if (age <= 1) {
      userage = "$userage  Year";
    }
  }

  File? file;
  Future<File?> pickImage({
    bool allowMultiple = false,
    BuildContext? context,
  }) async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: allowMultiple);
      if (result != null) {
        file = File(result.files.first.path!);
      } else {
        return file;
      }
    } catch (e) {
      showSnackbar(Get.context!, e.toString());
    }
    update();
    return file;
  }

  String? name;
  String? dob;
  String? number;
  String? email;
  String? country;
  String? province;
  String? city;
  String? address;
  String? countryid;
  String? provinceid;
  String? cityid;

  // static DateTime? arrival = DateTime.now();
  // RxString? formatearrival = DateFormat.yMMMd().format(arrival!).obs;

  // Future<void> selectDateAndTime(
  //   BuildContext context,
  //   DateTime? date,
  //   RxString? formattedDate,
  // ) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //       context: context,
  //       confirmText: 'Ok',
  //       initialDate: date!,
  //       firstDate: DateTime(1950),
  //       lastDate: DateTime(2050));
  //   if (pickedDate != null && pickedDate != date) {
  //     date = pickedDate;
  //     formattedDate!.value = DateFormat.yMMMd().format(date);

  //     update();
  //   }
  // }
  List<Degrees> bankList = [];
  Degrees? selectedbank = Degrees();

  updatedbankList(List<Degrees> blist) {
    bankList = blist;
    update();
  }

  updateselectedbank(Degrees bank) {
    selectedbank = bank;
    update();
  }

  List<Institutions> institutionList = [];
  Institutions? selectedinstitution = Institutions();

  updateinstitutionlist(List<Institutions> ilist) {
    institutionList = ilist;
    update();
  }

  updateselectedInstitution(Institutions ins) {
    selectedinstitution = ins;

    update();
  }

  List<Degrees> degreesList = [];
  Degrees? selecteddegree = Degrees();

  updatedegreesList(List<Degrees> dlist) {
    degreesList = dlist;
    update();
  }

  updateselecteddegree(Degrees ins) {
    selecteddegree = ins;

    update();
  }

  List<Degrees> locationList = [];
  Degrees? selectedlocation = Degrees();

  updatelocationList(List<Degrees> dlist) {
    locationList = dlist;
    update();
  }

  updateselectedlocation(Degrees ins) {
    selectedlocation = ins;

    update();
  }

  List<Degrees> fieldofstudyList = [];
  Degrees? selectedfieldofstudy = Degrees();

  updatefieldofstudyList(List<Degrees> dlist) {
    fieldofstudyList = dlist;
    update();
  }

  updateselectedfieldofstudy(Degrees ins) {
    selectedfieldofstudy = ins;

    update();
  }

  List<Countries> countriesList = [];
  Countries? selectedcountry = Countries();
  Countries? educationselectedCountry = Countries();
  updatecountriesList(List<Countries> clist) {
    countriesList = clist;
    update();
  }

  updateselectedCountry(Countries country) {
    selectedcountry = country;

    update();
  }

  List<Countries> worklocationcountriesList = [];
  Countries? selectedworklocationcountry = Countries();
  updateworklocationcountriesList(List<Countries> clist) {
    worklocationcountriesList = clist;
    update();
  }

  updateselectedworklocationcountry(Countries country) {
    selectedworklocationcountry = country;
    update();
  }

  List<Provinces> worklocationstateList = [];
  Provinces? selectedworklocationstate = Provinces();
  updateworklocationstateList(List<Provinces> plist) {
    worklocationstateList = plist;
    update();
  }

  updateselectedworklocationstate(Provinces state) {
    selectedworklocationstate = state;
    update();
  }

  List<Cities> worklocationcitiesList = [];
  Cities? selectedworklocationCities = Cities();
  updateworklocationcitiesList(List<Cities> clist) {
    worklocationcitiesList = clist;
    update();
  }

  updateselectedworklocationCities(Cities cities) {
    selectedworklocationCities = cities;
    update();
  }

  updateeducationselectedCountry(Countries country) {
    educationselectedCountry = country;

    update();
  }

  deleteSelectedCountry() {
    selectedcountry = null;
    update();
  }

  List<Provinces> provinceList = [];
  Provinces? selectedprovince = Provinces();
  updateprovinceList(List<Provinces> plist) {
    provinceList = plist;
    update();
  }

  updateselectedprovince(Provinces province) {
    selectedprovince = province;
    update();
  }

  deleteSelectedprovince() {
    selectedprovince = null;
    update();
  }

  List<Cities> citiesList = [];
  Cities? selectedcity = Cities();
  updatecitiesList(List<Cities> clist) {
    citiesList = clist;
    update();
  }

  updateselectedcity(Cities city) {
    selectedcity = city;
    update();
  }

  deleteSelectedcity() {
    selectedcity = null;
    update();
  }

  List<PTitle> personalTitleList = [];
  PTitle? selectedpersonalTitle = PTitle();
  updatepersonalTitleList(List<PTitle> plist) {
    personalTitleList = plist;
    personalTitleList.add(PTitle(id: '', name: "Other"));
    update();
  }

  updateselectedpersonalTitle(PTitle p) {
    selectedpersonalTitle = p;
    update();
  }

  deleteSelectedpersonalTitle() {
    selectedpersonalTitle = null;
    update();
  }

  List<MSData> maritalStatusList = [];
  MSData? selectedmaritalStatus = MSData();
  updatemaritalStatusList(List<MSData> mslist) {
    maritalStatusList = mslist;
    update();
  }

  updateselectedmaritalStatus(MSData maritalstatus) {
    selectedmaritalStatus = maritalstatus;
    update();
  }

  deleteSelectedmaritalStatus() {
    selectedmaritalStatus = null;
    update();
  }

  List<GendersData> genderList = [];
  GendersData? selectedgender = GendersData();
  updategenderList(List<GendersData> glist) {
    genderList = glist;
    update();
  }

  updateselectedgender(GendersData gender) {
    selectedgender = gender;
    update();
  }

  deleteSelectedgender() {
    selectedgender = null;
    update();
  }

  // blood
  List<bloodGroupData> bloodgroupList = [];
  bloodGroupData? selectedbloodgroup = bloodGroupData();
  updatebloodgroupList(List<bloodGroupData> bglist) {
    bloodgroupList = bglist;
    update();
  }

  updateselectedbloodgroup(bloodGroupData bg) {
    selectedbloodgroup = bg;
    update();
  }

  deleteSelectedbloodgroup() {
    selectedbloodgroup = null;
    update();
  }

  // religion
  List<Religion> religionList = [];
  Religion? selectedreligion = Religion();
  updatereligionList(List<Religion> rlist) {
    religionList = rlist;
    update();
  }

  updateselectedreligion(Religion r) {
    selectedreligion = r;
    update();
  }

  deleteSelectedreligion() {
    selectedreligion = null;
    update();
  }
  // designation

  List<Designations> designationList = [];
  List<Designations> selecteddesignationList = [];
  List<String> deleteddesignationList = [];
  List<String> selecteddesignationIdList = [];

  updatedesignationdata(List<Designations> clist) {
    designationList = clist;
    update();
  }

  addDesignation(Designations c, ctx) {
    if (selecteddesignationList.contains(c)) {
      showSnackbar(ctx, "Already Added");
    }
    selecteddesignationList.add(c);
    selecteddesignationIdList.add(c.id!);
    update();
  }

  updateselectedComplaintsList(List<Designations> cmplist) {
    selecteddesignationList = cmplist;
    update();
  }

  deleteSelectedComplaintsList(String id) {
    selecteddesignationList.removeWhere((element) => element.id == id);
    deleteddesignationList.add(id);
    update();
  }
  //   List<Designations> designationList = [];
  // Designations? selecteddesignation;
  // updatedesignationList(List<Designations> dlist) {
  //   designationList = dlist;
  //   update();
  // }

  // updateselecteddesignation(Designations d) {
  //   selecteddesignation = d;
  //   update();
  // }

  // deleteSelecteddesignation() {
  //   selecteddesignation = null;
  //   update();
  // }
  // relation
  List<RelationData> relationList = [];
  RelationData? selectedrelation = RelationData();
  updaterelationList(List<RelationData> rlist) {
    relationList = rlist;
    update();
  }

  updateselectedrelation(RelationData r) {
    selectedrelation = r;
    update();
  }

  deleteSelectedrelation() {
    selectedrelation = null;
    update();
  }

  List<RelationData> nokrelationList = [];
  RelationData? selectednokrelation = RelationData();
  updatenokrelationList(List<RelationData> rlist) {
    nokrelationList = rlist;
    update();
  }

  updateselectednokrelation(RelationData r) {
    selectednokrelation = r;
    update();
  }

  deleteSelectednokrelation() {
    selectednokrelation = null;
    update();
  }

  String selectedRadioValue = 'idno';

  updateRadioValue(value) {
    selectedRadioValue = value;
    update();
  }

  late TextEditingController firstname;
  late TextEditingController middlename;
  late TextEditingController lastname;
  late TextEditingController idnumber;
  late TextEditingController imcno;
  late TextEditingController username;
  late TextEditingController password;
  late TextEditingController phone;
  late TextEditingController retypePassword;
  late TextEditingController ntnnumber;
  late TextEditingController consultancyfee;
  late TextEditingController followupfee;
  late TextEditingController guardianname;
  late TextEditingController addressController;
  late TextEditingController publicmobileno;
  late TextEditingController privatemobileno;
  late TextEditingController telephone;
  late TextEditingController emailController;

  late TextEditingController nokfirstname;
  late TextEditingController noklastname;

  late TextEditingController nokidno;
  late TextEditingController nokmobileno;
  late TextEditingController customprefixtitle;
  late TextEditingController passportno;

  late TextEditingController totalmarks;
  late TextEditingController obtainedmarks;
  late TextEditingController percentage;

  late TextEditingController accountTitle;
  late TextEditingController accountNo;
  late TextEditingController worklocationpreference;

  late TextEditingController newworklocationname;
  late TextEditingController newworklocationnameaddress;

  // PRESCRIPTION CONFIGURATION
  late TextEditingController displayeducation;
  late TextEditingController displaydesignation;

  late TextEditingController stamp;
  late TextEditingController professionalsummary;

  late TextEditingController topmargin;
  late TextEditingController bottommargin;

  late TextEditingController displayenglisheducation;
  late TextEditingController displayenglishdesignation;
  late TextEditingController displayenglishothers;

  late TextEditingController displayurdueducation;
  late TextEditingController displayurdudesignation;
  late TextEditingController displayurduothers;

  // experience
  late TextEditingController jobtitle;
  late TextEditingController experienceDescription;

  @override
  void onInit() {
    // experience
    jobtitle = TextEditingController();
    experienceDescription = TextEditingController();
    // PRESCRIPTION CONFIGURATION
    displayeducation = TextEditingController();
    displaydesignation = TextEditingController();
    stamp = TextEditingController();
    professionalsummary = TextEditingController();
    topmargin = TextEditingController();
    bottommargin = TextEditingController();
    displayenglishdesignation = TextEditingController();
    displayenglisheducation = TextEditingController();
    displayenglishothers = TextEditingController();
    displayurdudesignation = TextEditingController();
    displayurdueducation = TextEditingController();
    displayurduothers = TextEditingController();

    newworklocationname = TextEditingController();
    newworklocationnameaddress = TextEditingController();
    worklocationpreference = TextEditingController();
    accountTitle = TextEditingController();

    accountNo = TextEditingController();
    totalmarks = TextEditingController();
    obtainedmarks = TextEditingController();
    percentage = TextEditingController();
    firstname = TextEditingController();
    middlename = TextEditingController();
    lastname = TextEditingController();
    idnumber = TextEditingController();
    imcno = TextEditingController();
    username = TextEditingController();
    password = TextEditingController();
    retypePassword = TextEditingController();
    phone = TextEditingController();
    ntnnumber = TextEditingController();
    consultancyfee = TextEditingController();
    followupfee = TextEditingController();
    guardianname = TextEditingController();
    addressController = TextEditingController();
    publicmobileno = TextEditingController();
    privatemobileno = TextEditingController();
    telephone = TextEditingController();
    nokfirstname = TextEditingController();
    noklastname = TextEditingController();
    nokidno = TextEditingController();
    nokmobileno = TextEditingController();
    emailController = TextEditingController();
    customprefixtitle = TextEditingController();
    passportno = TextEditingController();
    super.onInit();
  }

  PlatformFile? pmcfile;
  Future<void> picksinglefile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      pmcfile = result.files.first;
    }
  }

  String publicnumber = '';
  updatepublicno(no) {
    publicnumber = no;
    update();
  }

  String privatenumber = '';
  updateprivateno(no) {
    privatenumber = no;
    update();
  }

  String telephonenumber = '';
  updatetelephonenumber(no) {
    telephonenumber = no;
    update();
  }

  String nokmobilenumber = '';
  updatenoknumber(no) {
    nokmobilenumber = no;
    update();
  }
}
