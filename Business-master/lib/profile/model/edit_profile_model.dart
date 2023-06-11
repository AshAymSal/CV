class EditProfileModel {
  String? token;
  String? name;
  String? username;
  String? email;
  String? birthDate;
  String? phone;
  String? gender;
  String? cityId;
  String? countryId;
  String? jobTitle;
  String? specialty;
  String? businessType;

  EditProfileModel({
    required this.token,
    required this.name,
    required this.username,
    required this.email,
    required this.birthDate,
    required this.phone,
    required this.gender,
    required this.cityId,
    required this.countryId,
    required this.jobTitle,
    required this.specialty,
    required this.businessType,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': this.token,
      'name': this.name,
      'username': this.username,
      'email': this.email,
      'birthDate': this.birthDate,
      'phone': this.phone,
      'gender': this.gender,
      'city_id': this.cityId,
      'country_id': this.countryId,
      'jobTitle': this.jobTitle,
      'Specialty': this.specialty,
      'businessType': this.businessType,
    };
  }
}
