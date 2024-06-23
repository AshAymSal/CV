import 'package:ecommernce/features/reviews/domain/entities/review.dart';

class ReviewModel extends Review {
  ReviewModel(
      {String? id, String? name, String? text, String? date, String? rating})
      : super(
          id: id,
          name: name,
          text: text,
          date: date,
          rating: rating,
        );
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      name: json['name'],
      text: json['text'],
      date: json['date'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'text': text,
      'date': date,
      'rating': rating
    };
  }
}
