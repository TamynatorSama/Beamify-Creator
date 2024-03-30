import 'package:beamify_creator/controller/repository/auth_repository.dart';
import 'package:beamify_creator/controller/state_manager/state/auth_action.dart';
import 'package:beamify_creator/controller/state_manager/events/auth_event.dart';
import 'package:beamify_creator/shared/http/http_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(AuthState.defaultState()) {
    on<LoginEvent>((event, emit) async {
      await repository.login(email: event.email, password: event.password);
    });
    on<RegisterEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      HttpResponse register = await repository.register(
          email: event.email,
          firstName: event.firstName,
          lastName: event.lastName,
          password: event.password,
          username: event.username);
      emit(state.copyWith(isLoading: false));
      if (register is ValidationError) {
        event.errorCallback!(register.errors.first.errorMessage.first);
        return;
      }
      if(register is ErrorResponse){
        event.errorCallback!(register.message);
        return;
      }

    });
    on<GoogleSignupEvent>((event, emit) async {
      await repository.googleSignUp();
    });
  }
}
