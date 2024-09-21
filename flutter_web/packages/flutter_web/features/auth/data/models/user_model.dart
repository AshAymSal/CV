import 'package:flutter_web/features/auth/domain/entities/user.dart';

class UserModel extends user {
  const UserModel(
      {required super.id,
      required super.name,
      required super.address,
      required super.email,
      required super.password,
      required super.phone,
      required super.username});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      address: // fulladdressModel.fromJson(json['address']),
          fulladdressModel(
              city: json['address']['city'],
              number: json['address']['number'],
              street: json['address']['street'],
              zipcode: json['address']['zipcode'],
              geolocation: fullgeolocation(
                  lat: json['address']['geolocation']['lat'],
                  long: json['address']['geolocation']['long'])),
      name: //fullnameModel.fromJson(json['name']),
          fullname(
              firstname: json['name']['firstname'],
              lastname: json['name']['lastname']),
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'phone': phone,
      'username': username,
      'name': fullnameModel(firstname: name.firstname, lastname: name.lastname)
          .toJson(),
      'address': fulladdressModel(
          city: address.city,
          geolocation: address.geolocation,
          number: address.number,
          street: address.street,
          zipcode: address.zipcode)
    };
  }
}

class fullnameModel extends fullname {
  fullnameModel({required super.firstname, required super.lastname});

  factory fullnameModel.fromJson(Map<String, dynamic> json) {
    return fullnameModel(
      firstname: json['firstname'],
      lastname: json['lastname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'firstname': firstname, 'lastname': lastname};
  }
}

class fulladdressModel extends fulladdress {
  fulladdressModel(
      {required super.city,
      required super.number,
      required super.street,
      required super.zipcode,
      required super.geolocation});

  factory fulladdressModel.fromJson(Map<String, dynamic> json) {
    return fulladdressModel(
      city: json['city'],
      number: json['number'],
      street: json['street'],
      zipcode: json['zipcode'],
      geolocation: fullgeolocationModel.fromJson(json['geolocation']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'number': number,
      'street': street,
      'zipcode': zipcode,
      'geolocation':
          fullgeolocationModel(lat: geolocation.lat, long: geolocation.long)
              .toJson(),
    };
  }
}

class fullgeolocationModel extends fullgeolocation {
  fullgeolocationModel({required super.lat, required super.long});

  factory fullgeolocationModel.fromJson(Map<String, dynamic> json) {
    return fullgeolocationModel(
      lat: json['lat'],
      long: json['long'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'firstname': lat, 'lastname': long};
  }
}
