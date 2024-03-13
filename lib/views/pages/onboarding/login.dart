import 'package:beamify_creator/shared/social_auth_button.dart';
import 'package:beamify_creator/shared/utils/app_theme.dart';
import 'package:beamify_creator/shared/utils/custom_button.dart';
import 'package:beamify_creator/shared/utils/custom_input_field.dart';
import 'package:beamify_creator/views/pages/onboarding/sign_up.dart';
import 'package:beamify_creator/views/home.dart';
import 'package:flutter/material.dart';

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


  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                        child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(children: [
                          Image.asset(
                            "assets/images/microphones.png",
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height * 0.4,
                          ),
                          Form(
                              child: Column(
                            children: [
                              CustomInputField(
                                  hintText: "Email or Username",
                                  controller: TextEditingController()),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomInputField(
                                hintText: "Password",
                                controller: TextEditingController(),
                                isPassword: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: rememberMe,
                                          activeColor: AppTheme.primaryColor,
                                          checkColor: Colors.black,
                                          onChanged: (value) {
                                            rememberMe = value ?? false;
                                            setState(() {});
                                          }),
                                      Text(
                                        "Remember me",
                                        style: AppTheme.bodyText
                                            .copyWith(fontSize: 14),
                                      )
                                    ],
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Forget Password?",
                                        style: AppTheme.bodyText
                                            .copyWith(fontSize: 14),
                                      ))
                                ],
                              ),
                            ],
                          )),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomButton(
                              text: "Sign in",
                              onTap: () {
                               Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreatorHome()));
                              }),
                          const SizedBox(
                            height: 25,
                          ),
                          Opacity(
                            opacity: 0.7,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  height: 1,
                                  color: Colors.white,
                                )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    "Or sign in using ",
                                    style: AppTheme.bodyText
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  height: 1,
                                  color: Colors.white,
                                ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Wrap(
                            spacing: 30,
                            children: [
                              buildSocialLogins("assets/images/facebook.svg"),
                              buildSocialLogins("assets/images/google.svg"),
                              buildSocialLogins("assets/images/apple.svg")
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SignUp()));
                            },
                            child: RichText(
                                text: TextSpan(
                                    children: [
                                  const TextSpan(
                                      text: "Don’t have an account? "),
                                  TextSpan(
                                      text: " Create new",
                                      style: AppTheme.bodyText.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600))
                                ],
                                    style: AppTheme.bodyText.copyWith(
                                        fontSize: 13,
                                        color: Colors.white.withOpacity(0.6),
                                        fontWeight: FontWeight.w600))),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom + 20,
                          ),
                        ]),
                      ),
                    )))));
  }
}
