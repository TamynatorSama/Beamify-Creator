import 'package:audio_session/audio_session.dart';
import 'package:beamify_creator/controller/repository/app_repository.dart';
import 'package:beamify_creator/controller/state_manager/events/app_events.dart';
import 'package:beamify_creator/controller/state_manager/state/app_state.dart';
import 'package:beamify_creator/shared/http/http_helper.dart';
import 'package:bloc/bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppRepository _appRepository;
  AppBloc(this._appRepository) : super(AppState.defaultState()) {
    on<InitData>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await () async {
        await _appRepository.getSystemCategories().then((value) {
          if (value.isSuccessful) {
            emit(state.copyWith(newTags: (value as SuccessResponse).result));
          }
        });

        final session = await AudioSession.instance;
        // session.configuration(AudioSessionConfiguration());
        List<AudioDevice> audioDevices = (await session.getDevices()).toList();
        print(audioDevices);
        emit(state.copyWith(audioSource: audioDevices,isLoading: false));
      }.call();
    });
  }
}
