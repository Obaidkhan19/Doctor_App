
class SearchDoctors {
  int? status;
  List<Search>? data;
  int? totalRecord;
  int? filterRecord;

  SearchDoctors({this.status, this.data, this.totalRecord, this.filterRecord});

  SearchDoctors.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <Search>[];
      json['Data'].forEach((v) {
        data!.add(Search.fromJson(v));
      });
    }
    totalRecord = json['TotalRecord'];
    filterRecord = json['FilterRecord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['TotalRecord'] = totalRecord;
    data['FilterRecord'] = filterRecord;
    return data;
  }
}

class Search {
  String? id;
  String? name;
  String? designation;
  String? qualification;
  int? sunday;
  int? monday;
  int? tuesday;
  int? wednesday;
  int? thursday;
  int? friday;
  int? saturday;
  bool? isOnline;
  bool? isBusy;
  String? picturePath;
  String? location;
  int? noOfVotes;
  double? consultancyFee;
  String? speciality;
  String? subSpeciality;
  int? numberofExpereinceyear;
  double? onlineVideoConsultationFee;
  String? isFavouriteDoctor;
  bool? isOnlineConfigAvailable;
  bool? isConsultNow;
  String? branchId;
  List<Locations>? locations;

  Search(
      {this.id,
      this.name,
      this.designation,
      this.qualification,
      this.sunday,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.isOnline,
      this.isBusy,
      this.picturePath,
      this.location,
      this.noOfVotes,
      this.consultancyFee,
      this.speciality,
      this.subSpeciality,
      this.numberofExpereinceyear,
      this.onlineVideoConsultationFee,
      this.isFavouriteDoctor,
      this.isOnlineConfigAvailable,
      this.isConsultNow,
      this.branchId,
      this.locations});

  Search.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    designation = json['Designation'];
    qualification = json['Qualification'];
    sunday = json['Sunday'];
    monday = json['Monday'];
    tuesday = json['Tuesday'];
    wednesday = json['Wednesday'];
    thursday = json['Thursday'];
    friday = json['Friday'];
    saturday = json['Saturday'];
    isOnline = json['IsOnline'];
    isBusy = json['IsBusy'];
    picturePath = json['PicturePath'];
    location = json['Location'];
    noOfVotes = json['NoOfVotes'];
    consultancyFee = json['ConsultancyFee'];
    speciality = json['Speciality'];
    subSpeciality = json['SubSpeciality'];
    numberofExpereinceyear = json['NumberofExpereinceyear'];
    onlineVideoConsultationFee = json['OnlineVideoConsultationFee'];
    isFavouriteDoctor = json['IsFavouriteDoctor'];
    isOnlineConfigAvailable = json['IsOnlineConfigAvailable'];
    isConsultNow = json['IsConsultNow'];
    branchId = json['BranchId'];
    if (json['Locations'] != null) {
      locations = <Locations>[];
      json['Locations'].forEach((v) {
        locations!.add( Locations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Designation'] = designation;
    data['Qualification'] = qualification;
    data['Sunday'] = sunday;
    data['Monday'] = monday;
    data['Tuesday'] = tuesday;
    data['Wednesday'] = wednesday;
    data['Thursday'] = thursday;
    data['Friday'] = friday;
    data['Saturday'] = saturday;
    data['IsOnline'] = isOnline;
    data['IsBusy'] = isBusy;
    data['PicturePath'] = picturePath;
    data['Location'] = location;
    data['NoOfVotes'] = noOfVotes;
    data['ConsultancyFee'] = consultancyFee;
    data['Speciality'] = speciality;
    data['SubSpeciality'] = subSpeciality;
    data['NumberofExpereinceyear'] = numberofExpereinceyear;
    data['OnlineVideoConsultationFee'] = onlineVideoConsultationFee;
    data['IsFavouriteDoctor'] = isFavouriteDoctor;
    data['IsOnlineConfigAvailable'] = isOnlineConfigAvailable;
    data['IsConsultNow'] = isConsultNow;
    data['BranchId'] = branchId;
    if (locations != null) {
      data['Locations'] = locations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Locations {
  String? name;
  String? address;
  String? cityName;
  double? consultancyFee;
  String? doctorId;

  Locations(
      {this.name,
      this.address,
      this.cityName,
      this.consultancyFee,
      this.doctorId});

  Locations.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    address = json['Address'];
    cityName = json['CityName'];
    consultancyFee = json['ConsultancyFee'];
    doctorId = json['DoctorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['Address'] = address;
    data['CityName'] = cityName;
    data['ConsultancyFee'] = consultancyFee;
    data['DoctorId'] = doctorId;
    return data;
  }
}



