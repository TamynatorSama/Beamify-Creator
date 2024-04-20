import 'package:beamify_creator/controller/repository/pod_repository.dart';
import 'package:beamify_creator/controller/repository/signalling/php_signalling.dart';
import 'package:beamify_creator/controller/repository/signalling/signalling_repository.dart';
import 'package:beamify_creator/controller/state_manager/events/pod_events.dart';
import 'package:beamify_creator/controller/state_manager/state/pod_state.dart';
import 'package:beamify_creator/shared/utils/FeedbackDialog/error_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PodBloc extends Bloc<PodEvent, PodState> {
  final PodRepository podRepository;
  final ISignalling signalling;
  PodBloc({required this.podRepository, required this.signalling})
      : super(const PodState()) {
    on<CheckForEventUser>((event, emit) async {
      await podRepository.getUngoingPodInfo(event.podId).then((value) {
        if (!value.isSuccessful) {
          showErrorFeedback(event.context, message: value.message);
        }
      });
    });
    on<TriggerEventStarter>((event, emit) {
      
      (signalling as PhpSignalling).tiggerEvent(event.podId);
    });
  }
}
