import 'dart:io';

import 'package:beamify_creator/controller/repository/auth_repository.dart';
import 'package:beamify_creator/controller/repository/repositories.dart';
import 'package:beamify_creator/controller/state_manager/bloc/app_bloc.dart';
import 'package:beamify_creator/controller/state_manager/bloc/blocs.dart';
import 'package:beamify_creator/controller/state_manager/state/app_state.dart';
import 'package:beamify_creator/firebase_options.dart';
import 'package:beamify_creator/shared/http/http_override.dart';
import 'package:beamify_creator/shared/utils/app_theme.dart';
import 'package:beamify_creator/shared/utils/local_storage.dart';
import 'package:beamify_creator/views/create_channel.dart';
import 'package:beamify_creator/views/pages/onboarding/login.dart';
import 'package:beamify_creator/views/pages/onboarding/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  HttpOverrides.global = MyHttpoverrides();
  Storage.initStorage();
  runApp(
    DevicePreview(
      // enabled: !kReleaseMode,
      enabled: false,
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  static final mainNavigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: repositories,
        child: MultiBlocProvider(
            providers: blocs,
            child: MaterialApp(
              key: MainApp.mainNavigatorKey,
              debugShowCheckedModeBanner: false,
              builder: (context, child) =>
                  BlocBuilder<AppBloc, AppState>(builder: (context, blo) {
                return Stack(
                  children: [
                    child!,
                    if (blo.isLoading)
                      Container(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        color: Colors.black.withOpacity(0.6),
                        child: const Column(
                          children: [
                            LinearProgressIndicator(
                              color: AppTheme.primaryColor,
                            ),
                          ],
                        ),
                      )
                  ],
                );
              }),

              // onGenerateRoute: ,
              home: const CreateChannel()
              // const RouteDecipher(),
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
