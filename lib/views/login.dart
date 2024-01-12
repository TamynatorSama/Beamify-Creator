import 'package:beamify_creator/views/home.dart';
import 'package:beamify_creator/views/reusables/widgets/auth_screen_widgets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D2224),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            SizedBox(
              child: Image.asset(
                'assets/microphones.png',
              ),
            ),
            SizedBox(
              child: customTextField(hintText: 'Email or Username'),
            ),
            const SizedBox(
              height: 23,
            ),
            customTextField(isPassword: true, hintText: 'Password'),
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CreatorHome(),
                  ),
                );
              },
              child: customButton('Sign in'),
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
                loginTiles('assets/facebook.png'),
                const SizedBox(width: 28),
                loginTiles('assets/google.png'),
                const SizedBox(width: 28),
                loginTiles('assets/apple.png'),
              ],
            ),
            const SizedBox(
              height: 23,
            ),
            Row(
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
            )
          ],
        ),
      ),
    );
  }
}
