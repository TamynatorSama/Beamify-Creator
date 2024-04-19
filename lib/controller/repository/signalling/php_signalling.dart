import 'package:beamify_creator/controller/repository/signalling/signalling_repository.dart';
import 'package:beamify_creator/shared/http/http_helper.dart';
import 'package:beamify_creator/shared/utils/rtc_config.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PhpSignalling extends ISignalling {
  static late PusherChannelsFlutter pusher;
  Map<String, RTCPeerConnection> connections = {};
  static String presentPodId = "";

  static initializePusher() async {
    pusher = PusherChannelsFlutter.getInstance();
    await pusher.init(
      apiKey: '1f7df03a521dcdf62073',
      cluster: 'sa1',
      onEvent: (event) {
        print('Event: ${event}');
      },
    );

    // pusher.trigger(PusherEvent(channelName: "pod.1", eventName: "eventName"));
  }

  createChannel(String podId) {
    pusher.subscribe(channelName: 'pods.$podId');
    print(pusher.channels);
    // pusher.trigger(PusherEvent(channelName: "pod.$podId", eventName: "offer"));

    pusher.onEvent = ((event) {
      if (event.eventName.contains("begin")) {
        createPod();
        return;
      }
      print(event);
    });
    
  }

  tiggerEvent(String podId) async {
    await HttpHelper.postRequest('pods/$podId/begin').then((value) {
      if (value.isSuccessful) {
        presentPodId = podId;
        createChannel(podId);
      }
    });
  }

  @override
  Future<void> createPod({String userId = "1"}) async {
    connections[userId] = await createPeerConnection(configuration);
    RTCPeerConnection currentConnect = connections[userId]!;
    registerPeerConnectionListeners(currentConnect);

    //listening for local candidate
    currentConnect.onIceCandidate = (RTCIceCandidate candidate) async {
      print('Got candidate: ${candidate.toMap()}');
      await HttpHelper.postRequest('pods/$presentPodId/send_ice_candidate',
          payload: candidate.toMap());
    };

    RTCSessionDescription offer = await currentConnect.createOffer();

    await HttpHelper.postRequest("pods/$presentPodId/send_offer", payload: offer.toMap())
        .then((value) async {
      if (value.isSuccessful) {
        await currentConnect.setLocalDescription(offer);
      }
    });
  }

  setUserOffer({String userId = "1", dynamic offerAnswer}) async {
    RTCPeerConnection currentConnect = connections[userId]!;
    await currentConnect.setRemoteDescription(offerAnswer);
  }

  onNewRemoteCandidate({String userId = "1", dynamic iceCandidate}) async {}

  @override
  Future<void> endStream() {
    throw UnimplementedError();
  }

  @override
  Future<void> openUserMedia() {
    // TODO: implement openUserMedia
    throw UnimplementedError();
  }

  @override
  void registerPeerConnectionListeners(RTCPeerConnection peerConnection) {
    peerConnection.onIceGatheringState = (RTCIceGatheringState state) {
      print('ICE gathering state changed: $state');
    };

    peerConnection.onConnectionState = (RTCPeerConnectionState state) {
      print('Connection state change: $state');
    };

    peerConnection.onSignalingState = (RTCSignalingState state) {
      print('Signaling state change: $state');
    };

    peerConnection.onIceGatheringState = (RTCIceGatheringState state) {
      print('ICE connection state change: $state');
    };
  }
}
