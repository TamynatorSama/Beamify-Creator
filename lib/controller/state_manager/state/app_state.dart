import 'package:audio_session/audio_session.dart';
import 'package:beamify_creator/models/category_model.dart';

class AppState {
  final List<AudioDevice> audioSource;
  final bool isLoading;
  final List<CategoryModel> tags;
  const AppState({required this.audioSource, required this.tags,this.isLoading = false});
  factory AppState.defaultState() => const AppState(audioSource: [], tags: []);

  AppState copyWith({List<CategoryModel>? newTags, List<AudioDevice>? audioSource,bool? isLoading}) =>
      AppState(
          audioSource: audioSource ?? this.audioSource, tags: newTags ?? tags,isLoading: isLoading??this.isLoading);
}
