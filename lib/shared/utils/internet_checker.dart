import 'dart:io';

class InternetChecker {
  static Future<bool> checkInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('beamify.stream');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
