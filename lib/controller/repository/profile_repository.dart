import 'package:beamify_creator/controller/repository/auth_repository.dart';

class ProfileRepository {
  static String sectionBaseUrl = "profile";

  static String get token => AuthRepository.token;

}