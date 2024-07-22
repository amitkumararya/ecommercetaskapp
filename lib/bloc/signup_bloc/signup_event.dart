import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpSubmitted extends SignUpEvent {
  final String email;
  final String username;
  final String password;
  final String firstname;
  final String lastname;
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final String lat;
  final String long;
  final String phone;

  SignUpSubmitted({
    required this.email,
    required this.username,
    required this.password,
    required this.firstname,
    required this.lastname,
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.lat,
    required this.long,
    required this.phone,
  });

  @override
  List<Object?> get props => [
    email,
    username,
    password,
    firstname,
    lastname,
    city,
    street,
    number,
    zipcode,
    lat,
    long,
    phone,
  ];
}
