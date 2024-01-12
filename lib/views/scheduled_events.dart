import 'package:flutter/material.dart';

class ScheduledEvents extends StatelessWidget {
  const ScheduledEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF263238),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 16,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 15,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.search),
                  Text('Search in events'),
                  SizedBox(),
                ],
              ),
            ),
            const Row(
              children: [
                Text(
                  'My Scheduled Events',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: 32,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    eventTile(context),
                    const SizedBox(
                      height: 28,
                    ),
                    eventTile(context),
                    const SizedBox(
                      height: 28,
                    ),
                    eventTile(context),
                    const SizedBox(
                      height: 28,
                    ),
                    eventTile(context),
                    const SizedBox(
                      height: 28,
                    ),
                    eventTile(context),
                    const SizedBox(
                      height: 28,
                    ),
                    eventTile(context),
                    const SizedBox(
                      height: 28,
                    ),
                    eventTile(context),
                    const SizedBox(
                      height: 28,
                    ),
                    eventTile(context),
                    const SizedBox(
                      height: 28,
                    ),
                    eventTile(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget eventTile(BuildContext ctxt) => Row(
      children: [
        Container(
          color: Colors.white,
          width: 90,
          height: 90,
        ),
        const SizedBox(
          width: 12,
        ),
        SizedBox(
          width: (MediaQuery.of(ctxt).size.width * 0.7).clamp(150, 170),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Binary Bucks and Beyond: Navigating Money, Life, and AI',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                '23/09/2024 || 1pm - 3PM',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Column(
          children: [
            trailingIcon(
              0xFFFF7848,
              const Text('Share'),
            ),
            const SizedBox(
              height: 2,
            ),
            trailingIcon(
              0xFFD9B38C,
              const Text('Go live'),
            ),
            const SizedBox(
              height: 2,
            ),
            trailingIcon(
              0xFFFFFFFF,
              const Row(
                children: [
                  // Icon(
                  //   Icons.delete,
                  //   size: 14,
                  // ),
                  Text('Delete'),
                ],
              ),
            ),
          ],
        ),
      ],
    );

Widget trailingIcon(int color, Widget child) => Container(
      width: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(color),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: child,
    );
