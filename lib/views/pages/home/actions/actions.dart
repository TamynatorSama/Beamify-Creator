import 'package:beamify_creator/controller/state_manager/bloc/app_bloc.dart';
import 'package:beamify_creator/views/pages/home/channels/create_channel.dart';
import 'package:beamify_creator/views/pages/pods/event_scheduler.dart';
import 'package:beamify_creator/views/pages/pods/live_stream_setup.dart';
import 'package:beamify_creator/views/pages/pods/scheduled_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionPage extends StatelessWidget {
  const ActionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ScheduledEvents())),
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
                    if (context.read<AppBloc>().state.channels.isEmpty) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const CreateChannel()),
                      );
                      return;
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LiveStreamSetup(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 200,
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
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (context.read<AppBloc>().state.channels.isEmpty) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const CreateChannel()),
                      );
                      return;
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const EventScheduler(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 200,
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
            );
  }
}