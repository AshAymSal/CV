import 'package:equatable/equatable.dart';

// lib/product.dart

class Product extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, description, price, image];
}

/*
class Product extends Equatable {
  String? id;
  String? name;
  String? type;
  String? cost;
  String? description;
  List? images;
  String? times;
  String? daytime;
  String? daydate;
  List? sizes;
  List? colors;
  List? reviews;
  String? rating;

  Product({
    this.id,
    this.name,
    this.type,
    this.cost,
    this.description,
    this.images,
    this.times,
    this.daydate,
    this.daytime,
    this.colors,
    this.sizes,
    this.reviews,
    this.rating,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        type,
        cost,
        description,
        images,
        times,
        daydate,
        daytime,
        colors,
        sizes,
        reviews,
        rating,
      ];
}
*/