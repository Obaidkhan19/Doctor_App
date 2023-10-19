class Investigation {
  int? status;
  List<Investigations1>? investigations;

  Investigation({this.status, this.investigations});

  Investigation.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Investigations'] != null) {
      investigations = <Investigations1>[];
      json['Investigations'].forEach((v) {
        investigations!.add(Investigations1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (investigations != null) {
      data['Investigations'] = investigations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Investigations1 {
  String? id;
  String? name;
  String? code;
  String? comments;

  Investigations1({this.id, this.name, this.code, this.comments});

  Investigations1.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    code = json['Code'];
    comments = json['Comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Code'] = code;
    data['Comments'] = comments;
    return data;
  }
}
