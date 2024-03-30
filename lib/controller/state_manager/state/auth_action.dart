class AuthState {
  final bool isLoading;
  final String error;
  const AuthState({required this.error, required this.isLoading});

  factory AuthState.defaultState() =>
      const AuthState(error: "", isLoading: false);

  AuthState copyWith({String? error,bool? isLoading}) => AuthState(error: error??this.error, isLoading: isLoading??this.isLoading);
}
