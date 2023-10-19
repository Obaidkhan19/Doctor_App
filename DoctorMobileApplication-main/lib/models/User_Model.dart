class UserData {
  String? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? username;
  String? fullName;
  String? branchId;
  String? branchName;
  String? imagePath;
  String? organizationId;
  String? organizationAddress;
  String? organizationTelNo;
  String? branchAddress;
  String? branchTelNo;
  String? branchEmail;
  String? organizationPicturePath;
  String? organizationName;
  String? email;
  String? branchPicturePath;
  String? workingSessionId;
  String? token;
  String? pmdcNumber;
  String? cnicNumber;
  int? status;
  String? errorMessage;
  String? userImagePath;
  String? userTypeValue;
  dynamic doctorBranches; // You might want to specify the actual type here
  dynamic permissions; // You might want to specify the actual type here

  UserData({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.username,
    this.fullName,
    this.branchId,
    this.branchName,
    this.imagePath,
    this.organizationId,
    this.organizationAddress,
    this.organizationTelNo,
    this.branchAddress,
    this.branchTelNo,
    this.branchEmail,
    this.organizationPicturePath,
    this.organizationName,
    this.email,
    this.branchPicturePath,
    this.workingSessionId,
    this.token,
    this.pmdcNumber,
    this.cnicNumber,
    this.status,
    this.errorMessage,
    this.userImagePath,
    this.userTypeValue,
    this.doctorBranches,
    this.permissions,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['Id'] ?? '',
      firstName: json['FirstName'] ?? '',
      middleName: json['MiddleName'] ?? '',
      lastName: json['LastName'] ?? '',
      username: json['Username'] ?? '',
      fullName: json['FullName'] ?? '',
      branchId: json['BranchId'] ?? '',
      branchName: json['BranchName'] ?? '',
      imagePath: json['ImagePath'] ?? '',
      organizationId: json['OrganizationId'] ?? '',
      organizationAddress: json['OrganizationAddress'] ?? '',
      organizationTelNo: json['OrganizationTelNo'] ?? '',
      branchAddress: json['BranchAddress'] ?? '',
      branchTelNo: json['BranchTelNo'] ?? '',
      branchEmail: json['BranchEmail'] ?? '',
      organizationPicturePath: json['OrganizationPicturePath'] ?? '',
      organizationName: json['OrganizationName'] ?? '',
      email: json['Email'] ?? '',
      branchPicturePath: json['BranchPicturePath'] ?? '',
      workingSessionId: json['WorkingSessionId'] ?? '',
      token: json['Token'] ?? '',
      pmdcNumber: json['PMDCNumber'] ?? '',
      cnicNumber: json['CNICNumber'] ?? '',
      status: json['Status'] ?? 0,
      errorMessage: json['ErrorMessage'] ?? '',
      userImagePath: json['UserImagePath'] ?? '',
      userTypeValue: json['UserTypeValue'] ?? '',
      doctorBranches: json['DoctorBranches'], // No default value for dynamic
      permissions: json['Permissions'], // No default value for dynamic
    );
  }
}
