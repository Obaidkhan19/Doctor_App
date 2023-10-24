import 'dart:ui';

import 'package:doctormobileapplication/models/language_model.dart';
import 'package:get/get.dart';

String baseURL = 'http://192.168.88.254:324';

class AppConstants {
  // Base Url
  static const String testing = 'http://192.168.88.254:324'; // for testing QA

  static const String baseURL = 'http://192.168.88.254:324';

  // static const String baseURL = 'https://patient.helpful.ihealthcure.com';

  // Branch ID
  //static  String branchID = "D8340ED5-AF5D-4F68-895B-0350114AAB09";
  // API Endpoints
  static String getLabs = '$baseURL/api/labs/GetLabs';
  static String getLabTests = '$baseURL/api/labs/GetLabTests';
  static String getPackages =
      '$baseURL/api/Appointment/GetPackageGroupServicesDetail';
  static String getSpecialities = '$baseURL/api/ddl/GetSpecialities';
  static String getSubSpecialities = '$baseURL/api/ddl/GetSubSpecialities';
  static String opencallprescription = '$baseURL/api/doctor/OpenPrescription';
  static String searchDoctor = '$baseURL/api/appointment/searchdoctor';
  static String signup = '$baseURL/api/SignUp';
  static String login = '$baseURL/api/doctor/Signin';
  static String getGenders = '$baseURL/api/ddl/GetGenders';
  static String getMaritalStatus = '$baseURL/api/ddl/GetMaritalStatuses';
  static String getTitle = '$baseURL/api/ddl/GetPersonTitle';
  static String getCountries = '$baseURL/api/ddl/GetCountries';
  static String getStatesOrProvince = '$baseURL/api/ddl/GetStateOrProvinces';
  static String getCities = '$baseURL/api/ddl/GetCities';
  static String deleteAccountURI = '$baseURL/api/account/DeletePatientAccount';

  static String getDoctorBasicInfo = "$baseURL/api/account/GetDoctorDetail";
  static String updatedoctorprofile = "$baseURL/api/doctor/UpdatePersonalInfo";

  static String signupdoctor =
      "$baseURL/api/doctor/SignUp"; //http://58.65.158.107:64

  static String changePassword = "$baseURL/api/doctor/ChangePassword";
  static String forgetPassword = "$baseURL/api/doctor/ForgetPassword";
  static String newPassword = "$baseURL/api/doctor/ResetPassword";

  static String usernameavaibility = "$baseURL/api/doctor/UserNameAvailibility";
  static String passportavaibility =
      "$baseURL/api/doctor/PassportNumberAvailibility";
  static String cnicavaibility = "$baseURL/api/doctor/CNICAvailibility";

  static String pmdcavaibility = "$baseURL/api/doctor/PMDCAvailibility";
// eRX APIS

  static String getPatientDetailForPrescription =
      "http://58.65.158.107:64/api/patient/GetPatientDetailForPrescription";
  static String getComplaints = "$baseURL/api/doctor/GetComplaints";

  static String getPrimaryDiagnosis = "$baseURL/api/doctor/GetDiagnosis";

  static String getSecondaryDiagnosis =
      "$baseURL/api/doctor/GetSecondaryDiagnosis";

  static String getInvestigations = "$baseURL/api/doctor/GetInvestigations";

  static String getBranch = "$baseURL/api/ddl/GetUserBranches";

  static const String getHospital = "$baseURL/api/ddl/GetHospitalORClinics";

  static String getProcedures = "$baseURL/api/doctor/GetProcedures";

  static String getInstruction = "$baseURL/api/doctor/GetInstructions";

  static String getFollowup = "$baseURL/api/doctor/GetFollowUps";

  static String getDiagnostics = "$baseURL/api/doctor/GetDiagnostics";
  static String prescribemed = "$baseURL/api/doctor/Prescription";

  static String getMedicines = "$baseURL/api/doctor/GetMedicineList";

  static String getMedicinesMatrix = "$baseURL/api/doctor/GetMedicineMatrix";
  static String getErnsHistory = "$baseURL/api/patient/GetPatientERNSHistory";
  static String getErnsDetailHistory =
      "$baseURL/api/patient/GetPatientERNSDetail";

  static String getMedicinesByGroupId =
      "http://58.65.158.107:64/api/doctor/GetMedicinesByGroupId";

  static String postPrescription =
      "http://58.65.158.107:64/api/doctor/Prescription";
  // ======================>
  static String appName = 'Helpful';
  static String requestText =
      'Muhammad Yousaf has requested to add you as Family Member, if you accept, He/She will be able to see your complete medical history, medical appointments and will be able to reserve appointments on your behalf.';
  static String appointmentSuccessful =
      'Appointment Successfully Booked. You Will receive a notification and the Rider will Collect the sample from you.';
  static String appointMentFailed =
      'Appointment failed please check your internet connection then try again.';
  static String description =
      'Dr. Shaikh Hamid is a highly skilled Cardiology specialist. With extensive expertise in the field, he possesses a deep understanding of cardiovascular diseases and their treatment. Dr. Hamid is committed to providing exceptional patient care and employing the latest advancements in cardiology to improve the lives of his patients. His dedication to research and continuous learning ensures that he stays up-to-date with the most current medical practices.';
  static String onlineStatus = '$baseURL/api/doctor/UpdateUserOnlineStatus';
  static String logoutApi = '$baseURL/api/doctor/Logoff';
  static String GetDailyAppointment = '$baseURL/api/doctor/GetDailyAppointment';
  static String GetMonthlyAppointment =
      '$baseURL/api/doctor/GetMonthlyAppointment';
  static String GetDayAppointment = '$baseURL/api/doctor/GetDayAppointment';
  static String RescheduleApi = '$baseURL/api/doctor/Reschedule';
  static String ApproveApi = '$baseURL/api/doctor/Approved';
  static String WaitingQueueApi = '$baseURL/api/doctor/WaitingQueue';
  static String consultingqueuepatient = '$baseURL/api/doctor/GetConsultations';

  static String consultingqueuewait = '$baseURL/api/doctor/WaitingQueue';

  static const int maximumDataTobeFetched = 25;
  static int myrownumber = 0;

  static List<LanguageModel> languages = [
    LanguageModel(name: 'English', id: 1, locale: const Locale('en', 'US')),
    LanguageModel(name: 'عربي'.tr, id: 2, locale: const Locale('ar', 'SA')),
  ];
}
