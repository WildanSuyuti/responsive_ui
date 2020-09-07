import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_ui/sizing_information.dart';

class ResponsiveUI {
  double width;
  double height;
  double blockWidth = 0;
  double blockHeight = 0;

  Multiplier _multiplier = Multiplier.blockHeight;
  SizingInformation _information;
  double _percentagePhoneSmall;
  double _percentagePhone;
  double _percentageTablet;

  static final ResponsiveUI _instance = ResponsiveUI._internal();

  ResponsiveUI._internal();

  static ResponsiveUI get instance => _instance;

  ResponsiveUI.init(BoxConstraints constraints, Orientation orientation,
      {Multiplier multiplier = Multiplier.blockHeight}) {
    DeviceType device = DeviceType.phone;
    _multiplier = multiplier;

    if (orientation == Orientation.landscape) {
      width = constraints.maxHeight;
      height = constraints.maxWidth;
      if (height > 600) device = DeviceType.tablet;
      if (height < 480) device = DeviceType.phoneSmall;
    } else {
      width = constraints.maxWidth;
      height = constraints.maxHeight;
      if (width > 600) device = DeviceType.tablet;
      if (width < 480) device = DeviceType.phoneSmall;
    }

    if (device == DeviceType.tablet) {
      _scale(_percentageTablet ?? 0.2);
    } else if (device == DeviceType.phone)
      _scale(_percentagePhone ?? 0.3);
    else
      _scale(_percentagePhoneSmall ?? 0.25);

    _information = SizingInformation(device, orientation);
    print(_information.toString());
  }

  _scale(double percentage) {
    blockHeight = (width / 100) * percentage;
    blockWidth = (height / 100) * percentage;
  }

  double size(double size, {Multiplier multiplier}) {
    if (multiplier != null) _multiplier = multiplier;
    return size * (_multiplier == Multiplier.blockHeight ? blockHeight : blockWidth);
  }

  double resize({double phoneSmall, double phone, double tablet}) {
    var device = _information.deviceType;
    if (device == DeviceType.phoneSmall && phoneSmall != null) {
      return size(phoneSmall);
    } else if (device == DeviceType.phone && phone != null) {
      return size(phone);
    } else if (device == DeviceType.tablet && tablet != null) {
      return size(tablet);
    }
    return size(14);
  }


  //range 0 - 1 ex 0.5 , 0.9
  screenPercentage({double phoneSmall, double phone, double tablet}) {
    _percentagePhoneSmall = phoneSmall;
    _percentagePhone = phone;
    _percentageTablet = tablet;
  }
}

enum DeviceType { phoneSmall, phone, tablet }

enum Multiplier { blockHeight, blockWidth }
