// import 'dart:convert';
// import 'package:doctormobileapplication/components/custom_checkbox_dropdown.dart';
// import 'package:http/http.dart' as http;
// import 'package:doctormobileapplication/utils/constants.dart';

// getDiagnostics() async {
//   String url = AppConstants.postPrescription;
//   Uri uri = Uri.parse(url);
//   var body = jsonEncode(<String, dynamic>{
//     "Advice": ,
//     "BranchId": ,
//     "Diabetic": ,
//     "Smoker":
//     "DoctorId": ,
//     "Token":,
//     "VisitNo":,
//     "Complaints":,
//     "Diagnosis":,
//     "Diagnostics":
//     "ExamFinding":
//     "FollowUps":
//     "Instructions":
//     "Investigations":
//     "Procedures":
//     "SecondayDiagnosis":
//   });
//   var response = await http.post(uri,
//       body: body,
//       headers: <String, String>{'Content-Type': 'application/json'});
//   if (response.statusCode == 200) {
//     dynamic jsonData = jsonDecode(response.body);
//     print(response.body);
//     return response.body;
//   } else {
//     throw Exception('Failed to fetch patient details');
//   }
// }
