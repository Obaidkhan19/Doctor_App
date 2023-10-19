class Specialities {
  int? status;
  List<Data>? data;

  Specialities({this.status, this.data});

  Specialities.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add( Data.fromJson(v));
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

class Data {
  String? id;
  String? name;
  String? description;
  String? icon;
  String? subSpecialities;
  String? keyWords;

  Data(
      {this.id,
      this.name,
      this.description,
      this.icon,
      this.subSpecialities,
      this.keyWords});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    description = json['Description'];
    icon = json['Icon'];
    subSpecialities = json['SubSpecialities'];
    keyWords = json['KeyWords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Description'] = description;
    data['Icon'] = icon;
    data['SubSpecialities'] = subSpecialities;
    data['KeyWords'] = keyWords;
    return data;
  }
}
