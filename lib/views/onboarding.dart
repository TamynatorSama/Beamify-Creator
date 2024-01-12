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
                  Stack(
                    children: [
                      const Stack(
                        children: [
                          CircleAvatar(
                            radius: 149,
                            backgroundColor: Colors.red,
                            backgroundImage:
                                AssetImage('assets/onboarding_1.png'),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: CircleAvatar(
                              radius: 37,
                              backgroundColor: Colors.red,
                              backgroundImage:
                                  AssetImage('assets/onboarding_2.png'),
                            ),
                          ),
                        ],
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
                  )
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