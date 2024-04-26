import 'dart:async';
import 'dart:convert';

import 'package:beamify_creator/controller/repository/signalling/signalling_repository.dart';
import 'package:beamify_creator/shared/http/http_helper.dart';
import 'package:beamify_creator/shared/utils/internet_checker.dart';
import 'package:beamify_creator/shared/utils/pusher_event_names.dart';
import 'package:beamify_creator/shared/utils/rtc_config.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PhpSignalling extends ISignalling {
  static late PusherChannelsFlutter pusher;
  Map<String, RTCPeerConnection> connections = {};
  Map<String, Timer> reconnectionObserver = {};
  static String presentPodId = "";
  MediaStream? localStream;

  createInstanceForAllUser() {}

  static initializePusher() async {
    pusher = PusherChannelsFlutter.getInstance();
    await pusher.init(
      apiKey: '9a5bce99e4e9106be463',
      cluster: 'sa1',

      // onEvent: (event) {
      //   print('Event: ${event}');
      // },
    );
    pusher.connect();

    // pusher.trigger(PusherEvent(channelName: "pod.1", eventName: "eventName"));
  }

  // short trigger
  // build ship

  createChannel(String podId) {
    pusher.subscribe(
        channelName: 'pods.$podId',
        onMemberAdded: (member) {
          print("a member has been added.....Thank you for joining");
          print(member);
        },
        onEvent: (event) {
          try {
            print(event.eventName);
            switch (event.eventName.toLowerCase()) {
              case PusherEventNames.joinPod:
                print("entered case");
                Map<String, dynamic> json = jsonDecode(event.data);
                createPod(userId: json["userId"]);
                break;
              case PusherEventNames.iceCandidate:
                Map<String, dynamic> json = jsonDecode(event.data);
                addIceCandidates(payload: json);
                break;
              case PusherEventNames.answer:
                Map<String, dynamic> json = jsonDecode(event.data);
                setAnswer(payload: json);
                break;
              default:
                break;
            }
          } catch (e) {
            print(e);
          }
        });
  }

  setAnswer({required Map<String, dynamic> payload}) async {
    // if (payload["offerObject"]["userId"].toString() != AuthRepository.userId)
    //   return;
    RTCPeerConnection? currentConnect =
        connections[payload["offerObject"]["userId"].toString()];
    if (currentConnect == null) {
      return;
    }

    final newOffer = jsonDecode(payload["offerObject"]["offer"]);
    var answer = RTCSessionDescription(
      newOffer['sdp'],
      newOffer['type'],
    );
    await currentConnect.setRemoteDescription(answer);
  }

  addIceCandidates({required Map<String, dynamic> payload}) {
    if (payload["iceCandidateObject"]["isCreator"]) return;

    RTCPeerConnection? currentConnect =
        connections[payload["iceCandidateObject"]["userId"].toString()];
    if (currentConnect == null) {
      return;
    }

    Map<String, dynamic> candidate =
        jsonDecode(payload["iceCandidateObject"]["iceCandidate"]);
    currentConnect.addCandidate(
      RTCIceCandidate(
        candidate['candidate'],
        candidate['sdpMid'],
        candidate['sdpMLineIndex'],
      ),
    );
  }

  tiggerEvent(String podId) async {
    await openUserMedia();
    await HttpHelper.postRequest('pods/$podId/begin').then((value) {
      if (value.isSuccessful) {
        presentPodId = podId;
        createChannel(podId);
      }
    });
  }

  @override
  Future<void> createPod(
      {String userId = "1", bool isFirstConnection = true}) async {
    if (isFirstConnection) {
      await openUserMedia();
    }
    connections[userId] = await createPeerConnection(configuration);
    RTCPeerConnection currentConnect = connections[userId]!;
    registerPeerConnectionListeners(currentConnect, userId: userId);
    localStream?.getTracks().forEach((track) {
      print("got tracks");
      currentConnect.addTrack(track, localStream!);
    });

    //listening for local candidate
    currentConnect.onIceCandidate = (RTCIceCandidate candidate) async {
      print("object");
      await HttpHelper.postRequest('pods/$presentPodId/send_ice_candidate',
          payload: {
            "ice_candidate": jsonEncode(candidate.toMap()),
            "is_creator": true,
            "for_user": userId
          });
    };

    RTCSessionDescription offer = await currentConnect.createOffer();

    await HttpHelper.postRequest("pods/$presentPodId/send_offer",
            payload: {"offer": jsonEncode(offer.toMap()), "for_user": userId})
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
  Future<void> openUserMedia() async {
    var stream = await navigator.mediaDevices.getUserMedia({
      'video': false,
      'audio': {
        "mandatory": {
          'autoGainControl': true,
          'echoCancellation': true,
          'noiseSuppression': true
        }
      }
    });
    // getUser

    // localVideo.srcObject = stream;
    localStream = stream;

    // remoteVideo.srcObject = await createLocalMediaStream('key');
  }

  @override
  void registerPeerConnectionListeners(RTCPeerConnection peerConnection,
      {String? userId}) {
    peerConnection.onIceGatheringState = (RTCIceGatheringState state) {
      print('ICE gathering state changed: $state');
    };

    peerConnection.onConnectionState = (RTCPeerConnectionState state) async {
      if (state == RTCPeerConnectionState.RTCPeerConnectionStateFailed ||
          state == RTCPeerConnectionState.RTCPeerConnectionStateDisconnected) {
        if ((reconnectionObserver[userId] == null ||
                (reconnectionObserver[userId] != null &&
                    !reconnectionObserver[userId]!.isActive)) &&
            userId != null) {
          reconnectionObserver[userId] = Timer.periodic(
              const Duration(seconds: 5),
              (timer) => reconnectionObserverFunction(timer, userId));
        }

        // print("renegotiation");

        // bool isNetworkConnectedOnCall =
        //     await _flutterNetworkConnectivity.isInternetConnectionAvailable();
        // print(isNetworkConnectedOnCall);

        // await Future.delayed(const Duration(seconds: 5)).then((value) async {
        //   if (isNetworkConnectedOnCall &&
        //       pusher.connectionState != "DISCONNECTED") {
        //     print("re doing it here");
        //     pusher.connect();
        //     createPod(userId: userId!);
        //   }
        // });
      }
      print('Connection state change: $state');
    };

    peerConnection.onSignalingState = (RTCSignalingState state) {
      print('Signaling state change: $state');
    };

    peerConnection.onIceGatheringState = (RTCIceGatheringState state) {
      print('ICE connection state change: $state');
    };
  }

  // user side
  void joinPod() async {
    await HttpHelper.postRequest('pods/$presentPodId/join').then((value) {
      if (value.isSuccessful) {
        // presentPodId = podId;
        // createChannel(podId);
      }
    });
  }

  reconnectionObserverFunction(Timer timer, String userId) async {
    RTCPeerConnection connect = connections[userId]!;
    if (connect.connectionState ==
            RTCPeerConnectionState.RTCPeerConnectionStateConnecting ||
        connect.connectionState ==
            RTCPeerConnectionState.RTCPeerConnectionStateConnected) {
      timer.cancel();
    }

    bool isNetworkConnectedOnCall =
        await InternetChecker.checkInternetConnectivity();

    print(connect);
    if (isNetworkConnectedOnCall && pusher.connectionState == "DISCONNECTED") {
      print("object => trying");
      await pusher.connect();
    }
    if (isNetworkConnectedOnCall &&
        pusher.connectionState != "DISCONNECTED" &&
        (connect.connectionState == null ||
            connect.connectionState ==
                RTCPeerConnectionState.RTCPeerConnectionStateDisconnected ||
            connect.connectionState ==
                RTCPeerConnectionState.RTCPeerConnectionStateFailed)) {
      print("object");
      await createPod(userId: userId);
      timer.cancel();
    }

    // if (isNetworkConnectedOnCall &&
    //     pusher.connectionState != "DISCONNECTED") {
    //   print("re doing it here");

    //   createPod(userId: userId!);
    // }
  }
}
