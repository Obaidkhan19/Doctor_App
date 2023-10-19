
class ProvincesData {
  int? status;
  List<Provinces>? data;

  ProvincesData({this.status, this.data});

  ProvincesData.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <Provinces>[];
      json['Data'].forEach((v) {
        data!.add(Provinces.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Provinces {
  String? id;
  String? name;

  Provinces({this.id, this.name});

  Provinces.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    return data;
  }
}
