// ignore_for_file: depend_on_referenced_packages

import 'package:beamify_creator/controller/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> repositories = [
  RepositoryProvider(create: (_)=> AuthRepository()),
];
