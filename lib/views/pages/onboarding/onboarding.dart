import 'package:beamify_creator/views/pages/onboarding/login.dart';
import 'package:beamify_creator/views/pages/onboarding/reusables/widgets/auth_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';



Future<void> _checkIfIsLogged() async {
  final accessToken = await FacebookAuth.instance.accessToken;
  // setState(() {
  //   _checking = false;
  // });
  if (accessToken != null) {
    print("is Logged:::: ${accessToken.toJson()}");
    // now you can call to  FacebookAuth.instance.getUserData();
    final userData = await FacebookAuth.instance.getUserData();
    // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
    // _accessToken = accessToken;
    // setState(() {
    //   _userData = userData;
    // });
    print(userData);
  }
}

void _printCredentials() {
  // print(
  //   _accessToken!.toJson()),
  // );
}

Future<void> facebookLogin() async {
  final LoginResult result = await FacebookAuth.instance
      .login(); // by default we request the email and the public profile

  // loginBehavior is only supported for Android devices, for ios it will be ignored
  // final result = await FacebookAuth.instance.login(
  //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
  //   loginBehavior: LoginBehavior
  //       .DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
  // );

  if (result.status == LoginStatus.success) {
    final accessToken = result.accessToken;
    print(accessToken);
    // get the user data
    // by default we get the userId, email,name and picture
    final userData = await FacebookAuth.instance.getUserData();
    // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
    // _userData = userData;
    print(userData);
  } else {
    print(result.status);
    print(result.message);
  }

  // setState(() {
  //   _checking = false;
  // });
}

Future<void> _logOut() async {
  await FacebookAuth.instance.logOut();
  // _accessToken = null;
  // _userData = null;
  // setState(() {});
}

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
                      // googleAuth();
                      // facebookLogin();
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