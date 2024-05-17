// import 'package:beamify_creator/controller/repository/signalling/signalling_repository.dart';
import 'dart:convert';

import 'package:beamify_creator/shared/http/http_helper.dart';
import 'package:beamify_creator/shared/utils/rtc_config.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIoSignalling {
  static Map<String, RTCPeerConnection> connections = {};
  static String presentPodId = "";
  static MediaStream? localStream;
  static late IO.Socket socket;

  static init() {
    print("object new object");
    socket = IO.io(
        'https://test-pods.onrender.com',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());

    socket.connect();
    socket.onConnect((_) {
      print('connect now now');
      socket.emit('msg', 'test');
    });
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));

    socket.on("pod-join-request", (data) {
      createPod(userId: data.toString());
      
    });

    socket.on("close", (data) {
      print("closing connect");
      print(data);
      RTCPeerConnection? currentConnect = connections[data.toString()];
      if (currentConnect == null) {
        return;
      }
      currentConnect.close();
    });
    socket.on("ice-candidate", (signalData) {
      final data = jsonDecode(signalData);
      if (data["is_creator"]) return;
      print(data);
      RTCPeerConnection? currentConnect =
          connections[data["user_id"].toString()];
      if (currentConnect == null) {
        return;
      }
      currentConnect.addCandidate(
        RTCIceCandidate(
          data["ice_candidate"]['candidate'],
          data["ice_candidate"]['sdpMid'],
          data["ice_candidate"]['sdpMLineIndex'],
        ),
      );
    });
    socket.on('sdp_answer', (signalData) async {
      final data = jsonDecode(signalData);

      RTCPeerConnection? currentConnect =
          connections[data["user_id"].toString()];
      if (currentConnect == null) {
        return;
      }
      print("after soo soo long");

      final newOffer = data["offer"];
      print(newOffer);
      var answer = RTCSessionDescription(
        newOffer['sdp'],
        newOffer['type'],
      );
      await currentConnect.setRemoteDescription(answer);

      print('Connection Created!!!');
      HttpHelper.getRequest('pods/$presentPodId').then((val) {
        try {
          final listeners =
              (val as SuccessResponse).result['data']['pod']['viewer_count'];
          if (listeners != null) {
            HttpHelper.postRequest('pods/$presentPodId',
                payload: {'viewer_count': listeners});
          }
        } catch (_) {
          print('err');
        }
      });
    });
  }

  static void registerPeerConnectionListeners(RTCPeerConnection peerConnection,
      {String? userId}) {
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

  static Future<void> createPod(
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
      socket.emit("ice-candidate", {
        "ice_candidate": candidate.toMap(),
        "is_creator": true,
        "user_id": userId
      });
    };

    RTCSessionDescription offer = await currentConnect.createOffer();

    socket.emit("sdp-offer", {'offer': offer.toMap(), 'user_id': userId});
    await currentConnect.setLocalDescription(offer);
  }

  static Future<void> endStream() {
    // TODO: implement endStream
    throw UnimplementedError();
  }

  static Future<void> openUserMedia() async {
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
}
