import 'package:beamify_creator/controller/state_manager/bloc/app_bloc.dart';
import 'package:beamify_creator/controller/state_manager/events/app_events.dart';
import 'package:beamify_creator/views/event_scheduler.dart';
import 'package:beamify_creator/views/live_stream_setup.dart';
import 'package:beamify_creator/views/scheduled_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatorHome extends StatefulWidget {
  const CreatorHome({super.key});

  @override
  State<CreatorHome> createState() => _CreatorHomeState();
}

class _CreatorHomeState extends State<CreatorHome> {

  @override
  void initState() {
   context.read<AppBloc>().add(const InitData());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D2224),
      body: Column(
        children: [
          Container(
            height: 76 + MediaQuery.of(context).padding.top,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: MediaQuery.of(context).padding.top,
            ),
            child: Row(
              children: [
                // Icon(
                //   Icons.arrow_back_ios_new_rounded,
                //   color: Colors.white,
                // ),
                const Spacer(),
                GestureDetector(
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const ScheduledEvents())),
                  child: const Icon(
                    Icons.menu_rounded,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            child: Image.asset(
              'assets/images/microphones.png',
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const LiveStreamSetup(),
                ),
              );
            },
            child: Container(
              height: 50,
              width: 170,
              decoration: BoxDecoration(
                color: const Color(0xFFFF7848),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.mic,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Go live now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const EventScheduler(),
                ),
              );
            },
            child: Container(
              height: 50,
              width: 170,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Schedule for later',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.bottomCenter,
        height: kBottomNavigationBarHeight,
        width: double.maxFinite,
        color: const Color(0xFF4A4A4A),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 72,
              child: _customBottomNavItem(
                icon: Icons.calendar_month,
                txt: 'Events',
                isSelected: true,
              ),
            ),
            const SizedBox(
              width: 34,
            ),
            SizedBox(
              width: 100,
              child: _customBottomNavItem(
                icon: Icons.play_circle_outline,
                txt: 'Recordings',
                isSelected: false,
              ),
            ),
            const SizedBox(
              width: 34,
            ),
            SizedBox(
              width: 80,
              child: _customBottomNavItem(
                icon: Icons.analytics,
                txt: 'Analytics',
                isSelected: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _customBottomNavItem({
  required IconData icon,
  required String txt,
  bool isSelected = false,
}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              txt,
              style: const TextStyle(
                color: Color(0xFFD9B38C),
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        isSelected
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFFF7848),
                ),
                height: 3,
                width: double.maxFinite,
              )
            : const SizedBox(),
      ],
    );
