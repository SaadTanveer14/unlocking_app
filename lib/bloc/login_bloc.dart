import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _obscureText = true;

  LoginBloc() : super(LoginInitial()) {
    on<CheckBiometricAvailability>(_checkBiometricAvailability);
    on<AuthenticateUser>(_authenticateUser);
    on<ValidatePassword>(_validatePassword);
    on<TogglePasswordVisibility>(_togglePasswordVisibility);
  }

  Future<void> _checkBiometricAvailability(
      CheckBiometricAvailability event, Emitter<LoginState> emit) async {
    try {
      bool isBiometricAvailable = await _localAuthentication.canCheckBiometrics;
      List<BiometricType> availableBiometrics =
          await _localAuthentication.getAvailableBiometrics();

      bool isFaceAvailable = availableBiometrics.contains(BiometricType.face);

      emit(BiometricCheckSuccess(
        isBiometricAvailable: isBiometricAvailable,
        isFaceAvailable: isFaceAvailable,
        showInputFields: !(isBiometricAvailable || isFaceAvailable),
      ));
    } catch (e) {
      emit(BiometricCheckSuccess(
        isBiometricAvailable: false,
        isFaceAvailable: false,
        showInputFields: true,
      ));
    }
  }

  Future<void> _authenticateUser(
      AuthenticateUser event, Emitter<LoginState> emit) async {
    try {
      bool authenticated = await _localAuthentication.authenticate(
        localizedReason: 'Authenticate to access your account',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (authenticated) {
        emit(AuthenticationSuccess("Verified Successfully"));
      } else {
        emit(AuthenticationFailure('Authentication failed!'));
      }
    } catch (e) {
      emit(AuthenticationFailure('Authentication error: $e'));
    }
  }

  Future<void> _validatePassword(
      ValidatePassword event, Emitter<LoginState> emit) async {
    try {
      String apiUrl =
          "http://brownonions-002-site1.ftempurl.com/api/ChefRegister/ValidateChefPassword";
      Map<String, String> queryParams = {
        "ChefId": event.userId,
        "CurrentPassword": event.password,
        "APIKey": "mobileapi19042024"
      };

      Uri uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        String status = jsonResponse['notify']['notifyMessage'];

        if (status == "success") {
          emit(AuthenticationSuccess('Authentication Successful'));
          // emit(PasswordValidationSuccess("Authentication Successful"));
        } else {
          emit(PasswordValidationFailure(jsonResponse['notify']['message']));
        }
      } else {
        emit(PasswordValidationFailure(
            'Error validating password. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(PasswordValidationFailure('Error validating password: $e'));
    }
  }

  void _togglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<LoginState> emit) {
    _obscureText = !_obscureText;
    emit(PasswordVisibilityToggled(_obscureText));
  }
}