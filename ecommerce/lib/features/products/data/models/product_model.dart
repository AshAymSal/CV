import 'package:ecommernce/features/products/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel(
      {String? id,
      String? name,
      String? type,
      String? cost,
      String? description,
      List? images,
      String? times,
      String? daytime,
      String? daydate,
      List? sizes,
      List? colors,
      List? reviews,
      String? rating})
      : super(
            id: id,
            name: name,
            type: type,
            cost: cost,
            description: description,
            images: images,
            times: times,
            daytime: daytime,
            daydate: daydate,
            sizes: sizes,
            colors: colors,
            rating: rating,
            reviews: reviews);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      cost: json['cost'],
      description: json['description'],
      images: json['images'],
      times: json['times'],
      daydate: json['daydate'],
      daytime: json['daytime'],
      sizes: json['sizes'],
      colors: json['colors'],
      reviews: json['revies'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'cost': cost,
      'description': description,
      'images': images,
      'times': times,
      'daydate': daydate,
      'daytime': daytime,
      'sizes': sizes,
      'colors': colors,
      'reviews': reviews,
      'rating': rating
    };
  }
}
