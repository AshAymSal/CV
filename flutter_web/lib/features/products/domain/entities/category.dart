import 'package:equatable/equatable.dart';

class category extends Equatable {
  final String name;

  const category({required this.name});

  @override
  List<Object?> get props => [name];
}
