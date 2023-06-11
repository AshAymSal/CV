class UserSpecialistActiveModel {
  final bool? active;

  UserSpecialistActiveModel({
    this.active,
  });

  Map<String, dynamic> toMap() {
    return {
      'active': this.active,
    };
  }

  factory UserSpecialistActiveModel.fromMap(Map<String, dynamic> map) {
    return UserSpecialistActiveModel(
      active: map['active'] as bool,
    );
  }

  UserSpecialistActiveModel copyWith({
    int? userId,
    bool? active,
  }) {
    return UserSpecialistActiveModel(
      active: active ?? this.active,
    );
  }

  @override
  String toString() {
    return 'UserSpecialistModel {active: $active}';
  }
}
