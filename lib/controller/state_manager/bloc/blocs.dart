// ignore_for_file: depend_on_referenced_packages

import 'package:beamify_creator/controller/repository/app_repository.dart';
import 'package:beamify_creator/controller/repository/auth_repository.dart';
import 'package:beamify_creator/controller/state_manager/bloc/app_bloc.dart';
import 'package:beamify_creator/controller/state_manager/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> blocs = [
  BlocProvider(create: (context)=> AuthBloc(context.read<AuthRepository>())),
  BlocProvider(create: (context)=> AppBloc(context.read<AppRepository>())),
  
];
