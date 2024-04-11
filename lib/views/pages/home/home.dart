import 'package:beamify_creator/controller/state_manager/bloc/app_bloc.dart';
import 'package:beamify_creator/controller/state_manager/events/app_events.dart';
import 'package:beamify_creator/shared/utils/app_theme.dart';
import 'package:beamify_creator/shared/utils/bottom_nav_controller.dart';
import 'package:beamify_creator/views/pages/home/actions/actions.dart';
import 'package:beamify_creator/views/pages/home/channels/channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  List<Widget> homeWidget = [const ActionPage(), const ChannelsPage(),Column()];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: navController,
        builder: (context, value) {
          return Scaffold(
            backgroundColor: const Color(0xFF1D2224),
            body: homeWidget[navController.selectedIndex],
            bottomNavigationBar: 
            Container(
              alignment: Alignment.bottomCenter,
              
              height: 100,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom,
                  left: 24,
                  right: 24),
              width: double.maxFinite,
              color: const Color(0xFF4A4A4A),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildButtomNavItems(
                      onTap: () {
                        navController.changeIndex(0);
                      },
                      isCurrentPage: navController.selectedIndex == 0,
                      text: "Action",
                      icon:
                          '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="none" stroke="white" stroke-width="2" d="m1 23l3-3zM20 4l3-3zM9 11l3-3zm4 4l3-3zM10 5l9 9l1-1c2-2 4.053-5 0-9s-7-2-9 0zm-6 6l1-1l9 9l-1 1c-2 2-5 4.087-9 0s-2-7 0-9Z"/></svg>'''),
                  _buildButtomNavItems(
                      onTap: () {
                        navController.changeIndex(1);
                      },
                      isCurrentPage: navController.selectedIndex == 1,
                      text: "Channels",
                      icon:
                          '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 26 26"><g fill="white"><path fill-rule="evenodd" d="M13.5 26C20.404 26 26 20.404 26 13.5S20.404 1 13.5 1S1 6.596 1 13.5S6.596 26 13.5 26m0-2C19.299 24 24 19.299 24 13.5S19.299 3 13.5 3S3 7.701 3 13.5S7.701 24 13.5 24" clip-rule="evenodd" opacity="0.2"/><g opacity="0.2"><path d="M19.568 14.058a1 1 0 0 1-.054 1.721l-8.033 4.408A1 1 0 0 1 10 19.311V9.817a1 1 0 0 1 1.535-.845z"/><path fill-rule="evenodd" d="M17.067 14.841L12 11.633v5.988zm2.447.938a1 1 0 0 0 .054-1.721l-8.033-5.086A1 1 0 0 0 10 9.817v9.494a1 1 0 0 0 1.481.876z" clip-rule="evenodd"/></g><path fill-rule="evenodd" d="m9 18.321l9.014-4.883L9 7.804zm9.49-4.003a1 1 0 0 0 .054-1.728L9.53 6.956A1 1 0 0 0 8 7.804v10.517a1 1 0 0 0 1.476.88z" clip-rule="evenodd"/><path fill-rule="evenodd" d="M13 24.5c6.351 0 11.5-5.149 11.5-11.5S19.351 1.5 13 1.5S1.5 6.649 1.5 13S6.649 24.5 13 24.5m0 1c6.904 0 12.5-5.596 12.5-12.5S19.904.5 13 .5S.5 6.096.5 13S6.096 25.5 13 25.5" clip-rule="evenodd"/></g></svg>'''),
                  _buildButtomNavItems(
                      onTap: () {
                        navController.changeIndex(2);
                      },
                      isCurrentPage: navController.selectedIndex == 2,
                      text: "Profile",
                      icon:
                          '''<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" viewBox="0 0 24 24"><path fill="white" d="M17 9c0-1.381-.56-2.631-1.464-3.535C14.631 4.56 13.381 4 12 4s-2.631.56-3.536 1.465C7.56 6.369 7 7.619 7 9s.56 2.631 1.464 3.535C9.369 13.44 10.619 14 12 14s2.631-.56 3.536-1.465A4.984 4.984 0 0 0 17 9M6 19c0 1 2.25 2 6 2c3.518 0 6-1 6-2c0-2-2.354-4-6-4c-3.75 0-6 2-6 4"/></svg>''')

                  // SizedBox(
                  //   width: 72,
                  //   child: _customBottomNavItem(
                  //     icon: Icons.calendar_month,
                  //     txt: 'Events',
                  //     isSelected: true,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 34,
                  // ),
                  // SizedBox(
                  //   width: 100,
                  //   child: _customBottomNavItem(
                  //     icon: Icons.play_circle_outline,
                  //     txt: 'Recordings',
                  //     isSelected: false,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 34,
                  // ),
                  // SizedBox(
                  //   width: 80,
                  //   child: _customBottomNavItem(
                  //     icon: Icons.analytics,
                  //     txt: 'Analytics',
                  //     isSelected: false,
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        });
  }
}

Widget _buildButtomNavItems(
        {required String text,
        required String icon,
        bool isCurrentPage = false,
        required Function() onTap}) =>
    InkWell(
      onTap: onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 100),
        scale: isCurrentPage ? 1 : 0.86,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SvgPicture.string(icon),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  text,
                  style: AppTheme.headerStyle.copyWith(fontSize: 16),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (isCurrentPage)
              Container(
                height: 5,
                width: 40,
                decoration: const ShapeDecoration(
                  shape: StadiumBorder(),
                  color: Color(0xFFFF7848),
                ),
              )
          ],
        ),
      ),
    );
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
