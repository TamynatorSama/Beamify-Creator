import 'package:beamify_creator/controller/state_manager/bloc/auth_bloc.dart';
import 'package:beamify_creator/controller/state_manager/events/auth_event.dart';
import 'package:beamify_creator/controller/state_manager/state/auth_state.dart';
import 'package:beamify_creator/shared/social_auth_button.dart';
import 'package:beamify_creator/shared/utils/FeedbackDialog/error_dialog.dart';
import 'package:beamify_creator/shared/utils/app_theme.dart';
import 'package:beamify_creator/shared/utils/custom_button.dart';
import 'package:beamify_creator/shared/utils/custom_input_field.dart';
import 'package:beamify_creator/views/pages/onboarding/sign_up.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (kDebugMode) {
      emailController.text = "dr3ymi@gmail.com";
      passwordController.text = "Foobarbaz1!";
    }

    super.initState();
  }

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
                              key: _formKey,
                              child: Column(
                                children: [
                                  CustomInputField(
                                      hintText: "Email or Username",
                                      inputType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if ((value as String).isEmpty) {
                                          return 'Email field is required';
                                        }
                                        if (!RegExp(
                                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                            .hasMatch(emailController.text) && !RegExp(
                                                r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$')
                                            .hasMatch(emailController.text)  ) {
                                          return "enter a valid email or username";
                                        }
                                        return null;
                                      },
                                      controller: emailController),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomInputField(
                                    hintText: "Password",
                                    controller: passwordController,
                                    isPassword: true,
                                    inputType: TextInputType.visiblePassword,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                              value: rememberMe,
                                              activeColor:
                                                  AppTheme.primaryColor,
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
                          BlocBuilder<AuthBloc,AuthState>(
                            builder: (context,controller) {
                              return CustomButton(
                                  text: "Sign in",
                                  isLoading: controller.isLoading,
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthBloc>().add(LoginEvent(
                                        context,
                                          email: emailController.text.trim(),
                                          password: passwordController.text,
                                          errorCallback: (value)=>showErrorFeedback(context,message: value))
                                          );
                                    }
                                    // context.read<Logi>();
                                    //            Navigator.of(context).push(MaterialPageRoute(
                                    // builder: (context) => const CreatorHome()));
                                  });
                            }
                          ),
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
                              GestureDetector(
                                onTap:(){
                                  context.read<AuthBloc>().add(GoogleSignupEvent(context)
                                          );
                                },child:buildSocialLogins("assets/images/google.svg"),
                              ),
                              
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
