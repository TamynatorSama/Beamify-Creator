import 'package:audio_session/audio_session.dart';
import 'package:beamify_creator/controller/repository/app_repository.dart';
import 'package:beamify_creator/controller/repository/auth_repository.dart';
import 'package:beamify_creator/controller/state_manager/events/app_events.dart';
import 'package:beamify_creator/controller/state_manager/state/app_state.dart';
import 'package:beamify_creator/models/channel/channel_model.dart';
import 'package:beamify_creator/models/user_model.dart';
import 'package:beamify_creator/shared/http/http_helper.dart';
import 'package:beamify_creator/shared/utils/FeedbackDialog/error_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppRepository _appRepository;
  AppBloc(this._appRepository) : super(AppState.defaultState()) {
    on<UpdateAppState>((event, emit) {
      emit(event.state);
    });
    on<InitData>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await () async {
        await _appRepository.getSystemCategories().then((value) {
          if (value.isSuccessful) {
            emit(state.copyWith(newTags: (value as SuccessResponse).result));
          }
        });
        await _appRepository.getUserChannels().then((value) {
          if (value.isSuccessful) {
            emit(state.copyWith(channels: (value as SuccessResponse).result));
          }
        });

        await _appRepository.getUserProfile().then((value) {
          if (value.isSuccessful) {
            AuthRepository.userId =
                ((value as SuccessResponse).result as UserModel).id.toString();
            emit(state.copyWith(newUser: value.result));
          }
        });

        final session = await AudioSession.instance;
        // session.configuration(AudioSessionConfiguration());
        List<AudioDevice> audioDevices = (await session.getDevices()).toList();
        List<AudioDevice> filteredDevices = [];
        for (AudioDevice device in audioDevices) {
          bool exists = filteredDevices
              .where((element) =>
                  element.name.toLowerCase() == device.name.toLowerCase())
              .isNotEmpty;

          if (!exists && device.isInput) {
            filteredDevices.add(device);
          }
        }

        emit(state.copyWith(audioSource: filteredDevices, isLoading: false));
      }.call();
    });

    on<CreateChannelEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await _appRepository
          .createChannel(
              channelDescription: event.channelDescription,
              channelName: event.channelName,
              type: event.type,
              amount: event.amount,
              category: event.categories,
              frequency: event.subType,
              coverImage: event.coverImage,
              image: event.coverImage)
          .then((value) async {
        emit(state.copyWith(isLoading: false));
        if (value is ValidationError) {
          showErrorFeedback(event.context,
              message: value.errors.first.errorMessage.first);
          return;
        }
        if (value is ErrorResponse) {
          showErrorFeedback(event.context, message: value.message);
          return;
        }
        if (value is SuccessResponse) {
          await showErrorFeedback(event.context,
                  isError: false, message: value.message)
              .then((value) => Navigator.pop(event.context));

          emit(state.copyWith(channels: [...state.channels, value.result]));
        }
      });
    });
    on<CreatePodEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await _appRepository
          .createPod(
        channelId: event.channelId,
        podType: event.podType,
        podName: event.podName,
        onAir: event.onAir,
        isBroadcasting: event.isBroadcasting,
        podDescription: event.podDescription,
      )
          .then((value) async {
        emit(state.copyWith(isLoading: false));
        if (value is ValidationError) {
          showErrorFeedback(event.context,
              message: value.errors.first.errorMessage.first);
          return;
        }
        if (value is ErrorResponse) {
          showErrorFeedback(event.context, message: value.message);
          return;
        }
        if (value is SuccessResponse) {
          await showErrorFeedback(event.context,
              isError: false, message: value.message);
          event.successFeedback(value.result);
          PodModel newPod = value.result;
          List<ChannelModel> updatedList = state.channels.map((element) {
            if (element.id == newPod.channelId) {
              element.copyWith(pods: [...element.pods, newPod]);
            }
            return element;
          }).toList();

          emit(state.copyWith(channels: updatedList));
        }
      });
    });
  }
}
