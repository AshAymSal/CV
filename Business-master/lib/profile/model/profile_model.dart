class ProfileModel {
  int? id;
  String? name;
  String? userName;
  String? email;
  String? birthDate;
  String? age;
  String? phone;
  String? jobTitle;
  String? specialty;
  String? businessType;
  String? city;
  String? country;
  String? gender;
  String? official;
  String? personalImage;
  String? coverImage;
  int? myProfile;
  int? friendsNum;
  int? followersNum;
  int? followingsNum;
  String? firendshipState;
  int? followingState;
  String? emailVerifiedAt;
  String? rememberToken;
  String? type;
  String? password;
  String? confirmPassword;
  var stateId;
  String? verificationCode;

  ProfileModel(
      {this.id,
      this.name,
      this.userName,
      this.email,
      this.birthDate,
      this.age,
      this.phone,
      this.jobTitle,
      this.specialty,
      this.businessType,
      this.city,
      this.country,
      this.gender,
      this.official,
      this.personalImage,
      this.coverImage,
      this.myProfile,
      this.friendsNum,
      this.followersNum,
      this.followingsNum,
      this.firendshipState,
      this.followingState,
      this.emailVerifiedAt,
      this.rememberToken,
      this.type,
      this.password,
      this.confirmPassword,
      this.stateId,
      this.verificationCode});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userName = json['user_name'];
    email = json['email'];
    birthDate = json['birthDate'];
    age = json['age'];
    phone = json['phone'];
    jobTitle = json['jobTitle'];
    specialty = json['Specialty'];
    businessType = json['businessType'];
    city = json['city'];
    country = json['country'];
    gender = json['gender'];
    official = json['official'];
    personalImage = json['personal_image'];
    coverImage = json['cover_image'];
    myProfile = json['myProfile'];
    friendsNum = json['friends_num'];
    followersNum = json['followers_num'];
    followingsNum = json['followings_num'];
    firendshipState = json['firendship_state'];
    followingState = json['following_state'];
    emailVerifiedAt = json['emailVerifiedAt'];
    rememberToken = json['remember_token'];
    type = json['type'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    stateId = json['stateId'];
    verificationCode = json['verificationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['birthDate'] = this.birthDate;
    data['age'] = this.age;
    data['phone'] = this.phone;
    data['jobTitle'] = this.jobTitle;
    data['Specialty'] = this.specialty;
    data['businessType'] = this.businessType;
    data['city'] = this.city;
    data['country'] = this.country;
    data['gender'] = this.gender;
    data['official'] = this.official;
    data['personal_image'] = this.personalImage;
    data['cover_image'] = this.coverImage;
    data['myProfile'] = this.myProfile;
    data['friends_num'] = this.friendsNum;
    data['followers_num'] = this.followersNum;
    data['followings_num'] = this.followingsNum;
    data['firendship_state'] = this.firendshipState;
    data['following_state'] = this.followingState;
    data['emailVerifiedAt'] = this.emailVerifiedAt;
    data['remember_token'] = this.rememberToken;
    data['type'] = this.type;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    data['stateId'] = this.stateId;
    data['verificationCode'] = this.verificationCode;
    return data;
  }
}
