import 'package:beamify_creator/repository/signalling/signalling_repository.dart';
import 'package:beamify_creator/views/pages/onboarding/reusables/widgets/auth_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';

class NowStreamingView extends StatefulWidget {
  final ISignalling signalling;
  const NowStreamingView(
      {super.key, required this.signalling});

  @override
  State<NowStreamingView> createState() => _NowStreamingView();
}

class _NowStreamingView extends State<NowStreamingView> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await widget.signalling.createPod();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D2224),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          _header(),
          const SizedBox(
            height: 39,
          ),
          _mainCard(context),
          const SizedBox(
            height: 31,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: _nameTile(),
          ),
          const SizedBox(
            height: 8,
          ),
          progress(),
          const SizedBox(
            height: 52,
          ),
          _bottomOptions()
        ],
      ),
    );
  }
}

Widget _bottomOptions() => const Padding(
      padding: EdgeInsets.only(left: 62),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.mic,
            color: Colors.white,
          ),
          Icon(
            Icons.pause_circle,
            color: Colors.white,
            size: 56,
          ),
          Icon(
            Icons.share,
            color: Colors.white,
          ),
          Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ],
      ),
    );

Widget progress() => const SizedBox(
      width: 260,
      child: Row(
        children: [
          Text(
            '22:34',
            style: TextStyle(
              fontSize: 11,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: 0.6,
              color: Color(0xFFFF7848),
            ),
          ),
        ],
      ),
    );

Widget _nameTile() => const ListTile(
      leading: CircleAvatar(
        radius: 32,
      ),
      title: Text(
        'AFM Mafoluku’s Live Stream',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        'Bible Studies || Escape for thy Life || Bro. J.K Biodun',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );

Widget _mainCard(BuildContext ctxt) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xA6121212),
      ),
      height: 380,
      width: (MediaQuery.of(ctxt).size.width * 0.6).clamp(260, 300),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You are currently',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          const Text(
            'On Air',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SvgPicture.string(
            '<svg width="128" height="181" viewBox="0 0 128 181" fill="none" xmlns="http://www.w3.org/2000/svg"> <path id="Vector" d="M128 63.35V72.4C127.982 87.6207 122.428 102.326 112.355 113.826C102.282 125.326 88.362 132.852 73.1429 135.026V162.9H100.571V181H27.4286L27.4286 162.9H54.8571V135.026C39.638 132.852 25.7184 125.326 15.6451 113.826C5.57172 102.326 0.0180216 87.6207 0 72.4L0 63.35H18.2857V72.4C18.2857 84.401 23.102 95.9106 31.6751 104.397C40.2482 112.883 51.8758 117.65 64 117.65C76.1242 117.65 87.7518 112.883 96.3249 104.397C104.898 95.9106 109.714 84.401 109.714 72.4V63.35H128ZM64 99.55C71.2745 99.55 78.2511 96.6896 83.3949 91.598C88.5388 86.5063 91.4286 79.6006 91.4286 72.4V27.15C91.4286 19.9494 88.5388 13.0437 83.3949 7.95205C78.2511 2.86044 71.2745 0 64 0C56.7255 0 49.7489 2.86044 44.6051 7.95205C39.4612 13.0437 36.5714 19.9494 36.5714 27.15V72.4C36.5714 79.6006 39.4612 86.5063 44.6051 91.598C49.7489 96.6896 56.7255 99.55 64 99.55Z" fill="#D9B38C"/></svg>',
          ),
          const SizedBox(
            height: 16,
          ),
          customButton(txt: 'Go Offline', width: 137),
        ],
      ),
    );

Widget _header() => Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
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
            'Now Streaming',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ],
      ),
    );
