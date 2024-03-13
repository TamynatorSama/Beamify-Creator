import 'package:beamify_creator/controller/state_manager/bloc/auth_bloc.dart';
import 'package:beamify_creator/controller/state_manager/events/auth_event.dart';
import 'package:beamify_creator/views/pages/onboarding/sign_up.dart';
import 'package:beamify_creator/views/home.dart';
import 'package:beamify_creator/views/pages/onboarding/reusables/widgets/auth_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D2224),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            SizedBox(
              child: Image.asset(
                'assets/images/microphones.png',
              ),
            ),
            SizedBox(
              child: customTextField(hintText: 'Email or Username',ctrl: emailController),
            ),
            const SizedBox(
              height: 23,
            ),
            customTextField(isPassword: true, hintText: 'Password',ctrl: passwordController),
            const SizedBox(
              height: 29,
            ),
            Row(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (_) {},
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Remember me',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.55),
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.55),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                context.read<AuthBloc>().add(LoginEvent(email: emailController.text, password: passwordController.text));
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (_) => const CreatorHome(),
                //   ),
                // );
              },
              child: customButton(txt: 'Sign in'),
            ),
            const SizedBox(height: 23),
            Row(
              children: [
                const Expanded(child: Divider()),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Or sign in using',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.55),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(
              height: 21,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loginTiles(
                  SvgPicture.string(
                    '<svg width="30" height="30" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M14.5 0C7.625 0 2 5.6125 2 12.525C2 18.775 6.575 23.9625 12.55 24.9V16.15H9.375V12.525H12.55V9.7625C12.55 6.625 14.4125 4.9 17.275 4.9C18.6375 4.9 20.0625 5.1375 20.0625 5.1375V8.225H18.4875C16.9375 8.225 16.45 9.1875 16.45 10.175V12.525H19.925L19.3625 16.15H16.45V24.9C19.3955 24.4348 22.0777 22.9319 24.0124 20.6625C25.947 18.3933 27.0068 15.507 27 12.525C27 5.6125 21.375 0 14.5 0Z" fill="white"/></svg>',
                  ),
                ),
                const SizedBox(width: 28),
                loginTiles(
                  SvgPicture.string(
                    '<svg width="27" height="27" viewBox="0 0 27 27" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M26.0743 10.539H13.4325C13.4325 11.855 13.4325 14.4868 13.4244 15.8028H20.75C20.4693 17.1188 19.474 18.9615 18.0677 19.8893C18.0677 19.8893 18.0651 19.897 18.0624 19.8957C16.1927 21.1314 13.7253 21.4118 11.8932 21.0434C9.02156 20.4722 6.74891 18.3875 5.82616 15.7398C5.83153 15.7358 5.83558 15.6993 5.83961 15.6967C5.26205 14.0543 5.26205 11.855 5.83961 10.539H5.83827C6.58238 8.12025 8.92349 5.91343 11.7992 5.30939C14.1121 4.81852 16.7219 5.3499 18.6413 7.14755C18.8965 6.89751 22.1738 3.69451 22.4196 3.43394C15.8623 -2.51041 5.36278 -0.419355 1.43403 7.25685H1.43269C1.43269 7.25685 1.43404 7.25716 1.42598 7.27163C-0.517571 11.042 -0.436983 15.4846 1.43941 19.0747C1.43404 19.0786 1.43001 19.081 1.42598 19.085C3.12643 22.3881 6.22107 24.9213 9.94969 25.886C13.9107 26.9256 18.9515 26.215 22.3282 23.158L22.3323 23.1618C25.1932 20.5825 26.9742 16.1886 26.0743 10.539Z" fill="white"/></svg>',
                  ),
                ),
                const SizedBox(width: 28),
                loginTiles(
                  SvgPicture.string(
                    '<svg width="30" height="30" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg"><g clip-path="url(#clip0_280_1995)"><path fill-rule="evenodd" clip-rule="evenodd" d="M17.9381 7.47776C18.8071 6.32171 19.3929 4.71157 19.2326 3.10953C17.9803 3.16425 16.4652 4.02774 15.5673 5.18242C14.7609 6.20712 14.057 7.84445 14.2462 9.41503C15.6432 9.53405 17.0691 8.63516 17.9381 7.47776ZM21.0707 17.6458C21.1057 21.787 24.3733 23.1646 24.4094 23.1824C24.3829 23.2795 23.8875 25.1453 22.6882 27.0743C21.6505 28.7407 20.5741 30.4003 18.8782 30.4358C17.2125 30.47 16.6761 29.3496 14.7705 29.3496C12.8662 29.3496 12.2707 30.4001 10.6942 30.4699C9.05737 30.5369 7.80987 28.6671 6.76486 27.0062C4.62664 23.6092 2.99344 17.4065 5.18711 13.2201C6.27671 11.142 8.22329 9.82397 10.3374 9.79113C11.9441 9.75693 13.4616 10.9802 14.4439 10.9802C15.4262 10.9802 17.2704 9.5095 19.2085 9.72567C20.0197 9.76261 22.2977 10.0854 23.7598 12.4399C23.6416 12.5206 21.0418 14.1845 21.0707 17.6458Z" fill="white"/></g><defs><clipPath id="clip0_280_1995"><rect width="30" height="30" fill="white"/></clipPath></defs></svg>',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 23,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const SignUp(),
                  ),
                  (_) => false,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.55),
                    ),
                  ),
                  const Text(
                    'Create New',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
