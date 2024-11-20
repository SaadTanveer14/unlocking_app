import 'dart:io';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:unlocking_app/bloc/login_bloc.dart';
import 'package:unlocking_app/bloc/login_event.dart';
import 'package:unlocking_app/bloc/login_state.dart';
import 'package:unlocking_app/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc()..add(CheckBiometricAvailability()),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is AuthenticationSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Authentication Successful")));
            } else if (state is AuthenticationFailure ||
                state is PasswordValidationFailure) {
              String message =
                  (state is AuthenticationFailure) ? state.message : (state as PasswordValidationFailure).message;
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            }
          },
          builder: (context, state) {
            if (state is BiometricCheckSuccess && !state.showInputFields) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.isBiometricAvailable)
                      GestureDetector(
                        onTap: () => context.read<LoginBloc>().add(AuthenticateUser()),
                        child: const Icon(Icons.fingerprint, size: 70, color: Colors.blue),
                      ),
                    if (state.isFaceAvailable)
                      ElevatedButton(
                        onPressed: () => context.read<LoginBloc>().add(AuthenticateUser()),
                        child: const Text("Use Face ID"),
                      ),
                  ],
                ),
              );
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: "Chef ID"),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        bool obscureText = (state is PasswordVisibilityToggled)
                            ? state.obscureText
                            : true;
                        return TextField(
                          controller: passwordController,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            labelText: "Password",
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () =>
                                  context.read<LoginBloc>().add(TogglePasswordVisibility()),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        String chefId = nameController.text.trim();
                        String password = passwordController.text.trim();
                        if (chefId.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please fill in all fields")),
                          );
                        } else {
                          context.read<LoginBloc>().add(
                              ValidatePassword(chefId, password));
                        }
                      },
                      child: const Text("Login"),
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