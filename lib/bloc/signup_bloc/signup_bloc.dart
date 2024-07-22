import 'package:bloc/bloc.dart';
import 'package:ecommercetaskapp/bloc/signup_bloc/signup_event.dart';
import 'package:ecommercetaskapp/bloc/signup_bloc/signup_state.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  void _onSignUpSubmitted(SignUpSubmitted event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());

    try {
      final response = await http.post(
        Uri.parse('https://fakestoreapi.com/users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': event.email,
          'username': event.username,
          'password': event.password,
          'name': {
            'firstname': event.firstname,
            'lastname': event.lastname,
          },
          'address': {
            'city': event.city,
            'street': event.street,
            'number': event.number,
            'zipcode': event.zipcode,
            'geolocation': {
              'lat': event.lat,
              'long': event.long,
            },
          },
          'phone': event.phone,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(SignUpSuccess(data['id'].toString()));
      } else {
        emit(SignUpFailure('Failed to sign up'));
      }
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
}