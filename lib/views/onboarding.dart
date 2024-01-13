import 'package:beamify_creator/views/login.dart';
import 'package:beamify_creator/views/reusables/widgets/auth_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: size.height * 0.6,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0B0B0C),
                      Color(0xFF272F31),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0B0B0C),
                      Color(0xFF272F31),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ))
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(36.0, 0, 0, 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  Stack(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 300,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 149,
                                backgroundImage: AssetImage(
                                  'assets/images/onboarding_1.png',
                                ),
                              ),
                              Positioned(
                                left: 0,
                                bottom: 10,
                                child: CircleAvatar(
                                  radius: 37,
                                  backgroundImage: AssetImage(
                                    'assets/images/onboarding_2.png',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 78),
                          Align(
                            alignment: Alignment.topLeft,
                            child: SvgPicture.string(
                              '<svg width="22" height="7" viewBox="0 0 22 7" fill="none" xmlns="http://www.w3.org/2000/svg"><rect x="21.7292" y="6.94788" width="21.7292" height="6.20833" transform="rotate(180 21.7292 6.94788)" fill="#D9B38C"/></svg>',
                            ),
                          ),
                          const SizedBox(height: 86),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: SvgPicture.string(
                              '<svg width="84" height="57" viewBox="0 0 84 57" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="Right lines"><rect id="Line" x="69.2344" y="56.4115" width="68.2917" height="6.20833" transform="rotate(180 69.2344 56.4115)" fill="#FF7848"/><rect id="Line_2" x="84.7552" y="31.5781" width="45.0104" height="6.20833" transform="rotate(180 84.7552 31.5781)" fill="#FF7848"/><rect id="Line_3" x="57.5938" y="6.74475" width="45.0104" height="6.20833" transform="rotate(180 57.5938 6.74475)" fill="#FF7848"/></g></svg>',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  SvgPicture.string(
                    '<svg width="190" height="95" viewBox="0 0 190 95" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="Audio track"><rect id="Color stripe 6" x="148.148" y="14.8148" width="11.8519" height="65.9259" fill="#D9B38C"/><rect id="Color stripe 5" x="118.519" width="11.8519" height="94.8148" fill="#95968E"/><rect id="Color stripe 4" x="88.8889" y="29.2594" width="11.8519" height="36.6667" fill="#D9B38C"/><rect id="Color stripe 3" x="59.2592" y="14.8148" width="11.8519" height="65.9259" fill="#95968E"/><rect id="Color stripe 2" x="29.6296" width="11.8519" height="94.8148" fill="#D9B38C"/><rect id="Color stripe 1" y="29.2594" width="11.8519" height="36.6667" fill="#95968E"/><rect id="Color stripe 7" x="178" y="29" width="11.8519" height="36.6667" fill="#95968E"/></g></svg>',
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.headphones,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        'Beamify',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'for Creators',
                    style: TextStyle(
                      color: Color(0xFFD9B38C),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                        (_) => false,
                      );
                    },
                    child: customButton(
                      txt: 'Start',
                      width: 158,
                      isPill: true,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// #0B0B0CEB, #272F31