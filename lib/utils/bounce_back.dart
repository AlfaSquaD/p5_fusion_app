import 'dart:async';

import 'package:flutter/widgets.dart';

class BounceBack {
  Timer? _timer;

  void start(
      {Duration duration = const Duration(milliseconds: 500),
      required VoidCallback onComplete}) {
    _timer?.cancel();
    _timer = Timer(duration, onComplete);
  }
}
