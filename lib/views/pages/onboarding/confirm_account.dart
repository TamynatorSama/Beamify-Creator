import 'package:beamify_creator/controller/state_manager/bloc/auth_bloc.dart';
import 'package:beamify_creator/controller/state_manager/events/auth_event.dart';
import 'package:beamify_creator/controller/state_manager/state/auth_state.dart';
import 'package:beamify_creator/shared/social_auth_button.dart';
import 'package:beamify_creator/shared/utils/app_theme.dart';
import 'package:beamify_creator/shared/utils/custom_button.dart';
import 'package:beamify_creator/shared/utils/otp_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class ConfirmAccount extends StatefulWidget {
  final String email;
  const ConfirmAccount({super.key, required this.email});

  @override
  State<ConfirmAccount> createState() => _ConfirmAccountState();
}

class _ConfirmAccountState extends State<ConfirmAccount> {
  TextEditingController controller = TextEditingController();
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
                    "Confirm Account",
                    style: AppTheme.headerStyle,
                  ),
                  Text(
                    "A registration confirmation code Will be sent to your Email Address.",
                    style: AppTheme.bodyText
                        .copyWith(color: Colors.white.withOpacity(0.7)),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 4,
                controller: controller,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // controller: controller.otpController,
                defaultPinTheme: PinTheme(
                    height: 50,
                    width: 50,
                    textStyle:
                        AppTheme.buttonStyle.copyWith(color: Colors.white),
                    decoration: BoxDecoration(
                        color: const Color(0xff232429),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1, color: Colors.grey))),
              ),
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<AuthBloc,AuthState>(
                            builder: (context,control)=>CustomButton(
                      text: "Confirm",
                      isLoading: control.isLoading,
                      onTap: () {
                        context
                            .read<AuthBloc>()
                            .add(VerifyOtpEvent(controller.text,context));
                      
                }
              )),
              AnimatedBuilder(
                animation: notify,
                builder: (context, value) => Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        if (notify.resendTime == 30) {
                          notify.startTimer();
                          context
                              .read<AuthBloc>()
                              .add(SendOtpEvent(widget.email,context));
                        }
                      },
                      child: Text(
                        notify.resendTime == 30
                            ? "Resend Code"
                            : "Request again in 0:${notify.resendTime < 10 ? '0${notify.resendTime}' : notify.resendTime.toString()}",
                        style: AppTheme.bodyText.copyWith(fontSize: 14),
                      )),
                ),
              ),
              const Spacer(),
              RichText(
                  text: TextSpan(
                      children: [
                    const TextSpan(
                        text: "By clicking “ CONFIRM “  you accepted our "),
                    TextSpan(
                        text: "Terms & Conditions ",
                        style: AppTheme.bodyText.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w700)),
                    const TextSpan(text: " of the "),
                    TextSpan(
                        text: "User Agreement",
                        style: AppTheme.bodyText.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w700)),
                  ],
                      style: AppTheme.bodyText.copyWith(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.6),
                          fontWeight: FontWeight.w500))),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom + 20,
              ),
            ],
          )),
    );
  }
}
