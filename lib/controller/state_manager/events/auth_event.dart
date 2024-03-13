abstract class AuthEvent {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginEvent({required this.email, required this.password});
}

class GoogleSignupEvent extends AuthEvent {
  const GoogleSignupEvent();
}
