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
