import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doctormobileapplication/utils/constants.dart';

class Medicines {
  int? status;
  List<Medicines>? medicines;

  Medicines({this.status, this.medicines});

  Medicines.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Medicines'] != null) {
      medicines = <Medicines>[];
      json['Medicines'].forEach((v) {
        medicines!.add(Medicines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (medicines != null) {
      data['Medicines'] = medicines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Medicines1 {
  String? id;
  String? name;
  String? generic;
  String? dosage;
  String? type;
  String? medicine;
  String? medicineDosageId;
  String? medicineRouteId;
  String? medicineId;
  String? medicineStrengthId;
  String? numericDisplay;
  dynamic quantity;
  String? route;
  String? strength;
  dynamic frequency;
  String? urduRoute;
  String? urduDosage;
  dynamic totalItemsInStock;
  String? urduType;
  dynamic dosageValue;
  String? possibleDurations;
  String? ophthType;

  Medicines1(
      {this.id,
      this.name,
      this.generic,
      this.dosage,
      this.type,
      this.medicine,
      this.medicineDosageId,
      this.medicineRouteId,
      this.medicineId,
      this.medicineStrengthId,
      this.numericDisplay,
      this.quantity,
      this.route,
      this.strength,
      this.frequency,
      this.urduRoute,
      this.urduDosage,
      this.totalItemsInStock,
      this.urduType,
      this.dosageValue,
      this.possibleDurations,
      this.ophthType});

  Medicines1.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    generic = json['Generic'];
    dosage = json['Dosage'];
    type = json['Type'];
    medicine = json['Medicine'];
    medicineDosageId = json['MedicineDosageId'];
    medicineRouteId = json['MedicineRouteId'];
    medicineId = json['Medicine_Id'];
    medicineStrengthId = json['MedicineStrength_Id'];
    numericDisplay = json['NumericDisplay'];
    quantity = json['Quantity'];
    route = json['Route'];
    strength = json['Strength'];
    frequency = json['Frequency'];
    urduRoute = json['UrduRoute'];
    urduDosage = json['UrduDosage'];
    totalItemsInStock = json['TotalItemsInStock'];
    urduType = json['UrduType'];
    dosageValue = json['DosageValue'];
    possibleDurations = json['PossibleDurations'];
    ophthType = json['OphthType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Generic'] = generic;
    data['Dosage'] = dosage;
    data['Type'] = type;
    data['Medicine'] = medicine;
    data['MedicineDosageId'] = medicineDosageId;
    data['MedicineRouteId'] = medicineRouteId;
    data['Medicine_Id'] = medicineId;
    data['MedicineStrength_Id'] = medicineStrengthId;
    data['NumericDisplay'] = numericDisplay;
    data['Quantity'] = quantity;
    data['Route'] = route;
    data['Strength'] = strength;
    data['Frequency'] = frequency;
    data['UrduRoute'] = urduRoute;
    data['UrduDosage'] = urduDosage;
    data['TotalItemsInStock'] = totalItemsInStock;
    data['UrduType'] = urduType;
    data['DosageValue'] = dosageValue;
    data['PossibleDurations'] = possibleDurations;
    data['OphthType'] = ophthType;
    return data;
  }

  Future<List<Medicines1>> getMedicines(dynamic pl, dynamic did, dynamic tid,
      dynamic search, dynamic bid, dynamic pno, dynamic token) async {
    String url = AppConstants.getMedicines;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "PageLength": pl,
      "DoctorId": did,
      "TemplateId": tid,
      "Search": search,
      "BranchId": bid,
      "PageNumber": pno,
      "Token": token
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Medicines'];
      List<Medicines1> medicinesList =
          data.map((json) => Medicines1.fromJson(json)).toList();
      return medicinesList;
    } else {
      throw Exception('Failed to fetch medicines details');
    }
  }

  Future<List<Medicines1>> getMedicinesByGroupId(
      dynamic did, dynamic bid, dynamic gid, dynamic token) async {
    String url = AppConstants.getMedicinesByGroupId;
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "DoctorId": did,
      "BranchId": bid,
      "GroupId": gid,
      "Token": token
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Medicines'];
      List<Medicines1> medicinesList =
          data.map((json) => Medicines1.fromJson(json)).toList();
      return medicinesList;
    } else {
      throw Exception('Failed to fetch medicines details');
    }
  }
}
