import 'package:doctormobileapplication/data/controller/edit_profile_controller.dart';
import 'package:doctormobileapplication/models/doctor_details.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController implements GetxService {
  static ProfileController get i => Get.put(ProfileController());

  int pageIndex = 0;

  var status = "iamoffline".tr;
  var value = 0;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  updateIsloading(bool value) {
    _isLoading = value;
    update();
  }

  Specialities? mainspeciality;
  updatemainspeciality(Specialities data) {
    mainspeciality = data;
    update();
  }

  List<Specialities> specialities = [];
  updatespecialitites(List<Specialities> data) {
    specialities = data;
    update();
  }

  List<Educations> educationList = [];
  updatedDoctorEducation(List<Educations> edu) {
    educationList = edu;
    update();
  }

  List<Memberships> membershipList = [];
  updatedDoctormembership(List<Memberships> membership) {
    membershipList = membership;
    update();
  }

  List<Awards> awardsList = [];
  updatedDoctorawards(List<Awards> awards) {
    awardsList = awards;
    update();
  }

  List<Expereinces> experienceList = [];
  updatedDoctorexperienceList(List<Expereinces> exp) {
    experienceList = exp;
    update();
  }

  List<Specialities> specilizationList = [];
  updatedDoctorspecilizationList(List<Specialities> spe) {
    specilizationList = spe;
    update();
  }

  List<BankAccounts> bankDetailList = [];
  updatedDoctorbankDetailList(List<BankAccounts> bd) {
    bankDetailList = bd;
    update();
  }

  List<AppointmentConfigurations> appointmentConfigurationList = [];
  updatedappointmentConfigurationList(List<AppointmentConfigurations> af) {
    appointmentConfigurationList = af;
    update();
  }

  // AppointmentConfigurations? selectedappointmentConfiguration;
  // updateAppintmentConfiguration(AppointmentConfigurations af) {
  //   selectedappointmentConfiguration = af;
  //   update();
  // }

  BasicInfo? selectedbasicInfo;
  updatedDoctorInfo(BasicInfo bi) {
    selectedbasicInfo = bi;
    EditProfileController.i.firstname.text = selectedbasicInfo?.firstName ?? "";
    EditProfileController.i.middlename.text =
        selectedbasicInfo?.middleName ?? "";
    EditProfileController.i.lastname.text = selectedbasicInfo?.lastName ?? "";

    // if (selectedbasicInfo?.cNICNumber == null) {
    //   EditProfileController.i.idnumber.text =
    //       selectedbasicInfo?.passportNumber ?? "";
    //   EditProfileController.i.updateRadioValue('passport');
    // } else if (selectedbasicInfo?.passportNumber == null) {
    //   EditProfileController.i.idnumber.text =
    //       selectedbasicInfo?.cNICNumber ?? "";
    //   EditProfileController.i.updateRadioValue('idno');
    // }

    EditProfileController.i.idnumber.text =
        selectedbasicInfo?.cNICNumber.toString() ?? "";
    EditProfileController.i.passportno.text =
        selectedbasicInfo?.passportNumber.toString() ?? "";

    EditProfileController.i.imcno.text =
        selectedbasicInfo?.pMDCNumber.toString() ?? "";
    EditProfileController.i.ntnnumber.text =
        selectedbasicInfo?.nTNNo.toString() ?? "";
    EditProfileController.i.consultancyfee.text =
        selectedbasicInfo?.consultationFee.toString() ?? "";

    EditProfileController.i.followupfee.text =
        selectedbasicInfo?.followUpFee.toString() ?? "";
    EditProfileController.i.guardianname.text =
        selectedbasicInfo?.guardianName ?? "";
    EditProfileController.i.addressController.text =
        selectedbasicInfo?.address ?? "";
    EditProfileController.i.publicmobileno.text =
        selectedbasicInfo?.contactPublic.toString() ?? "";
    EditProfileController.i.privatemobileno.text =
        selectedbasicInfo?.cellNumber.toString() ?? "";
    EditProfileController.i.telephone.text =
        selectedbasicInfo?.telephoneNumber.toString() ?? "";
    EditProfileController.i.emailController.text =
        selectedbasicInfo?.email.toString() ?? "";

    EditProfileController.i.nokfirstname.text =
        selectedbasicInfo?.nOKFirstName ?? "";
    EditProfileController.i.noklastname.text =
        selectedbasicInfo?.nOKLastName ?? "";
    EditProfileController.i.nokidno.text =
        selectedbasicInfo?.nOKCNICNumber.toString() ?? "";

    EditProfileController.i.nokmobileno.text =
        selectedbasicInfo?.nOKCellNumber.toString() ?? "";

    if (selectedbasicInfo?.personTitleId != null) {
      EditProfileController.i.selectedpersonalTitle?.name =
          selectedbasicInfo?.personTitle ?? "";
      EditProfileController.i.selectedpersonalTitle?.id =
          selectedbasicInfo?.personTitleId ?? "";
    } else {
      EditProfileController.i.selectedpersonalTitle?.name = "Other";
      EditProfileController.i.selectedpersonalTitle?.id = "";

      EditProfileController.i.customprefixtitle.text =
          selectedbasicInfo?.prefix ?? "";
    }

    EditProfileController.i.selectedgender?.name =
        selectedbasicInfo?.genderName ?? "";
    EditProfileController.i.selectedgender?.id =
        selectedbasicInfo?.genderId ?? "";

    EditProfileController.i.selectedmaritalStatus?.name =
        selectedbasicInfo?.maritalStatusName ?? "";
    EditProfileController.i.selectedmaritalStatus?.id =
        selectedbasicInfo?.maritalStatusId ?? "";

    EditProfileController.i.selectedbloodgroup?.name =
        selectedbasicInfo?.bloodGroupName ?? "";
    EditProfileController.i.selectedbloodgroup?.id =
        selectedbasicInfo?.bloodGroupId ?? "";

    EditProfileController.i.selectedreligion?.name =
        selectedbasicInfo?.religionName ?? "";
    EditProfileController.i.selectedreligion?.id =
        selectedbasicInfo?.religionId ?? "";

    EditProfileController.i.selectedrelation?.name =
        selectedbasicInfo?.relationshipTypeName ?? "";
    EditProfileController.i.selectedrelation?.id =
        selectedbasicInfo?.relationshipTypeId ?? "";

    EditProfileController.i.formattedArrival =
        selectedbasicInfo?.dateofBirth ?? "";

    EditProfileController.i.selectedcountry?.name =
        selectedbasicInfo?.countryName ?? "";
    EditProfileController.i.selectedcountry?.id =
        selectedbasicInfo?.countryId ?? "";

    EditProfileController.i.selectedprovince?.name =
        selectedbasicInfo?.stateName ?? "";
    EditProfileController.i.selectedprovince?.id =
        selectedbasicInfo?.stateOrProvinceId ?? "";

    EditProfileController.i.selectedcity?.name =
        selectedbasicInfo?.cityName ?? "";
    EditProfileController.i.selectedcity?.id = selectedbasicInfo?.cityId ?? "";

    EditProfileController.i.selectednokrelation?.name =
        selectedbasicInfo?.nOKRelationName ?? "";
    EditProfileController.i.selectednokrelation?.id =
        selectedbasicInfo?.nOKRelationshipTypeId ?? "";

    // APPOINTMENT CONFIGURATION

    EditProfileController.i.displayeducation.text =
        selectedbasicInfo?.userDisplayEducation ?? "";
    EditProfileController.i.displaydesignation.text =
        selectedbasicInfo?.userDisplayDesignation ?? "";

    EditProfileController.i.stamp.text = selectedbasicInfo?.stamp ?? "";
    EditProfileController.i.professionalsummary.text =
        selectedbasicInfo?.professionalSummary ?? "";
    EditProfileController.i.topmargin.text =
        selectedbasicInfo?.marginTop.toString() ?? "";
    EditProfileController.i.bottommargin.text =
        selectedbasicInfo?.marginBottom.toString() ?? "";
    EditProfileController.i.displayenglisheducation.text =
        selectedbasicInfo?.educationEnglish ?? "";
    EditProfileController.i.displayenglishdesignation.text =
        selectedbasicInfo?.designationEnglish ?? "";
    EditProfileController.i.displayenglishothers.text =
        selectedbasicInfo?.othersEnglish ?? "";

    EditProfileController.i.displayurdueducation.text =
        selectedbasicInfo?.educationUrdu ?? "";
    EditProfileController.i.displayurdudesignation.text =
        selectedbasicInfo?.designationUrdu ?? "";
    EditProfileController.i.displayurduothers.text =
        selectedbasicInfo?.othersUrdu ?? "";
    update();
  }

  int tabindex = 0;

  updateselectedindex(int ind) {
    tabindex = ind;
    update();
  }

  int pageindex = 0;
  updatepageindex(index) {
    pageIndex = index;
    update();
  }
}
