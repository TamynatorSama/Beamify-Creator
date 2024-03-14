import 'dart:convert';
import 'dart:io';

import 'package:beamify_creator/controller/repository/auth_repository.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  static const String _baseUrl =
      'https://a1d7-102-88-68-92.ngrok-free.app/api';

  static Future<HttpResponse> getRequest(String url,
      {String? query, PayloadConverter? converter}) async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + url), headers: {
        "Authorization": "Bearer ${AuthRepository.token}"
      }).timeout(const Duration(seconds: 60));

      Map<String, dynamic> decodedJson = jsonDecode(response.body);

      if (converter != null) {
        return SuccessResponse.fromJson(decodedJson).withConverter(converter);
      }

      return SuccessResponse.fromJson(decodedJson);
    } on SocketException {
      return ErrorResponse(
          status: "Failure", message: "No internet connection");
    } catch (e) {
      return ErrorResponse.defaultError();
    }
  }

  static Future<HttpResponse> postRequest(String url,
      {Map<String, dynamic> payload = const {},
      PayloadConverter? converter}) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl + url),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
          // "Authorization": "Bearer ${AuthRepository.token}"
        },
        body: jsonEncode(payload)
      ).timeout(const Duration(seconds: 60));

      Map<String, dynamic> decodedJson = jsonDecode(response.body);
      print(decodedJson);

      if (converter != null) {
        return SuccessResponse.fromJson(decodedJson).withConverter(converter);
      }

      return SuccessResponse.fromJson(decodedJson);
    } on SocketException {
      return const HttpResponse(
        status: "Failure",
        message: "No internet connection",
      );
    } catch (e) {
      print(e);
      return ErrorResponse.defaultError();
    }
  }
}

class HttpResponse {
  final String status;
  final String message;

  const HttpResponse({required this.status, required this.message});

  // factory HttpResponse.fromJson(Map<String, dynamic> json) => HttpResponse(
  //     status: json['status'], message: json['message'], data: json['data']);

  // HttpResponse withConverter(PayloadConverter converter) {
  //   final data = converter(this.data as Map<String, dynamic>);
  //   return HttpResponse(status: status, message: message, data: data);
  // }

  // factory HttpResponse.defaultError() => const HttpResponse(
  //     status: "Failure",
  //     message: "Error communicating with server",
  //     data: null);

  // @override
  // String toString() => "HttpResponse(status: $status,message: $message)";
}

class SuccessResponse<T> extends HttpResponse {
  final T result;

  const SuccessResponse(
      {required this.result, required super.message, required super.status});

  factory SuccessResponse.fromJson(Map<String, dynamic> json) =>
      SuccessResponse(
          status: json['status'],
          message: json['message'],
          result: json['data']);

  SuccessResponse withConverter(PayloadConverter converter) {
    final data = converter(this.result as Map<String, dynamic>);
    return SuccessResponse(status: status, message: message, result: data);
  }

  @override
  String toString() => "SuccessResponse(status: $status,message:$message)";
}

class ErrorResponse extends HttpResponse {
  final List<String> errors;
  ErrorResponse(
      {required super.message, required super.status, this.errors = const []});

  // factory ErrorResponse.fromJson(Map<String, dynamic> json) {
  //   List<HttpError> createErrors = [];

  //   for (String key in json.keys) {
  //     createErrors.add(HttpError(
  //         errorTitle: key,
  //         errorMessage:
  //             json[key].runtimeType == String ? [json[key]] : [...json[key]]));
  //   }

  factory ErrorResponse.defaultError() => ErrorResponse(
      status: "Failure",
      message: "Error communicating with server",
      errors: []);

  //   return ErrorResponse(errors: createErrors);
  // }

  @override
  String toString() => "ErrorResponse(message:$message,errors: $errors)";
}

// class HttpError {
//   final String errorTitle;
//   final List<String> errorMessage;
//   const HttpError({required this.errorTitle, required this.errorMessage});

//   @override
//   String toString() =>
//       "HttpError(errorTitle: $errorTitle,errorMessage: $errorMessage)";
// }

typedef PayloadConverter = T Function<T>(Map<String, dynamic> json);
