import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/login_bloc/login_bloc.dart';
import '../../config/routes/routes_name.dart';
import '../../main.dart';
import '../../repository/auth_api/auth_api_repository.dart';
import 'widget/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

/// The state of the [LoginScreen] widget.
class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBlocs;

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loginBlocs = LoginBloc(authApiRepository: getIt<AuthApiRepository>());

    _checkLoggedInStatus();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _loginBlocs.close();
    super.dispose();
  }
  Future<void> _checkLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    if (isLoggedIn ?? false) {
      // User is logged in, navigate to home screen
      Navigator.pushReplacementNamed(context, RoutesName.homeScreen);
    }
  }

  void _login() {

    if (_formKey.currentState?.validate() ?? false) {
      _loginBlocs.add(LoginApi());

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: BlocProvider(
        create: (_) => _loginBlocs,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Title
                Text(
                  'Login ',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 20),

                // Email Input
                EmailInput(focusNode: _emailFocusNode),

                const SizedBox(height: 16),

                // Password Input
                PasswordInput(focusNode: _passwordFocusNode),

                const SizedBox(height: 24),

                // Submit Button
                SubmitButton(formKey: _formKey,
                onPressed: _login),
                const SizedBox(height: 20),

                // Sign Up Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to Sign Up Screen
                        Navigator.pushNamed(context, RoutesName.signUpScreen);
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
