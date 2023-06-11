class CreateAccountModel {
  String? name, username;
  String? email;
  String? password;
  String? confirmPassword;
  String? phone;
  String? jobTitle;
  int? cityId;
  int? countryId;
  String? gender;
  String? birthDate;
  String? verificationCode;

  CreateAccountModel({
    this.name,
    this.username,
    this.email,
    this.birthDate,
    this.phone,
    this.jobTitle,
    this.cityId,
    this.countryId,
    this.gender,
    this.password,
    this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'user_name': this.username,
      'email': this.email,
      'password': this.password,
      'password_confirmation': this.confirmPassword,
      'phone': this.phone,
      'jobTitle': this.jobTitle,
      'city_id': this.cityId,
      'country_id': this.countryId,
      'gender': this.gender,
      'birthDate': this.birthDate,
    };
  }

  factory CreateAccountModel.fromMap(Map<String, dynamic> map) {
    return CreateAccountModel(
      name: map['name'] as String,
      username: map['user_name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      confirmPassword: map['password_confirmation'] as String,
      phone: map['phone'] ?? '',
      jobTitle: map['jobTitle'] ?? 0,
      cityId: map['city_id'] ?? 0,
      countryId: map['country_id'] ?? 0,
      gender: map['gender'] as String,
      birthDate: map['birthDate'] as String,
    );
  }
}
