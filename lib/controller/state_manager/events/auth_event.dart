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
  const RegisterEvent({required this.email, required this.password,required this.username});
}

class GoogleSignupEvent extends AuthEvent {
  const GoogleSignupEvent();
}
