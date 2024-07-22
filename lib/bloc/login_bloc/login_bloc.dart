import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommercetaskapp/model/user/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/auth_api/auth_api_repository.dart';
import '../../services/session_manager/session_controller.dart';
import '../../utils/enums.dart';

part 'login_events.dart';
part 'login_states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  AuthApiRepository authApiRepository;

  LoginBloc({required this.authApiRepository}) : super(const LoginStates()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginApi>(_onFormSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginStates> emit) {
    emit(
      state.copyWith(
        email: event.email,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginStates> emit) {
    emit(
      state.copyWith(
        password: event.password,
      ),
    );
  }

  Future<void> _onFormSubmitted(LoginApi event,
      Emitter<LoginStates> emit,) async {
    final Map<String, String> data = {
      'username': state.email,
      'password': state.password,
    };

    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    try {
      final response = await authApiRepository.loginApi(data);
      if (response.error.isNotEmpty) {
        emit(state.copyWith(
            postApiStatus: PostApiStatus.error, message: response.error));
      } else {
        await _storeUserInfo(response);
        emit(state.copyWith(postApiStatus: PostApiStatus.success));
      }
    } catch (error) {
      emit(state.copyWith(
          postApiStatus: PostApiStatus.error, message: error.toString()));
    }
  }

  Future<void> _storeUserInfo(UserModel response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('email', response.email);
    // Store other user info as needed
  }

}

