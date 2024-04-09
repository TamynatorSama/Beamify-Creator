import 'package:beamify_creator/controller/repository/auth_repository.dart';
import 'package:beamify_creator/controller/state_manager/state/auth_action.dart';
import 'package:beamify_creator/controller/state_manager/events/auth_event.dart';

import 'package:beamify_creator/shared/http/http_helper.dart';
import 'package:beamify_creator/views/confirm_account.dart';
import 'package:beamify_creator/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(AuthState.defaultState()) {
    on<LoginEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await repository
          .login(email: event.email, password: event.password)
          .then((value) {
        emit(state.copyWith(isLoading: false));
        if (value is ValidationError) {
          event.errorCallback!(value.errors.first.errorMessage.first);
          return;
        }
        if (value is ErrorResponse) {
          event.errorCallback!(value.message);
          return;
        }
        Navigator.of(event.context).pushReplacement(
            MaterialPageRoute(builder: (context) => const CreatorHome()));
      });
    });
    on<RegisterEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await repository
          .register(
              email: event.email,
              firstName: event.firstName,
              lastName: event.lastName,
              password: event.password,
              username: event.username)
          .then((value) {
        emit(state.copyWith(isLoading: false));
        if (value is ValidationError) {
          event.errorCallback!(value.errors.first.errorMessage.first);
          return;
        }
        if (value is ErrorResponse) {
          event.errorCallback!(value.message);
          return;
        }
        Navigator.of(event.context).pushReplacement(
            MaterialPageRoute(builder: (context) => const ConfirmAccount()));
      });
    });
    on<GoogleSignupEvent>((event, emit) async {
      await repository.googleSignUp();
    });
  }
}
