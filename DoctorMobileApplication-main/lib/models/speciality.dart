class Specialities {
  int? status;
  List<Specialities>? specialities;

  Specialities({this.status, this.specialities});

  Specialities.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Specialities'] != null) {
      specialities = <Specialities>[];
      json['Specialities'].forEach((v) {
        specialities!.add(Specialities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (specialities != null) {
      data['Specialities'] = specialities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Specialities1 {
  String? id;
  String? name;
  String? description;
  String? icon;
  dynamic subSpecialities;
  dynamic keyWords;

  Specialities1(
      {this.id,
      this.name,
      this.description,
      this.icon,
      this.subSpecialities,
      this.keyWords});

  Specialities1.fromJson(Map<String, dynamic> json) {
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
