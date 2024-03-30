import 'dart:io';

import 'package:beamify_creator/const.dart';
import 'package:beamify_creator/shared/http/http_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  static bool hasOpendApp = false;
  static String? _token;
  static String sectionBaseUrl = "auth";

  static String get token => _token ?? "";

  static set token(String? value) {
    _token = value;
  }

  Future<void> login({required String email, required String password}) async {
    print("object");
    HttpResponse response = await HttpHelper.postRequest(
        "$sectionBaseUrl/login",
        payload: {"email": email, "password": password});
    print(response.message);
  }

  Future<HttpResponse> register(
      {required String email,
      required String password,
      required String username,
      required String firstName,
      required String lastName
      }) async {
    HttpResponse response =
        await HttpHelper.postRequest("$sectionBaseUrl/register", payload: {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "password": password, "username": username
    });
    return response;
  }

  Future<void> googleSignUp() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    if (kIsWeb || Platform.isAndroid) {
      googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );
    }

    if (Platform.isIOS || Platform.isMacOS) {
      googleSignIn = GoogleSignIn(
        clientId: googleClientId,
        scopes: [
          'email',
        ],
      );
    }

    final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();

    print("account information");
    print(googleAccount);

    final GoogleSignInAuthentication googleAuthentication =
        await googleAccount!.authentication;

    print("additional information");
    print(googleAuthentication.accessToken);
    if (googleAuthentication.accessToken != null) {
      // HttpHelper.getRequest()
    }
  }
}
