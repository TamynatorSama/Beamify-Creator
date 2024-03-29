import 'package:beamify_creator/shared/test.dart';
import 'package:beamify_creator/views/event_scheduler.dart';
import 'package:beamify_creator/views/pages/onboarding/reusables/widgets/auth_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class LiveStreamSetup extends StatefulWidget {
  const LiveStreamSetup({super.key});
  @override
  State<LiveStreamSetup> createState() => _LiveStreamSetup();
}

class _LiveStreamSetup extends State<LiveStreamSetup> {
  final _localRTCVideoRenderer = RTCVideoRenderer();

  // videoRenderer for remotePeer
  final _remoteRTCVideoRenderer = RTCVideoRenderer();

  // mediaStream for localPeer
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D2224),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: _header(),
                ),
                _txtField('Event Title*', 'Input Event Title Here'),
                const SizedBox(
                  height: 22,
                ),
                dropdownField('Event Category*', 'Event Category e.g Sermon'),
                const SizedBox(
                  height: 22,
                ),
                _txtField(
                  'Name of Presenters (Optional)',
                  'Input Presenters name e.g J.K Biodun',
                ),
                const SizedBox(
                  height: 22,
                ),
                dropdownField(
                  'Microphone Source',
                  'Select sound input source e.g built-in Mic',
                ),
                const SizedBox(
                  height: 22,
                ),
                _txtField(
                  'Upload Event  Photo (Optional)',
                  'must be PNG, JPG, JPEG',
                ),
                const SizedBox(
                  height: 22,
                ),
                InkWell(
                  onTap: () {
                    print("object");
                    WebRtcTest.startPod("samuel");
                  },
                  child: customButton(
                    txt: 'Save and Go Live',
                    width: 209,
                  ),
                )
              ],
            ),
          )),
    );
  }
}

Widget _txtField(String title, String hint) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, bottom: 4),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        customTextField(hintText: hint),
      ],
    );

Widget _header() => Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 16,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          Text(
            'Live Stream Setup',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          SizedBox(),
        ],
      ),
    );
