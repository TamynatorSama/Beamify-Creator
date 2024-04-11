import 'dart:async';

import 'package:beamify_creator/controller/repository/auth_repository.dart';
import 'package:beamify_creator/controller/state_manager/state/auth_state.dart';
import 'package:beamify_creator/controller/state_manager/events/auth_event.dart';

import 'package:beamify_creator/shared/http/http_helper.dart';
import 'package:beamify_creator/shared/utils/FeedbackDialog/error_dialog.dart';
import 'package:beamify_creator/views/confirm_account.dart';
import 'package:beamify_creator/views/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  Timer? timer;

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

        if (value is SuccessResponse) {
          print(value.result["is_email_verified"]);
          bool isVerified =
              bool.tryParse((value.result["is_email_verified"]??"0")=="0"?"false":"true") ?? false;
          print(isVerified);

          if (!isVerified) {
            Navigator.of(event.context).push(MaterialPageRoute(
                builder: (context) => ConfirmAccount(
                      email: event.email,
                    )));
            return;
          }
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
        Navigator.of(event.context).push(MaterialPageRoute(
            builder: (context) => ConfirmAccount(
                  email: event.email,
                )));
      });
    });
    on<GoogleSignupEvent>((event, emit) async {
      await repository.googleSignUp();
    });
    on<SendOtpEvent>((event, emit) async {
      await repository.requestOtp(event.email).then((value) {
        if (!value.isSuccessful) {
          showErrorFeedback(event.context, message: value.message);
        }
      });
    });
    on<VerifyOtpEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await repository.verifyOtp(event.otp).then((value) {
        emit(state.copyWith(isLoading: false));
        if (!value.isSuccessful) {
          showErrorFeedback(event.context, message: value.message);
          return;
        }
        Navigator.of(event.context).pushReplacement(
            MaterialPageRoute(builder: (context) => const CreatorHome()));
      });
    });
  }
}
