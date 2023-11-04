class degreesmodel {
  int? status;
  List<Degrees>? degrees;

  degreesmodel({this.status, this.degrees});

  degreesmodel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Degrees'] != null) {
      degrees = <Degrees>[];
      json['Degrees'].forEach((v) {
        degrees!.add(Degrees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (degrees != null) {
      data['Degrees'] = degrees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Degrees {
  String? id;
  String? name;

  Degrees({this.id, this.name});

  Degrees.fromJson(Map<String, dynamic> json) {
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
