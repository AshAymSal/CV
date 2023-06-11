class CountryCityModel {
  int? id;
  String? name;

  CountryCityModel({
    this.id,
    this.name,
  });

  CountryCityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  @override
  List<Object> get props => [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryCityModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
