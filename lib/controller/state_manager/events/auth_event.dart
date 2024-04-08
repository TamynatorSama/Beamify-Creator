abstract class AuthEvent {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;
  final String firstName;
  final String lastName;
  final Function(String? value)? errorCallback;
  const RegisterEvent(
      {required this.email,
      required this.firstName,
      required this.password,
      required this.lastName,
      required this.username,
      this.errorCallback});
}

class GoogleSignupEvent extends AuthEvent {
  const GoogleSignupEvent();
}
