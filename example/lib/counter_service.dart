import 'package:flutter/foundation.dart';

class CounterService with ChangeNotifier {
  double _counter = 14;

  double get counter => _counter;

  set counter(double value) {
    if (value >= 1 && value <= 50) {
      _counter = value;
      notifyListeners();
    }
  }
}
