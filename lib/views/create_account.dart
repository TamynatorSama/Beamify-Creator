import 'package:beamify_creator/views/reusables/widgets/auth_screen_widgets.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D2224),
      body: Column(
        children: [
          Container(
            height: 100 + MediaQuery.of(context).padding.top,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
              left: 24,
              top: MediaQuery.of(context).padding.top,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(
                  //   height: 14,
                  // ),
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Register now and start exploring  all that our app has to offer.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 19),
                  customTextField(
                    hintText: 'Email or phone number',
                  ),
                  const SizedBox(height: 24),
                  customTextField(
                    hintText: 'Choose a password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 24),
                  customTextField(
                    hintText: 'Confirm your password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 24),
                  customTextField(
                    hintText: 'Choose a username',
                  ),
                  const SizedBox(height: 24),
                  customButton('Sign up'),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 240,
                      child: Text(
                        'By signing up, you agree to our Terms & Conditions and Privacy Policy',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Or sign up using',
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
                        'Already have an account? ',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.55),
                        ),
                      ),
                      const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
