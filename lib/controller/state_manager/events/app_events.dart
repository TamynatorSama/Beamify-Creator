import 'dart:io';

import 'package:beamify_creator/models/channel/channel_model.dart';
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
  final String categories;
  final String? subType;
  final String? amount;
  final BuildContext context;

  // final Function() successCallback;
  const CreateChannelEvent(
      {required this.channelDescription,
      required this.channelName,
      this.coverImage,
      this.image,
      this.amount,
      this.subType,
      required this.categories,
      required this.context,
      // required this.successCallback,
      required this.type});
}

class CreatePodEvent extends AppEvent {
  final Function(PodModel? model) successFeedback;
  final String channelId;
  final String podType;
  final String podName;
  final String podDescription;
  final DateTime? airDate;
  final bool onAir;
  final BuildContext context;
  final bool isBroadcasting;
  const CreatePodEvent(this.context,
      {required this.channelId,
      required this.podType,
      required this.successFeedback,
      required this.podName,
      this.airDate,
      this.isBroadcasting = true,
      this.onAir = true,
      required this.podDescription});
}
