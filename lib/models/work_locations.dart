class worklocation {
  int? status;
  List<WorkLocations>? workLocations;

  worklocation({this.status, this.workLocations});

  worklocation.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['WorkLocations'] != null) {
      workLocations = <WorkLocations>[];
      json['WorkLocations'].forEach((v) {
        workLocations!.add(WorkLocations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (workLocations != null) {
      data['WorkLocations'] = workLocations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkLocations {
  String? id;
  String? workLocationName;
  String? branchName;
  String? branchId;
  int? preference;
  String? userWorkLocationId;

  WorkLocations(
      {this.id,
      this.workLocationName,
      this.branchName,
      this.branchId,
      this.preference,
      this.userWorkLocationId});

  WorkLocations.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    workLocationName = json['WorkLocationName'];
    branchName = json['BranchName'];
    branchId = json['BranchId'];
    preference = json['Preference'];
    userWorkLocationId = json['UserWorkLocationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['WorkLocationName'] = workLocationName;
    data['BranchName'] = branchName;
    data['BranchId'] = branchId;
    data['Preference'] = preference;
    data['UserWorkLocationId'] = userWorkLocationId;
    return data;
  }
}
