import 'package:business/profile/model/publisher_data.dart';

class ServicesModel {
  int? id;
  String? title;
  String? body;
  String? price;
  String? postTypeId;
  PublisherData? publisherData;
  String? categoryId;
  late bool isFollow;
  List<dynamic>? media;

  ServicesModel({
    this.id,
    this.title,
    this.body,
    this.price,
    this.postTypeId,
    this.publisherData,
    this.categoryId,
    required this.isFollow,
    this.media,
  });

  ServicesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    price = json['price'];
    isFollow = json['isFollow'] ?? false;
    postTypeId = json['postTypeId'];
    publisherData = json['publisher'] != null
        ? PublisherData.fromJson(json['publisher'])
        : null;
    categoryId = json['categoryId'];
    media = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isFollow'] = this.isFollow;
    data['title'] = this.title;
    data['body'] = this.body;
    data['price'] = this.price;
    data['postTypeId'] = this.postTypeId;
    if (this.publisherData != null) {
      data['publisher'] = this.publisherData!.toJson();
    }
    data['categoryId'] = this.categoryId;
    data['images'] = this.media;
    return data;
  }

  ServicesModel copyWith({
    int? id,
    String? title,
    String? body,
    String? price,
    String? postTypeId,
    PublisherData? publisherData,
    String? categoryId,
    bool? isFollow,
    List<dynamic>? media,
    Map<String, dynamic>? data,
  }) {
    return ServicesModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      price: price ?? this.price,
      postTypeId: postTypeId ?? this.postTypeId,
      publisherData: publisherData ?? this.publisherData,
      categoryId: categoryId ?? this.categoryId,
      isFollow: isFollow ?? this.isFollow,
      media: media ?? this.media,
    );
  }
}
