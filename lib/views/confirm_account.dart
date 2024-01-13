import 'package:beamify_creator/views/reusables/widgets/auth_screen_widgets.dart';
import 'package:flutter/material.dart';

class ConfirmAccount extends StatelessWidget {
  const ConfirmAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D2224),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100 + MediaQuery.of(context).padding.top,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
            ),
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
            const SizedBox(
              height: 12,
            ),
            Wrap(
              direction: Axis.horizontal,
              children: [
                Container(
                  height: 48,
                  width: 53,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(8),
                  child: const Text(''),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  height: 48,
                  width: 53,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(8),
                  child: const Text(''),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  height: 48,
                  width: 53,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(8),
                  child: const Text(''),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  height: 48,
                  width: 53,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(8),
                  child: const Text(''),
                ),
                const SizedBox(
                  width: 16,
                ),
                Container(
                  height: 48,
                  width: 53,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(8),
                  child: const Text(''),
                ),
              ],
            ),
            const SizedBox(
              height: 33,
            ),
            customButton(txt: 'Confirm'),
            const SizedBox(
              height: 4,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Resend code',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.55),
                    fontWeight: FontWeight.w300),
              ),
            ),
            const Spacer(),
            Text(
              'By clicking “ CONFIRM “ you accepted our Terms & Conditions of the User Agreement',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.55),
                  fontWeight: FontWeight.w300,
                  fontSize: 12),
            ),
            SizedBox(
              height: 12 + MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
