import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckBiometricAvailability extends LoginEvent {}

class AuthenticateUser extends LoginEvent {}

class ValidatePassword extends LoginEvent {
  final String userId;
  final String password;

  ValidatePassword(this.userId, this.password);

  @override
  List<Object?> get props => [userId, password];
}

class TogglePasswordVisibility extends LoginEvent {}