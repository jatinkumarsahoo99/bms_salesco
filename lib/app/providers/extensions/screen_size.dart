import 'package:flutter/material.dart';

extension DeviceSize on BuildContext {
  double get devicewidth => MediaQuery.of(this).size.width;
  double get deviceheight => MediaQuery.of(this).size.height;
}
