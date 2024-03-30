import 'package:beamify_creator/controller/repository/auth_repository.dart';
import 'package:beamify_creator/controller/state_manager/state/auth_action.dart';
import 'package:beamify_creator/controller/state_manager/events/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(AuthState.defaultState()) {
    on<LoginEvent>((event, emit) async {
      await repository.login(email: event.email, password: event.password);
    });
    on<RegisterEvent>((event, emit) async {
      await repository.register(email: event.email, password: event.password,username: event.username);
    });
    on<GoogleSignupEvent>((event, emit) async {
      await repository.googleSignUp();
    });
  }
}
