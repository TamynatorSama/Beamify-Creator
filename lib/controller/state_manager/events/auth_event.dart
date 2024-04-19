import 'package:flutter/material.dart';

abstract class AuthEvent {
  final Function(String? value)? errorCallback;
  const AuthEvent({this.errorCallback});
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;
  const LoginEvent(this.context,
      {required this.email, required this.password, super.errorCallback});
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;
  final String firstName;
  final String lastName;
  final BuildContext context;
  const RegisterEvent(this.context,
      {required this.email,
      required this.firstName,
      required this.password,
      required this.lastName,
      required this.username,
      super.errorCallback});
}

class GoogleSignupEvent extends AuthEvent {
  final BuildContext context;
  const GoogleSignupEvent(this.context);
}

class SendOtpEvent extends AuthEvent {
  final String email;
  final BuildContext context;

  const SendOtpEvent(this.email,this.context);
}

class VerifyOtpEvent extends AuthEvent {
  final String otp;
  final BuildContext context;

  const VerifyOtpEvent(this.otp,this.context);
}
