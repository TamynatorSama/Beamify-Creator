import 'dart:io';

import 'package:beamify_creator/shared/http/http_helper.dart';
import 'package:beamify_creator/shared/utils/local_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  static bool hasOpendApp = false;
  static String? _token;
  static String? _userId;
  static String sectionBaseUrl = "auth";

  static String get token => _token ?? "";
  static String get userId => _userId ?? "";

  static set token(String? value) {
    Storage.storage.write(key: "token", value: value);

    _token = value;
  }

  static set userId(String? value) {
    Storage.storage.write(key: "user_id", value: value);

    _userId = value;
  }

  Future<HttpResponse> login(
      {required String email, required String password}) async {
    HttpResponse response = await HttpHelper.postRequest(
        "$sectionBaseUrl/login",
        payload: {"email": email, "password": password});
    if (response is SuccessResponse) {
      token = response.result["token"];
    }
    return response;
  }

  Future<HttpResponse> register(
      {required String email,
      required String password,
      required String username,
      required String firstName,
      required String lastName}) async {
    HttpResponse response =
        await HttpHelper.postRequest("$sectionBaseUrl/register", payload: {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "password": password,
      "username": username
    });
    if (response is SuccessResponse) {
      print(response.result);
      token = response.result["token"];
    }
    return response;
  }

  Future<HttpResponse> googleSignUp() async {
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
        // clientId: googleClientId,
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
      HttpResponse response = await HttpHelper.postRequest(
          "$sectionBaseUrl/login_with_google",
          payload: {"token": googleAuthentication.accessToken});
      if (response is SuccessResponse) {
        token = response.result["token"];
      }
      return response;
    }
    return ErrorResponse.defaultError(
        errorMessage: "please select a valid google account");
  }

  Future<HttpResponse> requestOtp(String email) async {
    HttpResponse response = await HttpHelper.getRequest(
      "$sectionBaseUrl/otp/$email/request_otp",
    );
    return response;
  }

  Future<HttpResponse> verifyOtp(String otp) async {
    HttpResponse response = await HttpHelper.postRequest(
        "$sectionBaseUrl/otp/verify_otp",
        payload: {"otp": otp});

    return response;
  }
}
