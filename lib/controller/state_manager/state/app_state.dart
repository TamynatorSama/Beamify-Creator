import 'package:audio_session/audio_session.dart';
import 'package:beamify_creator/controller/repository/signalling/signalling_repository.dart';
import 'package:beamify_creator/models/category_model.dart';
import 'package:beamify_creator/models/channel/channel_model.dart';
import 'package:beamify_creator/models/user_model.dart';

class AppState {
  final List<AudioDevice> audioSource;
  final bool isLoading;
  final List<CategoryModel> tags;
  final List<ChannelModel> channels;
  final UserModel? user;
  final ISignalling? signalling;
  const AppState(
      {required this.audioSource,
      required this.tags,
      this.signalling,
      this.isLoading = false,
      this.user,
      required this.channels});
  factory AppState.defaultState() =>
      const AppState(audioSource: [], tags: [], channels: []);

  AppState copyWith(
          {List<CategoryModel>? newTags,
          List<AudioDevice>? audioSource,
          List<ChannelModel>? channels,
          ISignalling? signalling,
          UserModel? newUser,
          bool? isLoading}) =>
      AppState(
          audioSource: audioSource ?? this.audioSource,
          tags: newTags ?? tags,
          signalling: signalling??this.signalling,
          user: newUser ?? user,
          channels: channels ?? this.channels,
          isLoading: isLoading ?? this.isLoading);
}
