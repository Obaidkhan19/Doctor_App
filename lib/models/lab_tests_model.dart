class LabTestsModel {
  int? status;
  List<Data>? data;
  String? errorMessage;

  LabTestsModel({this.status, this.data, this.errorMessage});

  LabTestsModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['ErrorMessage'] = errorMessage;
    return data;
  }
}

class Data {
  String? id;
  String? name;
  double? price;
  double? actualPrice;
  bool? isForSampleCollectionCharges;
  bool? isForAdditionalCharges;
  bool? isForUrgentCharges;
  bool? isAdditionalChargesForPassenger;
  bool? isForCovid;
  bool? isForAdditionalChargesForCovid;

  Data(
      {this.id,
      this.name,
      this.price,
      this.actualPrice,
      this.isForSampleCollectionCharges,
      this.isForAdditionalCharges,
      this.isForUrgentCharges,
      this.isAdditionalChargesForPassenger,
      this.isForCovid,
      this.isForAdditionalChargesForCovid});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    price = json['Price'];
    actualPrice = json['ActualPrice'];
    isForSampleCollectionCharges = json['IsForSampleCollectionCharges'];
    isForAdditionalCharges = json['IsForAdditionalCharges'];
    isForUrgentCharges = json['IsForUrgentCharges'];
    isAdditionalChargesForPassenger = json['IsAdditionalChargesForPassenger'];
    isForCovid = json['IsForCovid'];
    isForAdditionalChargesForCovid = json['IsForAdditionalChargesForCovid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Price'] = price;
    data['ActualPrice'] = actualPrice;
    data['IsForSampleCollectionCharges'] = isForSampleCollectionCharges;
    data['IsForAdditionalCharges'] = isForAdditionalCharges;
    data['IsForUrgentCharges'] = isForUrgentCharges;
    data['IsAdditionalChargesForPassenger'] = isAdditionalChargesForPassenger;
    data['IsForCovid'] = isForCovid;
    data['IsForAdditionalChargesForCovid'] = isForAdditionalChargesForCovid;
    return data;
  }
}
