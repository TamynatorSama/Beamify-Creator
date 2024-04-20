import 'package:flutter/material.dart';

abstract class PodEvent {
  const PodEvent();
}

class CheckForEventUser extends PodEvent {
  final BuildContext context;
  final String podId;
  const CheckForEventUser({required this.context, required this.podId});
}

class TriggerEventStarter extends PodEvent {
  final String podId;
  const TriggerEventStarter(this.podId);
}
