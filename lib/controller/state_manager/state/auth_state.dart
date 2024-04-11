
class AuthState {
  final bool isLoading;
  final String error;
  final int resendTime;
  const AuthState({required this.error,this.resendTime = 30, required this.isLoading});

  factory AuthState.defaultState() =>
      const AuthState(error: "", isLoading: false);

  AuthState copyWith({String? error,bool? isLoading,int? resendTime}) => AuthState(resendTime: resendTime ?? this.resendTime,error: error??this.error, isLoading: isLoading??this.isLoading);
}
