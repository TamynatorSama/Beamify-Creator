import 'dart:io';

import 'package:flutter/widgets.dart';

abstract class AppEvent {
  const AppEvent();
}

class InitData extends AppEvent {
  const InitData();
}

class CreateChannelEvent extends AppEvent {
  final String channelName;
  final String channelDescription;
  final String type;
  final File? image;
  final File? coverImage;
  final BuildContext context;

  // final Function() successCallback;
  const CreateChannelEvent(
      {required this.channelDescription,
      required this.channelName,
      this.coverImage,
      this.image,
      required this.context,
      // required this.successCallback,
      required this.type});
}

class CreatePodEvent extends AppEvent {
  final String channelId;
  final String podType;
  final String podName;
  final String podDescription;
  final File? image;
  final String type;
  const CreatePodEvent(
      {required this.channelId,
      required this.podType,
      required this.podName,
      required this.podDescription,
      this.image,
      required this.type});
}
