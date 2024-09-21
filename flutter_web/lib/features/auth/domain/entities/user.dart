import 'package:equatable/equatable.dart';

// lib/product.dart

class user extends Equatable {
  final int id;
  final String email;
  final String username;
  final String password;
  final fullname name;
  final fulladdress address;
  final String phone;

  const user({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });

  @override
  List<Object?> get props =>
      [id, email, username, password, name, address, phone];
}

class fullname extends Equatable {
  String firstname;
  String lastname;

  fullname({required this.firstname, required this.lastname});

  @override
  // TODO: implement props
  List<Object?> get props => [firstname, lastname];
}

class fulladdress extends Equatable {
  String city;
  String street;
  int number;
  String zipcode;
  fullgeolocation geolocation;
  fulladdress(
      {required this.city,
      required this.number,
      required this.street,
      required this.zipcode,
      required this.geolocation});

  @override
  List<Object?> get props =>
      [city, street, number, street, zipcode, geolocation];
}

class fullgeolocation extends Equatable {
  String lat;
  String long;

  fullgeolocation({required this.lat, required this.long});

  @override
  // TODO: implement props
  List<Object?> get props => [lat, long];
}
