import 'package:flutter/widgets.dart';
import 'package:responsive_ui/responsive_ui.dart';

class SizingInformation {
  DeviceType deviceType;
  Orientation orientation;

  SizingInformation(this.deviceType, this.orientation);

  @override
  String toString() =>
      'SizingInformation{deviceType: $deviceType, orientation: $orientation}';
}
