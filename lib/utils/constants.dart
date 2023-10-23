import 'dart:ui';

import 'package:doctormobileapplication/models/language_model.dart';
import 'package:get/get.dart';

class AppConstants {
  // Base Url
  static const String testing = 'http://192.168.88.254:324'; // for testing QA

  static const String baseURL = 'http://192.168.88.254:324';

  // static const String baseURL = 'https://patient.helpful.ihealthcure.com';

  // Branch ID
  //static const String branchID = "D8340ED5-AF5D-4F68-895B-0350114AAB09";
  // API Endpoints
  static const String getLabs = '$baseURL/api/labs/GetLabs';
  static const String getLabTests = '$baseURL/api/labs/GetLabTests';
  static const String getPackages =
      '$baseURL/api/Appointment/GetPackageGroupServicesDetail';
  static const String getSpecialities = '$baseURL/api/ddl/GetSpecialities';
  static const String getSubSpecialities =
      '$baseURL/api/ddl/GetSubSpecialities';
  static const String searchDoctor = '$baseURL/api/appointment/searchdoctor';
  static const String signup = '$baseURL/api/SignUp';
  static const String login = '$baseURL/api/doctor/Signin';
  static const String getGenders = '$baseURL/api/ddl/GetGenders';
  static const String getMaritalStatus = '$baseURL/api/ddl/GetMaritalStatuses';
  static const String getTitle = '$baseURL/api/ddl/GetPersonTitle';
  static const String getCountries = '$baseURL/api/ddl/GetCountries';
  static const String getStatesOrProvince =
      '$baseURL/api/ddl/GetStateOrProvinces';
  static const String getCities = '$baseURL/api/ddl/GetCities';
  static const String deleteAccountURI =
      '$baseURL/api/account/DeletePatientAccount';

  static const String getDoctorBasicInfo =
      "$baseURL/api/account/GetDoctorDetail";
  static const String updatedoctorprofile =
      "$baseURL/api/doctor/UpdatePersonalInfo";

  static const String signupdoctor =
      "$baseURL/api/doctor/SignUp"; //http://58.65.158.107:64

  static const String changePassword = "$baseURL/api/doctor/ChangePassword";
  static const String forgetPassword = "$baseURL/api/doctor/ForgetPassword";
  static const String newPassword = "$baseURL/api/doctor/ResetPassword";

  static const String usernameavaibility =
      "$baseURL/api/doctor/UserNameAvailibility";
  static const String passportavaibility =
      "$baseURL/api/doctor/PassportNumberAvailibility";
  static const String cnicavaibility = "$baseURL/api/doctor/CNICAvailibility";

  static const String pmdcavaibility = "$baseURL/api/doctor/PMDCAvailibility";
// eRX APIS
static const String pmdcavaibility = "$baseURL/api/doctor/PMDCAvailibility";

  static const String getPatientDetailForPrescription =
      "http://58.65.158.107:64/api/patient/GetPatientDetailForPrescription";
  static const String getComplaints = "$baseURL/api/doctor/GetComplaints";

  static const String getPrimaryDiagnosis = "$baseURL/api/doctor/GetDiagnosis";

  static const String getSecondaryDiagnosis =
      "$baseURL/api/doctor/GetSecondaryDiagnosis";

  static const String getInvestigations =
      "$baseURL/api/doctor/GetInvestigations";

  static const String getBranch = "$baseURL/api/ddl/GetUserBranches";

  static const String getHospital = "$baseURL/api/ddl/GetHospitalORClinics";

  static const String getProcedures = "$baseURL/api/doctor/GetProcedures";

  static const String getInstruction = "$baseURL/api/doctor/GetInstructions";

  static const String getFollowup = "$baseURL/api/doctor/GetFollowUps";

  static const String getDiagnostics = "$baseURL/api/doctor/GetDiagnostics";
  static const String prescribemed = "$baseURL/api/doctor/Prescription";

  static const String getMedicines = "$baseURL/api/doctor/GetMedicineList";

  static const String getMedicinesMatrix =
      "$baseURL/api/doctor/GetMedicineMatrix";
  static const String getErnsHistory =
      "$baseURL/api/patient/GetPatientERNSHistory";
  static const String getErnsDetailHistory =
      "$baseURL/api/patient/GetPatientERNSDetail";

  static const String getMedicinesByGroupId =
      "http://58.65.158.107:64/api/doctor/GetMedicinesByGroupId";

  static const String postPrescription =
      "http://58.65.158.107:64/api/doctor/Prescription";
  // ======================>
  static const String appName = 'Helpful';
  static const String requestText =
      'Muhammad Yousaf has requested to add you as Family Member, if you accept, He/She will be able to see your complete medical history, medical appointments and will be able to reserve appointments on your behalf.';
  static const String appointmentSuccessful =
      'Appointment Successfully Booked. You Will receive a notification and the Rider will Collect the sample from you.';
  static const String appointMentFailed =
      'Appointment failed please check your internet connection then try again.';
  static const String description =
      'Dr. Shaikh Hamid is a highly skilled Cardiology specialist. With extensive expertise in the field, he possesses a deep understanding of cardiovascular diseases and their treatment. Dr. Hamid is committed to providing exceptional patient care and employing the latest advancements in cardiology to improve the lives of his patients. His dedication to research and continuous learning ensures that he stays up-to-date with the most current medical practices.';
  static const String onlineStatus =
      '$baseURL/api/doctor/UpdateUserOnlineStatus';
  static const String logoutApi = '$baseURL/api/doctor/Logoff';
  static const String GetDailyAppointment =
      '$baseURL/api/doctor/GetDailyAppointment';
  static const String GetMonthlyAppointment =
      '$baseURL/api/doctor/GetMonthlyAppointment';
  static const String GetDayAppointment =
      '$baseURL/api/doctor/GetDayAppointment';
  static const String RescheduleApi = '$baseURL/api/doctor/Reschedule';
  static const String ApproveApi = '$baseURL/api/doctor/Approved';
  static const String WaitingQueueApi = '$baseURL/api/doctor/WaitingQueue';
  static const String consultingqueuepatient =
      '$baseURL/api/doctor/GetConsultations';

  static const String consultingqueuewait = '$baseURL/api/doctor/WaitingQueue';

  static const int maximumDataTobeFetched = 25;
  static int myrownumber = 0;

  static List<LanguageModel> languages = [
    LanguageModel(name: 'English', id: 1, locale: const Locale('en', 'US')),
    LanguageModel(name: 'عربي'.tr, id: 2, locale: const Locale('ar', 'SA')),
  ];
}
