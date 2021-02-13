import 'package:flutter/cupertino.dart';

class PriorityService extends ChangeNotifier {
  int _counter = 0;
  bool _isVisible = false;

  int get counter => _counter;
  bool get isVisible => _isVisible;

  void lowPriority() {
    _counter = 1;
    _isVisible = true;
    notifyListeners();
  }

  void normalPriority() {
    _counter = 2;
    _isVisible = true;
    notifyListeners();
  }

  void highPriority() {
    _counter = 3;
    _isVisible = true;
    notifyListeners();
  }
}
