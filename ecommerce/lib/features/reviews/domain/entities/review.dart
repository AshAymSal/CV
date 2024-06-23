import 'package:equatable/equatable.dart';

class Review extends Equatable {
  String? id;
  String? name;
  String? text;
  String? date;
  String? rating;

  Review({this.id, this.name, this.text, this.date, this.rating});

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, text, date, rating];
}
