class DoctorDetails {
  int? status;
  BasicInfo? basicInfo;
  List<Educations>? educations;
  List<Expereinces>? expereinces;
  List<Specialities>? specialities;
  List<Memberships>? memberships;
  List<Awards>? awards;
  List<BankAccounts>? bankAccounts;
  List<AppointmentConfigurations>? appointmentConfigurations;

  DoctorDetails(
      {this.status,
      this.basicInfo,
      this.educations,
      this.expereinces,
      this.specialities,
      this.memberships,
      this.awards,
      this.bankAccounts,
      this.appointmentConfigurations});

  DoctorDetails.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    basicInfo = json['BasicInfo'] != null
        ? BasicInfo.fromJson(json['BasicInfo'])
        : null;
    if (json['Educations'] != null) {
      educations = <Educations>[];
      json['Educations'].forEach((v) {
        educations!.add(Educations.fromJson(v));
      });
    }
    if (json['Expereinces'] != null) {
      expereinces = <Expereinces>[];
      json['Expereinces'].forEach((v) {
        expereinces!.add(Expereinces.fromJson(v));
      });
    }
    if (json['Specialities'] != null) {
      specialities = <Specialities>[];
      json['Specialities'].forEach((v) {
        specialities!.add(Specialities.fromJson(v));
      });
    }
    if (json['Memberships'] != null) {
      memberships = <Memberships>[];
      json['Memberships'].forEach((v) {
        memberships!.add(Memberships.fromJson(v));
      });
    }
    if (json['Awards'] != null) {
      awards = <Awards>[];
      json['Awards'].forEach((v) {
        awards!.add(Awards.fromJson(v));
      });
    }
    if (json['BankAccounts'] != null) {
      bankAccounts = <BankAccounts>[];
      json['BankAccounts'].forEach((v) {
        bankAccounts!.add(BankAccounts.fromJson(v));
      });
    }
    if (json['AppointmentConfigurations'] != null) {
      appointmentConfigurations = <AppointmentConfigurations>[];
      json['AppointmentConfigurations'].forEach((v) {
        appointmentConfigurations!.add(AppointmentConfigurations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (basicInfo != null) {
      data['BasicInfo'] = basicInfo!.toJson();
    }
    if (educations != null) {
      data['Educations'] = educations!.map((v) => v.toJson()).toList();
    }
    if (expereinces != null) {
      data['Expereinces'] = expereinces!.map((v) => v.toJson()).toList();
    }
    if (specialities != null) {
      data['Specialities'] = specialities!.map((v) => v.toJson()).toList();
    }
    if (memberships != null) {
      data['Memberships'] = memberships!.map((v) => v.toJson()).toList();
    }
    if (awards != null) {
      data['Awards'] = awards!.map((v) => v.toJson()).toList();
    }
    if (bankAccounts != null) {
      data['BankAccounts'] = bankAccounts!.map((v) => v.toJson()).toList();
    }
    if (appointmentConfigurations != null) {
      data['AppointmentConfigurations'] =
          appointmentConfigurations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BasicInfo {
  dynamic id;
  dynamic personTitleId;
  dynamic prefix;
  dynamic personTitle;
  dynamic firstName;
  dynamic lastName;
  dynamic middleName;
  dynamic dateofBirth;
  dynamic maritalStatusName;
  dynamic maritalStatusId;
  dynamic relationshipTypeId;
  dynamic relationshipTypeName;
  dynamic guardianName;
  dynamic cNICNumber;
  dynamic passportNumber;
  dynamic genderId;
  dynamic genderName;
  dynamic pMDCNumber;
  dynamic pMDCCertificateAttachment;
  dynamic nTNNo;
  dynamic bloodGroupName;
  dynamic bloodGroupId;
  dynamic religionName;
  dynamic religionId;
  dynamic picturePath;
  dynamic username;
  dynamic fullName;
  dynamic password;
  dynamic designationId;
  dynamic designation;
  dynamic designationIds;
  dynamic branchId;
  dynamic userTypeId;
  dynamic userTypeName;
  dynamic countryId;
  dynamic countryName;
  dynamic stateOrProvinceId;
  dynamic stateName;
  dynamic cityId;
  dynamic cityName;
  dynamic address;
  dynamic cellNumber;
  dynamic telephoneNumber;
  dynamic contactPublic;
  dynamic email;
  dynamic nOKFirstName;
  dynamic nOKLastName;
  dynamic nOKCNICNumber;
  dynamic nOKCellNumber;
  dynamic nOKRelationshipTypeId;
  dynamic nOKRelationName;
  dynamic consulatedCount;
  dynamic totalExperience;
  dynamic age;
  dynamic userDisplayDesignation;
  dynamic userDisplayEducation;
  dynamic stamp;
  dynamic marginTop;
  dynamic marginBottom;
  dynamic educationEnglish;
  dynamic educationUrdu;
  dynamic designationEnglish;
  dynamic designationUrdu;
  dynamic othersEnglish;
  dynamic othersUrdu;
  dynamic isBoldEduEng;
  dynamic isBoldEduUrdu;
  dynamic isBoldDesignEng;
  dynamic isBoldDesignUrdu;
  dynamic isBoldOthersEng;
  dynamic isBoldOthersUrdu;
  dynamic isHideMedicineDuration;
  dynamic medicineDisplayType;
  dynamic prescriptionEngHeader;
  dynamic prescriptionUrduHeader;
  dynamic prescriptionTopMargin;
  dynamic professionalSummary;
  dynamic consultationFee;
  dynamic followUpFee;

  BasicInfo(
      {this.id,
      this.personTitleId,
      this.prefix,
      this.personTitle,
      this.firstName,
      this.lastName,
      this.middleName,
      this.dateofBirth,
      this.maritalStatusName,
      this.maritalStatusId,
      this.relationshipTypeId,
      this.relationshipTypeName,
      this.guardianName,
      this.cNICNumber,
      this.passportNumber,
      this.genderId,
      this.genderName,
      this.pMDCNumber,
      this.pMDCCertificateAttachment,
      this.nTNNo,
      this.bloodGroupName,
      this.bloodGroupId,
      this.religionName,
      this.religionId,
      this.picturePath,
      this.username,
      this.fullName,
      this.password,
      this.designationId,
      this.designation,
      this.designationIds,
      this.branchId,
      this.userTypeId,
      this.userTypeName,
      this.countryId,
      this.countryName,
      this.stateOrProvinceId,
      this.stateName,
      this.cityId,
      this.cityName,
      this.address,
      this.cellNumber,
      this.telephoneNumber,
      this.contactPublic,
      this.email,
      this.nOKFirstName,
      this.nOKLastName,
      this.nOKCNICNumber,
      this.nOKCellNumber,
      this.nOKRelationshipTypeId,
      this.nOKRelationName,
      this.consulatedCount,
      this.totalExperience,
      this.age,
      this.userDisplayDesignation,
      this.userDisplayEducation,
      this.stamp,
      this.marginTop,
      this.marginBottom,
      this.educationEnglish,
      this.educationUrdu,
      this.designationEnglish,
      this.designationUrdu,
      this.othersEnglish,
      this.othersUrdu,
      this.isBoldEduEng,
      this.isBoldEduUrdu,
      this.isBoldDesignEng,
      this.isBoldDesignUrdu,
      this.isBoldOthersEng,
      this.isBoldOthersUrdu,
      this.isHideMedicineDuration,
      this.medicineDisplayType,
      this.prescriptionEngHeader,
      this.prescriptionUrduHeader,
      this.prescriptionTopMargin,
      this.professionalSummary,
      this.consultationFee,
      this.followUpFee});

  BasicInfo.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    personTitleId = json['PersonTitleId'];
    prefix = json['Prefix'];
    personTitle = json['PersonTitle'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    middleName = json['MiddleName'];
    dateofBirth = json['DateofBirth'];
    maritalStatusName = json['MaritalStatusName'];
    maritalStatusId = json['MaritalStatusId'];
    relationshipTypeId = json['RelationshipTypeId'];
    relationshipTypeName = json['RelationshipTypeName'];
    guardianName = json['GuardianName'];
    cNICNumber = json['CNICNumber'];
    passportNumber = json['PassportNumber'];
    genderId = json['GenderId'];
    genderName = json['GenderName'];
    pMDCNumber = json['PMDCNumber'];
    pMDCCertificateAttachment = json['PMDCCertificateAttachment'];
    nTNNo = json['NTNNo'];
    bloodGroupName = json['BloodGroupName'];
    bloodGroupId = json['BloodGroupId'];
    religionName = json['ReligionName'];
    religionId = json['ReligionId'];
    picturePath = json['PicturePath'];
    username = json['Username'];
    fullName = json['FullName'];
    password = json['Password'];
    designationId = json['DesignationId'];
    designation = json['Designation'];
    designationIds = json['DesignationIds'];
    branchId = json['BranchId'];
    userTypeId = json['UserTypeId'];
    userTypeName = json['UserTypeName'];
    countryId = json['CountryId'];
    countryName = json['CountryName'];
    stateOrProvinceId = json['StateOrProvinceId'];
    stateName = json['StateName'];
    cityId = json['CityId'];
    cityName = json['cityName'];
    address = json['Address'];
    cellNumber = json['CellNumber'];
    telephoneNumber = json['TelephoneNumber'];
    contactPublic = json['ContactPublic'];
    email = json['Email'];
    nOKFirstName = json['NOKFirstName'];
    nOKLastName = json['NOKLastName'];
    nOKCNICNumber = json['NOKCNICNumber'];
    nOKCellNumber = json['NOKCellNumber'];
    nOKRelationshipTypeId = json['NOKRelationshipTypeId'];
    nOKRelationName = json['NOKRelationName'];
    consulatedCount = json['ConsulatedCount'];
    totalExperience = json['TotalExperience'];
    age = json['Age'];
    userDisplayDesignation = json['UserDisplayDesignation'];
    userDisplayEducation = json['UserDisplayEducation'];
    stamp = json['Stamp'];
    marginTop = json['MarginTop'];
    marginBottom = json['MarginBottom'];
    educationEnglish = json['EducationEnglish'];
    educationUrdu = json['EducationUrdu'];
    designationEnglish = json['DesignationEnglish'];
    designationUrdu = json['DesignationUrdu'];
    othersEnglish = json['OthersEnglish'];
    othersUrdu = json['OthersUrdu'];
    isBoldEduEng = json['IsBoldEduEng'];
    isBoldEduUrdu = json['IsBoldEduUrdu'];
    isBoldDesignEng = json['IsBoldDesignEng'];
    isBoldDesignUrdu = json['IsBoldDesignUrdu'];
    isBoldOthersEng = json['IsBoldOthersEng'];
    isBoldOthersUrdu = json['IsBoldOthersUrdu'];
    isHideMedicineDuration = json['IsHideMedicineDuration'];
    medicineDisplayType = json['MedicineDisplayType'];
    prescriptionEngHeader = json['PrescriptionEngHeader'];
    prescriptionUrduHeader = json['PrescriptionUrduHeader'];
    prescriptionTopMargin = json['PrescriptionTopMargin'];
    professionalSummary = json['ProfessionalSummary'];
    consultationFee = json['ConsultationFee'];
    followUpFee = json['FollowUpFee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['PersonTitleId'] = personTitleId;
    data['Prefix'] = prefix;
    data['PersonTitle'] = personTitle;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['MiddleName'] = middleName;
    data['DateofBirth'] = dateofBirth;
    data['MaritalStatusName'] = maritalStatusName;
    data['MaritalStatusId'] = maritalStatusId;
    data['RelationshipTypeId'] = relationshipTypeId;
    data['RelationshipTypeName'] = relationshipTypeName;
    data['GuardianName'] = guardianName;
    data['CNICNumber'] = cNICNumber;
    data['PassportNumber'] = passportNumber;
    data['GenderId'] = genderId;
    data['GenderName'] = genderName;
    data['PMDCNumber'] = pMDCNumber;
    data['PMDCCertificateAttachment'] = pMDCCertificateAttachment;
    data['NTNNo'] = nTNNo;
    data['BloodGroupName'] = bloodGroupName;
    data['BloodGroupId'] = bloodGroupId;
    data['ReligionName'] = religionName;
    data['ReligionId'] = religionId;
    data['PicturePath'] = picturePath;
    data['Username'] = username;
    data['FullName'] = fullName;
    data['Password'] = password;
    data['DesignationId'] = designationId;
    data['Designation'] = designation;
    data['DesignationIds'] = designationIds;
    data['BranchId'] = branchId;
    data['UserTypeId'] = userTypeId;
    data['UserTypeName'] = userTypeName;
    data['CountryId'] = countryId;
    data['CountryName'] = countryName;
    data['StateOrProvinceId'] = stateOrProvinceId;
    data['StateName'] = stateName;
    data['CityId'] = cityId;
    data['cityName'] = cityName;
    data['Address'] = address;
    data['CellNumber'] = cellNumber;
    data['TelephoneNumber'] = telephoneNumber;
    data['ContactPublic'] = contactPublic;
    data['Email'] = email;
    data['NOKFirstName'] = nOKFirstName;
    data['NOKLastName'] = nOKLastName;
    data['NOKCNICNumber'] = nOKCNICNumber;
    data['NOKCellNumber'] = nOKCellNumber;
    data['NOKRelationshipTypeId'] = nOKRelationshipTypeId;
    data['NOKRelationName'] = nOKRelationName;
    data['ConsulatedCount'] = consulatedCount;
    data['TotalExperience'] = totalExperience;
    data['Age'] = age;
    data['UserDisplayDesignation'] = userDisplayDesignation;
    data['UserDisplayEducation'] = userDisplayEducation;
    data['Stamp'] = stamp;
    data['MarginTop'] = marginTop;
    data['MarginBottom'] = marginBottom;
    data['EducationEnglish'] = educationEnglish;
    data['EducationUrdu'] = educationUrdu;
    data['DesignationEnglish'] = designationEnglish;
    data['DesignationUrdu'] = designationUrdu;
    data['OthersEnglish'] = othersEnglish;
    data['OthersUrdu'] = othersUrdu;
    data['IsBoldEduEng'] = isBoldEduEng;
    data['IsBoldEduUrdu'] = isBoldEduUrdu;
    data['IsBoldDesignEng'] = isBoldDesignEng;
    data['IsBoldDesignUrdu'] = isBoldDesignUrdu;
    data['IsBoldOthersEng'] = isBoldOthersEng;
    data['IsBoldOthersUrdu'] = isBoldOthersUrdu;
    data['IsHideMedicineDuration'] = isHideMedicineDuration;
    data['MedicineDisplayType'] = medicineDisplayType;
    data['PrescriptionEngHeader'] = prescriptionEngHeader;
    data['PrescriptionUrduHeader'] = prescriptionUrduHeader;
    data['PrescriptionTopMargin'] = prescriptionTopMargin;
    data['ProfessionalSummary'] = professionalSummary;
    data['ConsultationFee'] = consultationFee;
    data['FollowUpFee'] = followUpFee;
    return data;
  }
}

class Educations {
  String? id;
  String? doctorId;
  String? countryId;
  String? countryName;
  String? institutionId;
  String? instituteName;
  String? degreeId;
  String? degreeName;
  String? fieldOfStudyId;
  String? fieldName;
  String? startDate;
  String? endDate;
  String? issueDate;
  String? gradingCriteria;
  dynamic totalMarks;
  dynamic obtainedMarks;
  dynamic obtainedPercentage;
  dynamic userGrade;

  Educations(
      {this.id,
      this.doctorId,
      this.countryId,
      this.countryName,
      this.institutionId,
      this.instituteName,
      this.degreeId,
      this.degreeName,
      this.fieldOfStudyId,
      this.fieldName,
      this.startDate,
      this.endDate,
      this.issueDate,
      this.gradingCriteria,
      this.totalMarks,
      this.obtainedMarks,
      this.obtainedPercentage,
      this.userGrade});

  Educations.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    doctorId = json['DoctorId'];
    countryId = json['CountryId'];
    countryName = json['CountryName'];
    institutionId = json['InstitutionId'];
    instituteName = json['InstituteName'];
    degreeId = json['DegreeId'];
    degreeName = json['DegreeName'];
    fieldOfStudyId = json['FieldOfStudyId'];
    fieldName = json['FieldName'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    issueDate = json['IssueDate'];
    gradingCriteria = json['GradingCriteria'];
    totalMarks = json['TotalMarks'];
    obtainedMarks = json['ObtainedMarks'];
    obtainedPercentage = json['ObtainedPercentage'];
    userGrade = json['UserGrade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['DoctorId'] = doctorId;
    data['CountryId'] = countryId;
    data['CountryName'] = countryName;
    data['InstitutionId'] = institutionId;
    data['InstituteName'] = instituteName;
    data['DegreeId'] = degreeId;
    data['DegreeName'] = degreeName;
    data['FieldOfStudyId'] = fieldOfStudyId;
    data['FieldName'] = fieldName;
    data['StartDate'] = startDate;
    data['EndDate'] = endDate;
    data['IssueDate'] = issueDate;
    data['GradingCriteria'] = gradingCriteria;
    data['TotalMarks'] = totalMarks;
    data['ObtainedMarks'] = obtainedMarks;
    data['ObtainedPercentage'] = obtainedPercentage;
    data['UserGrade'] = userGrade;
    return data;
  }
}

class Expereinces {
  String? id;
  String? title;
  String? organizationId;
  String? organizationName;
  String? locationId;
  String? locatioName;
  String? fromDate;
  String? toDate;
  dynamic isCurrentWorking;
  dynamic description;
  String? path;

  Expereinces(
      {this.id,
      this.title,
      this.organizationId,
      this.organizationName,
      this.locationId,
      this.locatioName,
      this.fromDate,
      this.toDate,
      this.isCurrentWorking,
      this.description,
      this.path});

  Expereinces.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    organizationId = json['OrganizationId'];
    organizationName = json['OrganizationName'];
    locationId = json['LocationId'];
    locatioName = json['LocatioName'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    isCurrentWorking = json['IsCurrentWorking'];
    description = json['Description'];
    path = json['Path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Title'] = title;
    data['OrganizationId'] = organizationId;
    data['OrganizationName'] = organizationName;
    data['LocationId'] = locationId;
    data['LocatioName'] = locatioName;
    data['FromDate'] = fromDate;
    data['ToDate'] = toDate;
    data['IsCurrentWorking'] = isCurrentWorking;
    data['Description'] = description;
    data['Path'] = path;
    return data;
  }
}

class Specialities {
  String? id;
  String? speciality;
  String? subSpeciality;
  String? specialityId;
  String? subSpecialityId;
  String? modifiedOn;
  dynamic isDefault;
  dynamic isSubSpecilityDefault;

  Specialities(
      {this.id,
      this.speciality,
      this.subSpeciality,
      this.specialityId,
      this.subSpecialityId,
      this.modifiedOn,
      this.isDefault,
      this.isSubSpecilityDefault});

  Specialities.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    speciality = json['Speciality'];
    subSpeciality = json['SubSpeciality'];
    specialityId = json['SpecialityId'];
    subSpecialityId = json['SubSpecialityId'];
    modifiedOn = json['ModifiedOn'];
    isDefault = json['IsDefault'];
    isSubSpecilityDefault = json['IsSubSpecilityDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Speciality'] = speciality;
    data['SubSpeciality'] = subSpeciality;
    data['SpecialityId'] = specialityId;
    data['SubSpecialityId'] = subSpecialityId;
    data['ModifiedOn'] = modifiedOn;
    data['IsDefault'] = isDefault;
    data['IsSubSpecilityDefault'] = isSubSpecilityDefault;
    return data;
  }
}

class Memberships {
  String? id;
  String? code;
  String? title;
  String? doctorId;
  String? organizationId;
  String? locationId;
  String? fromDate;
  String? toDate;
  dynamic isCurrent;
  String? organizationName;
  String? location;
  String? description;
  String? modifiedOn;

  Memberships(
      {this.id,
      this.code,
      this.title,
      this.doctorId,
      this.organizationId,
      this.locationId,
      this.fromDate,
      this.toDate,
      this.isCurrent,
      this.organizationName,
      this.location,
      this.description,
      this.modifiedOn});

  Memberships.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    code = json['Code'];
    title = json['Title'];
    doctorId = json['DoctorId'];
    organizationId = json['OrganizationId'];
    locationId = json['LocationId'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    isCurrent = json['IsCurrent'];
    organizationName = json['OrganizationName'];
    location = json['Location'];
    description = json['Description'];
    modifiedOn = json['ModifiedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Code'] = code;
    data['Title'] = title;
    data['DoctorId'] = doctorId;
    data['OrganizationId'] = organizationId;
    data['LocationId'] = locationId;
    data['FromDate'] = fromDate;
    data['ToDate'] = toDate;
    data['IsCurrent'] = isCurrent;
    data['OrganizationName'] = organizationName;
    data['Location'] = location;
    data['Description'] = description;
    data['ModifiedOn'] = modifiedOn;
    return data;
  }
}

class Awards {
  String? id;
  String? code;
  String? title;
  String? doctorId;
  String? organizationId;
  String? organizationName;
  String? locationId;
  String? location;
  String? awardedDate;
  String? modifiedOn;
  String? description;

  Awards(
      {this.id,
      this.code,
      this.title,
      this.doctorId,
      this.organizationId,
      this.organizationName,
      this.locationId,
      this.location,
      this.awardedDate,
      this.modifiedOn,
      this.description});

  Awards.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    code = json['Code'];
    title = json['Title'];
    doctorId = json['DoctorId'];
    organizationId = json['OrganizationId'];
    organizationName = json['OrganizationName'];
    locationId = json['LocationId'];
    location = json['Location'];
    awardedDate = json['AwardedDate'];
    modifiedOn = json['ModifiedOn'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Code'] = code;
    data['Title'] = title;
    data['DoctorId'] = doctorId;
    data['OrganizationId'] = organizationId;
    data['OrganizationName'] = organizationName;
    data['LocationId'] = locationId;
    data['Location'] = location;
    data['AwardedDate'] = awardedDate;
    data['ModifiedOn'] = modifiedOn;
    data['Description'] = description;
    return data;
  }
}

class BankAccounts {
  String? id;
  String? title;
  String? accountNumber;
  String? userId;
  String? doctorId;
  String? bankId;
  String? bankName;
  dynamic isDefault;
  String? path;
  dynamic isActive;

  BankAccounts(
      {this.id,
      this.title,
      this.accountNumber,
      this.userId,
      this.doctorId,
      this.bankId,
      this.bankName,
      this.isDefault,
      this.path,
      this.isActive});

  BankAccounts.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    accountNumber = json['AccountNumber'];
    userId = json['UserId'];
    doctorId = json['DoctorId'];
    bankId = json['BankId'];
    bankName = json['BankName'];
    isDefault = json['IsDefault'];
    path = json['Path'];
    isActive = json['IsActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Title'] = title;
    data['AccountNumber'] = accountNumber;
    data['UserId'] = userId;
    data['DoctorId'] = doctorId;
    data['BankId'] = bankId;
    data['BankName'] = bankName;
    data['IsDefault'] = isDefault;
    data['Path'] = path;
    data['IsActive'] = isActive;
    return data;
  }
}

class AppointmentConfigurations {
  dynamic id;
  dynamic workLocation;
  dynamic isDefault;
  dynamic approvalCriteria;
  dynamic workLocationId;
  dynamic address;
  dynamic doctorId;
  dynamic branchId;
  dynamic branchName;
  dynamic fromTime;
  dynamic toTime;
  dynamic weekDays;
  double? consultancyFee;
  double? followupFee;
  dynamic slotDuration;
  dynamic noofFollowupDays;
  dynamic isOnlineConfiguration;
  dynamic isActive;
  dynamic actionDate;

  AppointmentConfigurations(
      {this.id,
      this.workLocation,
      this.isDefault,
      this.approvalCriteria,
      this.workLocationId,
      this.address,
      this.doctorId,
      this.branchId,
      this.branchName,
      this.fromTime,
      this.toTime,
      this.weekDays,
      this.consultancyFee,
      this.followupFee,
      this.slotDuration,
      this.noofFollowupDays,
      this.isOnlineConfiguration,
      this.isActive,
      this.actionDate});

  AppointmentConfigurations.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    workLocation = json['WorkLocation'];
    isDefault = json['IsDefault'];
    approvalCriteria = json['ApprovalCriteria'];
    workLocationId = json['WorkLocationId'];
    address = json['Address'];
    doctorId = json['DoctorId'];
    branchId = json['BranchId'];
    branchName = json['BranchName'];
    fromTime = json['FromTime'];
    toTime = json['ToTime'];
    weekDays = json['WeekDays'];
    consultancyFee = json['ConsultancyFee'];
    followupFee = json['FollowupFee'];
    slotDuration = json['SlotDuration'];
    noofFollowupDays = json['NoofFollowupDays'];
    isOnlineConfiguration = json['IsOnlineConfiguration'];
    isActive = json['IsActive'];
    actionDate = json['ActionDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['WorkLocation'] = workLocation;
    data['IsDefault'] = isDefault;
    data['ApprovalCriteria'] = approvalCriteria;
    data['WorkLocationId'] = workLocationId;
    data['Address'] = address;
    data['DoctorId'] = doctorId;
    data['BranchId'] = branchId;
    data['BranchName'] = branchName;
    data['FromTime'] = fromTime;
    data['ToTime'] = toTime;
    data['WeekDays'] = weekDays;
    data['ConsultancyFee'] = consultancyFee;
    data['FollowupFee'] = followupFee;
    data['SlotDuration'] = slotDuration;
    data['NoofFollowupDays'] = noofFollowupDays;
    data['IsOnlineConfiguration'] = isOnlineConfiguration;
    data['IsActive'] = isActive;
    data['ActionDate'] = actionDate;
    return data;
  }
}
