import 'package:beamify_creator/controller/state_manager/bloc/auth_bloc.dart';
import 'package:beamify_creator/controller/state_manager/events/auth_event.dart';
import 'package:beamify_creator/controller/state_manager/state/auth_state.dart';
import 'package:beamify_creator/shared/social_auth_button.dart';
import 'package:beamify_creator/shared/utils/FeedbackDialog/error_dialog.dart';
import 'package:beamify_creator/shared/utils/app_theme.dart';
import 'package:beamify_creator/shared/utils/custom_button.dart';
import 'package:beamify_creator/shared/utils/custom_input_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (kDebugMode) {
      emailController.text = "dadefemiwa@gmail.com";
      usernameController.text = "Tamynator";
      passwordController.text = "T@mil0re";
      confirmController.text = "T@mil0re";
      lastNameController.text = "Kolawole";
      firstNameController.text = "Tamilore";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 20,
              ),
              buildSocialLogins(
                "assets/icons/Arrow-Left.svg",
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create Account",
                    style: AppTheme.headerStyle,
                  ),
                  Text(
                    "Register now and start exploring  all that our app has to offer.",
                    style: AppTheme.bodyText
                        .copyWith(color: Colors.white.withOpacity(0.7)),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    clipBehavior: Clip.antiAlias,
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(children: [
                          Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  CustomInputField(
                                      hintText: "First Name",
                                      inputType: TextInputType.name,
                                      controller: firstNameController),
                                      const SizedBox(
                                    height: 20,
                                  ),
                                      CustomInputField(
                                      hintText: "Last Name",
                                      inputType: TextInputType.name,
                                      controller: lastNameController),
                                      const SizedBox(
                                    height: 20,
                                  ),
                                  CustomInputField(
                                      hintText: "Email",
                                      inputType: TextInputType.emailAddress,
                                      controller: emailController),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomInputField(
                                    hintText: "Choose a password",
                                    controller: passwordController,
                                    inputType: TextInputType.visiblePassword,
                                    isPassword: true,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomInputField(
                                    hintText: "Confirm your password",
                                    controller: confirmController,
                                    inputType: TextInputType.visiblePassword,
                                    isPassword: true,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "this field cannot be empty";
                                      }
                                      if (value != passwordController.text) {
                                        return "password does not match";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomInputField(
                                    hintText: "Choose a username",
                                    controller: usernameController,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          BlocBuilder<AuthBloc,AuthState>(
                            builder: (context,controller) {
                              return CustomButton(
                                  text: "Sign up",
                                  isLoading: controller.isLoading,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthBloc>().add(RegisterEvent(
                                        context,
                                          email: emailController.text.trim(),
                                          firstName: firstNameController.text,
                                          lastName: lastNameController.text,
                                          password: passwordController.text,
                                          username: usernameController.text,
                                          errorCallback: (value)=>showErrorFeedback(context,message: value)
                                          ),
                                        
                                          );
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         const ConfirmAccount()));
                                    }
                                  });
                            }
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: Text(
                              "By logging. your agree to our  Terms & Conditions  and Privacy Policy.",
                              textAlign: TextAlign.center,
                              style: AppTheme.bodyText.copyWith(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 13),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
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
                                    "Or sign up using ",
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
                              buildSocialLogins("assets/icons/facebook.svg"),
                              buildSocialLogins("assets/icons/google.svg"),
                              buildSocialLogins("assets/icons/apple.svg")
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: RichText(
                                text: TextSpan(
                                    children: [
                                  const TextSpan(
                                      text: "Already have an account? "),
                                  TextSpan(
                                      text: " Login",
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
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
