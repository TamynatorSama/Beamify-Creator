import 'package:beamify_creator/controller/repository/auth_repository.dart';
import 'package:beamify_creator/controller/repository/repositories.dart';
import 'package:beamify_creator/controller/state_manager/bloc/blocs.dart';
import 'package:beamify_creator/views/pages/onboarding/login.dart';
import 'package:beamify_creator/views/pages/onboarding/onboarding.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    DevicePreview(
      // enabled: !kReleaseMode,
      enabled: false,
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: repositories,
        child: MultiBlocProvider(
            providers: blocs,
            child: const MaterialApp(
              debugShowCheckedModeBanner: false,
              // onGenerateRoute: ,
              home: RouteDecipher(),
            )));
  }
}

class RouteDecipher extends StatelessWidget {
  const RouteDecipher({super.key});
  @override
  Widget build(BuildContext context) {
    return AuthRepository.hasOpendApp ? const LoginPage() : const OnBoarding();
  }
}
