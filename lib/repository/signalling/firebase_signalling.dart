import 'dart:convert';

import 'package:beamify_creator/repository/signalling/signalling_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

// typedef StreamStateCallback = void Function(MediaStream stream);

class FirebaseSignalling implements ISignalling {
  RTCPeerConnection? peerConnection;
  MediaStream? localStream;
  // MediaStream? remoteStream;
  String? roomId;
  String? currentRoomText;

  Map<String, dynamic> configuration = {
    "iceServers": [
      {
        "urls": "stun:stun.relay.metered.ca:80",
      },
      {
        "urls": "turn:global.relay.metered.ca:80",
        "username": "d443b8153414640ca1667cad",
        "credential": "pQco+IlHhWCA1nUt",
      },
      {
        "urls": "turn:global.relay.metered.ca:80?transport=tcp",
        "username": "d443b8153414640ca1667cad",
        "credential": "pQco+IlHhWCA1nUt",
      },
      {
        "urls": "turn:global.relay.metered.ca:443",
        "username": "d443b8153414640ca1667cad",
        "credential": "pQco+IlHhWCA1nUt",
      },
      {
        "urls": "turns:global.relay.metered.ca:443?transport=tcp",
        "username": "d443b8153414640ca1667cad",
        "credential": "pQco+IlHhWCA1nUt",
      },
    ],
  };
  // StreamStateCallback? onAddRemoteStream;

  @override
  Future<void> createPod() async {
    print("in here");
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference roomRef = db.collection('rooms').doc();

    print('Create PeerConnection with configuration: $configuration');

    peerConnection = await createPeerConnection(configuration);

    registerPeerConnectionListeners();

    localStream?.getTracks().forEach((track) {
      peerConnection?.addTrack(track, localStream!);
    });

    // Code for collecting ICE candidates below
    var callerCandidatesCollection = roomRef.collection('callerCandidates');

    peerConnection?.onIceCandidate = (RTCIceCandidate candidate) {
      print('Got candidate: ${candidate.toMap()}');
      callerCandidatesCollection.add(candidate.toMap());
    };
    // Finish Code for collecting ICE candidate

    // Add code for creating a room
    RTCSessionDescription offer = await peerConnection!.createOffer();
    await peerConnection!.setLocalDescription(offer);
    print('Created offer: $offer');

    Map<String, dynamic> roomWithOffer = {'offer': offer.toMap()};

    await roomRef.set(roomWithOffer);
    var roomId = roomRef.id;
    print('New room created with SDK offer. Room ID: $roomId');
    currentRoomText = 'Current room is $roomId - You are the caller!';
    // Created a Room

    // peerConnection?.onTrack = (RTCTrackEvent event) {
    //   print('Got remote track: ${event.streams[0]}');

    //   event.streams[0].getTracks().forEach((track) {
    //     print('Add a track to the remoteStream $track');
    //     remoteStream?.addTrack(track);
    //   });
    // };

    // Listening for remote session description below
    roomRef.snapshots().listen((snapshot) async {
      print('Got updated room: ${snapshot.data()}');

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (peerConnection?.getRemoteDescription() != null &&
          data['answer'] != null) {
        var answer = RTCSessionDescription(
          data['answer']['sdp'],
          data['answer']['type'],
        );

        print("Someone tried to connect");
        await peerConnection?.setRemoteDescription(answer);
      }
    });
    // Listening for remote session description above

    // Listen for remote Ice candidates below
    roomRef.collection('calleeCandidates').snapshots().listen((snapshot) {
      snapshot.docChanges.forEach((change) {
        if (change.type == DocumentChangeType.added) {
          Map<String, dynamic> data = change.doc.data() as Map<String, dynamic>;
          print('Got new remote ICE candidate: ${jsonEncode(data)}');
          peerConnection!.addCandidate(
            RTCIceCandidate(
              data['candidate'],
              data['sdpMid'],
              data['sdpMLineIndex'],
            ),
          );
        }
      });
    });
    // Listen for remote ICE candidates above

    // return roomId;
  }

  @override
  Future<void> endStream() async {
    // List<MediaStreamTrack> tracks = localVideo.srcObject!.getTracks();
    // tracks.forEach((track) {
    //   track.stop();
    // });

    // if (remoteStream != null) {
    //   remoteStream!.getTracks().forEach((track) => track.stop());
    // }
    if (peerConnection != null) peerConnection!.close();

    if (roomId != null) {
      var db = FirebaseFirestore.instance;
      var roomRef = db.collection('rooms').doc(roomId);
      var calleeCandidates = await roomRef.collection('calleeCandidates').get();
      calleeCandidates.docs.forEach((document) => document.reference.delete());

      var callerCandidates = await roomRef.collection('callerCandidates').get();
      callerCandidates.docs.forEach((document) => document.reference.delete());

      await roomRef.delete();
    }

    localStream!.dispose();
    // remoteStream?.dispose();
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
  void registerPeerConnectionListeners() {
    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      print('ICE gathering state changed: $state');
    };

    peerConnection?.onConnectionState = (RTCPeerConnectionState state) {
      print('Connection state change: $state');
    };

    peerConnection?.onSignalingState = (RTCSignalingState state) {
      print('Signaling state change: $state');
    };

    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      print('ICE connection state change: $state');
    };
  }
}
