import 'package:flutter/foundation.dart';

ButtomNavController navController = ButtomNavController();

class ButtomNavController extends ChangeNotifier {
  int selectedIndex = 0;

  changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
