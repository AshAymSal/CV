class CompanyModel {
  int? id;
  String? name;
  String? details;
  String? image;
  List<String>? phones;
  bool? isExpanded = false;

  CompanyModel(
      {this.id,
      this.name,
      this.details,
      this.image,
      this.phones,
      this.isExpanded});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    details = json['details'];
    image = json['image'];
    phones = json['phones'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['details'] = this.details;
    data['image'] = this.image;
    data['phones'] = this.phones;
    return data;
  }
}
