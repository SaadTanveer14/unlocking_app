import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class BiometricCheckSuccess extends LoginState {
  final bool isBiometricAvailable;
  final bool isFaceAvailable;
  final bool showInputFields;

  BiometricCheckSuccess(
      {required this.isBiometricAvailable,
      required this.isFaceAvailable,
      required this.showInputFields});

  @override
  List<Object?> get props => [isBiometricAvailable, isFaceAvailable, showInputFields];
}

class AuthenticationSuccess extends LoginState {
  final String message;

  AuthenticationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthenticationFailure extends LoginState {
  final String message;

  AuthenticationFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class PasswordValidationSuccess extends LoginState {
   final String message;

  PasswordValidationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class PasswordValidationFailure extends LoginState {
  final String message;

  PasswordValidationFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class PasswordVisibilityToggled extends LoginState {
  final bool obscureText;

  PasswordVisibilityToggled(this.obscureText);

  @override
  List<Object?> get props => [obscureText];
}