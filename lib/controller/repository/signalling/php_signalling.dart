import 'dart:convert';

import 'package:beamify_creator/controller/repository/signalling/signalling_repository.dart';
import 'package:beamify_creator/shared/http/http_helper.dart';
import 'package:beamify_creator/shared/utils/rtc_config.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PhpSignalling extends ISignalling {
  static late PusherChannelsFlutter pusher;
  static Map<String, RTCPeerConnection> connections = {};
  static String presentPodId = "";
  MediaStream? remoteStream;
  RTCVideoRenderer? remoteRenderer;

  static initializePusher() async {
    pusher = PusherChannelsFlutter.getInstance();
    await pusher.init(
      apiKey: '1f7df03a521dcdf62073',
      cluster: 'sa1',
      
    );
    pusher.connect();

    // pusher.trigger(PusherEvent(channelName: "pod.1", eventName: "eventName"));
  }

  static setAndSendAnswer(String userId, dynamic offer) async {
    // if(userId =)
    final newOffer = jsonDecode(offer);
    await connections["2"]!.setRemoteDescription(
      RTCSessionDescription(newOffer['sdp'], newOffer['type']),
    );
    var answer = await connections[userId]!.createAnswer();
    await connections["2"]!.setLocalDescription(answer);
    await HttpHelper.postRequest("pods/1/send_answer",
            payload: {"answer": jsonEncode(answer.toMap()), "for_user": "2"})
        .then((value) async {
      if (value.isSuccessful) {
        print("sent answer successfully");
      }
    });
  }

  createChannel(String podId) {
    pusher.subscribe(channelName: 'pods.$podId');
    print(pusher.channels);
    // pusher.trigger(PusherEvent(channelName: "pod.$podId", eventName: "offer"));

    pusher.onEvent = ((event) {
      if (event.eventName.contains("begin")) {
        // createPod();
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

  static addIceCandidate({required Map<String, dynamic>? payload}) {
    print(payload);
    if (payload == null || payload["iceCandidateObject"] == null) return;
    print("here");
    RTCPeerConnection currentConnect = connections["2"]!;
    print("after getting connect");
    if (payload["iceCandidateObject"]["isCreator"]) {
      Map<String, dynamic> candidates =
          jsonDecode(payload["iceCandidateObject"]["iceCandidate"]);
      print("after getting candidate map");
      currentConnect.addCandidate(RTCIceCandidate(candidates['candidate'],
          candidates["sdpMid"], candidates["sdpMLineIndex"]));
    }
  }

  @override
  Future<void> createPod({String userId = "1"}) async {
    connections[userId] = await createPeerConnection(configuration);
    RTCPeerConnection currentConnect = connections[userId]!;
    registerPeerConnectionListeners(currentConnect);

    //listening for local candidate
    currentConnect.onIceCandidate = (RTCIceCandidate candidate) async {
      // print('Got candidate: ${candidate.toMap()}');
      await HttpHelper.postRequest('pods/$presentPodId/send_ice_candidate',
          payload: candidate.toMap());
    };

    RTCSessionDescription offer = await currentConnect.createOffer();

    await HttpHelper.postRequest("pods/$presentPodId/send_offer",
            payload: offer.toMap())
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
    
    
    peerConnection.onAddStream = (MediaStream stream) async{
      print("Add remote stream");
      // onAddRemoteStream?.call(stream);
      remoteStream = stream;
      remoteRenderer =await initializeRenderer(remoteStream!);

    };
    peerConnection.onTrack = (RTCTrackEvent event) {
        print('Got remote track: ${event.streams[0]}');
        event.streams[0].getTracks().forEach((track) {
          print('Add a track to the remoteStream: $track');
          remoteStream?.addTrack(track);
        });
      };
    
  }
  Future<RTCVideoRenderer> initializeRenderer(MediaStream remoteStream) async {
    final RTCVideoRenderer renderer = RTCVideoRenderer();
    await renderer.initialize();
    renderer.srcObject = remoteStream;
    return renderer;
  }

  // for user

  joinPod(String podId) async {
    await pusher.subscribe(
      channelName: 'pods.1',
      onEvent: (event) {
        try {
          switch (event.eventName.toLowerCase()) {
            case "on_ice_candidate":
              Map<String, dynamic> json = jsonDecode(event.data);
              addIceCandidate(payload: json);
              break;
            case "on_offer":
              Map<String, dynamic> json = jsonDecode(event.data);
              // print(json);
              setAndSendAnswer(json["offerObject"]["userId"].toString(),
                  json["offerObject"]["offer"]);
              break;
            default:
              break;
          }
        } catch (e) {
          print(e);
        }
      },
    );
    await HttpHelper.postRequest('pods/1/join').then((value) async {
      if (value.isSuccessful) {
        connections["2"] = await createPeerConnection(configuration);
        registerPeerConnectionListeners(connections["2"]!);
        connections["2"]!.onIceCandidate = (RTCIceCandidate candidate) async {
          print('Got candidate: ${candidate.toMap()}');
          await HttpHelper.postRequest('pods/1/send_ice_candidate', payload: {
            "ice_candidate": jsonEncode(candidate.toMap()),
            "is_creator": false,
            "for_user": "2"
          });
        };
        
      }
    });
  }
}
