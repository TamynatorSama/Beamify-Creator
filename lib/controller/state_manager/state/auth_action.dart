class AuthState {
  final bool isLoading;
  final String error;
  const AuthState({required this.error,required this.isLoading});
  
  factory AuthState.defaultState()=>const AuthState(error: "", isLoading: false);

}
