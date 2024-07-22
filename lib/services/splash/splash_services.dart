import 'dart:async';
import 'package:flutter/material.dart';
import '../../config/routes/routes_name.dart';
import '../session_manager/session_controller.dart';

/// A class containing services related to the splash screen.
class SplashServices {
  /// Checks authentication status and navigates accordingly.
  ///
  /// Takes a [BuildContext] as input and navigates to the home screen if the user is authenticated,
  /// otherwise navigates to the login screen after a delay of 2 seconds.
  void checkAuthentication(BuildContext context) async {
    SessionController().getUserFromPreference().then((value) async {
      if (SessionController.isLogin ?? false) {
        Timer(
          const Duration(seconds: 2),
          () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.loginScreen, (route) => false),
        );
      } else {
        Timer(
          const Duration(seconds: 2),
          () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.loginScreen, (route) => false),
        );
      }
    }).onError((error, stackTrace) {
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.loginScreen, (route) => false),
      );
    });
  }
}
