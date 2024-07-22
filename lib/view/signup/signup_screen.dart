import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/signup_bloc/signup_bloc.dart';
import '../../bloc/signup_bloc/signup_event.dart';
import '../../bloc/signup_bloc/signup_state.dart';


class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();
    final _firstnameController = TextEditingController();
    final _lastnameController = TextEditingController();
    final _cityController = TextEditingController();
    final _streetController = TextEditingController();
    final _numberController = TextEditingController();
    final _zipcodeController = TextEditingController();
    final _latController = TextEditingController();
    final _longController = TextEditingController();
    final _phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Sign Up'),
          backgroundColor: Colors.teal
      ),
      body: BlocProvider(
        create: (_) => SignUpBloc(),
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Sign Up Successful! ID: ${state.id}')),
              );
            } else if (state is SignUpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Sign Up Failed: ${state.error}')),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password'),
                    ),
                    TextField(
                      controller: _firstnameController,
                      decoration: InputDecoration(labelText: 'First Name'),
                    ),
                    TextField(
                      controller: _lastnameController,
                      decoration: InputDecoration(labelText: 'Last Name'),
                    ),
                    TextField(
                      controller: _cityController,
                      decoration: InputDecoration(labelText: 'City'),
                    ),
                    TextField(
                      controller: _streetController,
                      decoration: InputDecoration(labelText: 'Street'),
                    ),
                    TextField(
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Number'),
                    ),
                    TextField(
                      controller: _zipcodeController,
                      decoration: InputDecoration(labelText: 'Zipcode'),
                    ),
                    TextField(
                      controller: _latController,
                      decoration: InputDecoration(labelText: 'Latitude'),
                    ),
                    TextField(
                      controller: _longController,
                      decoration: InputDecoration(labelText: 'Longitude'),
                    ),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(labelText: 'Phone'),
                    ),
                    SizedBox(height: 20),
                    if (state is SignUpLoading)
                      CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: () {
                          context.read<SignUpBloc>().add(
                            SignUpSubmitted(
                              email: _emailController.text,
                              username: _usernameController.text,
                              password: _passwordController.text,
                              firstname: _firstnameController.text,
                              lastname: _lastnameController.text,
                              city: _cityController.text,
                              street: _streetController.text,
                              number: int.parse(_numberController.text),
                              zipcode: _zipcodeController.text,
                              lat: _latController.text,
                              long: _longController.text,
                              phone: _phoneController.text,
                            ),
                          );
                        },
                        child: Text('Sign Up',),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}