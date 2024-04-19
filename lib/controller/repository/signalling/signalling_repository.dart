import 'package:flutter_webrtc/flutter_webrtc.dart';

abstract class ISignalling {
  Future<void> createPod({String userId = "1"});
  Future<void> endStream();
  Future<void> openUserMedia();
  void registerPeerConnectionListeners(RTCPeerConnection peerConnection);
}
