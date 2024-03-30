import 'dart:convert';
import 'dart:io';

import 'package:beamify_creator/controller/repository/auth_repository.dart';
import 'package:beamify_creator/shared/http/app_status_code.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  static const String _baseUrl = 'https://Beamify.stream/api/';

  static Future<HttpResponse> getRequest(String url, {String? query}) async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + url), headers: {
        "Authorization": "Bearer ${AuthRepository.token}"
      }).timeout(const Duration(seconds: 60));

      Map<String, dynamic> decodedJson = jsonDecode(response.body);

      return SuccessResponse.fromJson(decodedJson);
    } on SocketException {
      return ErrorResponse(
          status: "Failure", message: "No internet connection");
    } catch (e) {
      return ErrorResponse.defaultError();
    }
  }

  static Future<HttpResponse> postRequest(
    String url, {
    Map<String, dynamic> payload = const {},
  }) async {
    print(payload);
    try {
      final response = await http
          .post(Uri.parse(_baseUrl + url),
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json"
                // "Authorization": "Bearer ${AuthRepository.token}"
              },
              body: jsonEncode(payload))
          .timeout(const Duration(seconds: 60));
      print(response.statusCode);
      Map<String, dynamic> decodedJson = jsonDecode(response.body);
      print(decodedJson);
      if (response.statusCode == AppStatusCode.successful ||
          response.statusCode == AppStatusCode.created) {
        return SuccessResponse.fromJson(decodedJson);
      }
      if (response.statusCode == AppStatusCode.validationError) {
        return ValidationError.fromJson(decodedJson);
      }
      return ErrorResponse.defaultError();
    } on SocketException catch (e) {
      print(e.message);
      print("socket");
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
  ErrorResponse({
    required super.message,
    required super.status,
  });

  // factory ErrorResponse.fromJson(Map<String, dynamic> json) {
  //   List<HttpError> createErrors = [];

  //   for (String key in json.keys) {
  //     createErrors.add(HttpError(
  //         errorTitle: key,
  //         errorMessage:
  //             json[key].runtimeType == String ? [json[key]] : [...json[key]]));
  //   }

  factory ErrorResponse.defaultError() => ErrorResponse(
      status: "Failure", message: "Error communicating with server");

  //   return ErrorResponse(errors: createErrors);
  // }

  @override
  String toString() => "ErrorResponse(message:$message)";
}

class ValidationError extends ErrorResponse {
  final List<ResponseError> errors;
  ValidationError(
      {required this.errors, required super.message, required super.status});

  factory ValidationError.fromJson(Map<String, dynamic> json) {
    Iterable errorKeys = (json["errors"] as Map<String, dynamic>).keys;

    List<Map<String, dynamic>> formattedErrors = errorKeys
        .map((e) => {"title": e, "message": json["errors"][e]})
        .toList();

    return ValidationError(
        errors: formattedErrors.map((e) => ResponseError.fromJson(e)).toList(),
        message: json["message"],
        status: "Validation Error");
  }
}

class ResponseError {
  final String errorTitle;
  final List<String> errorMessage;
  const ResponseError({required this.errorTitle, required this.errorMessage});

  factory ResponseError.fromJson(Map<String, dynamic> json) {
    return ResponseError(
        errorTitle: json["title"],
        errorMessage: (json["message"] as List<dynamic>)
            .map((e) => e.toString())
            .toList());
  }

  @override
  String toString() =>
      "HttpError(errorTitle: $errorTitle,errorMessage: $errorMessage)";
}

typedef PayloadConverter = T Function<T>(Map<String, dynamic> json);
