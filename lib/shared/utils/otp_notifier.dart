import 'dart:async';

import 'package:flutter/foundation.dart';

OtpNotifier notify = OtpNotifier();

class OtpNotifier extends ChangeNotifier {
  Timer? _timer;
  int resendTime = 30;
  startTimer() {
    if (_timer != null && _timer!.isActive) return;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        print("print: ${resendTime}");
        resendTime = resendTime - 1;

        if (resendTime <= 0) {
          timer.cancel();
          resendTime = 30;
        }
        notifyListeners();
      });
    }
    
  
}
