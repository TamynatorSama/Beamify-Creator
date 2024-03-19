import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class WebRtcTest {
  static String globalPodId = "";
  static RTCPeerConnection? rtcPeerConnection;
  static List<RTCIceCandidate> rtcIceCadidates = [];
  static IO.Socket? socket;
  static MediaStream? localStream;

  static startPod(String podId) {
    socket =
        IO.io("https://13dd-102-88-62-48.ngrok-free.app", <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
      "query": {"pod_id": podId}
    });

    globalPodId = podId;
    socket!.connect();
    socket!.onConnect((_) {
      print('Connection established');
      initiatePeerConnection();
    });

    socket!.onDisconnect((_) => print('Connection Disconnection'));
    socket!.onConnectError((err) => print(err));
    socket!.onError((err) => print(err));
  }

  static Future manageConnection() async {
    rtcPeerConnection!.onIceCandidate =
        (RTCIceCandidate candidate) => rtcIceCadidates.add(candidate);
    socket!.on("joinedPod", (data) async {
      print("object test");
      await rtcPeerConnection!.setRemoteDescription(
        RTCSessionDescription(
          data["sdp"],
          data["type"],
        ),
      );
      for (RTCIceCandidate candidate in rtcIceCadidates) {
        socket!.emit("IceCandidate", {
          "pod_id": globalPodId,
          "iceCandidate": {
            "id": candidate.sdpMid,
            "label": candidate.sdpMLineIndex,
            "candidate": candidate.candidate
          }
        });
      }
    });

    RTCSessionDescription offer = await rtcPeerConnection!.createOffer();

    await rtcPeerConnection!.setLocalDescription(offer);
    socket!.emit('startPod', {
      "pod_id": globalPodId,
      "sdpOffer": offer.toMap(),
    });
  }

  static initiatePeerConnection() async {
    // create peer connection
    rtcPeerConnection = await createPeerConnection({
      'iceServers': [
        {
          'urls': [
            'stun:stun1.l.google.com:19302',
            'stun:stun2A.l.google.com:19302',
            {
              'url': 'turn:turn.bistri.com:80',
              'credential': 'homeo',
              'username': 'homeo'
            },
            {
              'url': 'turn:turn.anyfirewall.com:443?transport=tcp',
              'credential': 'webrtc',
              'username': 'webrtc'
            }
          ]
        }
      ]
    });
    rtcPeerConnection!.onConnectionState = ((state) {
      print("this is listening for connection state");
      print(state.name);
    });

    _initPod();
    manageConnection();
  }

  static _initPod() async {
    localStream = await navigator.mediaDevices
        .getUserMedia({'audio': true, 'video': false});

    print(localStream);
    print("gotten local stream");

    // add mediaTrack to peerConnection
    localStream!.getTracks().forEach((track) async {
      print("we are here to party");
      await rtcPeerConnection!.addTrack(track, localStream!);
      print("putting streams in the connection");
    });
  }
}
