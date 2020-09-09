library responsive_ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_ui/screen_percentage.dart';
import 'package:responsive_ui/sizing_information.dart';

class ResponsiveUI {
  double width;
  double height;
  double blockWidth = 0;
  double blockHeight = 0;

  Multiplier _multiplier = Multiplier.blockHeight;
  SizingInformation _information;
  ScreenPercentage _screenPercentage;

  static final ResponsiveUI _instance = ResponsiveUI._internal();

  ResponsiveUI._internal();

  static ResponsiveUI get instance => _instance;

  factory ResponsiveUI.init(BoxConstraints constraints, Orientation orientation,
          {Multiplier multiplier = Multiplier.blockHeight}) =>
      _instance.._init(constraints, orientation);

  _init(BoxConstraints constraints, Orientation orientation,
      {Multiplier multiplier = Multiplier.blockHeight}) {
    _multiplier = multiplier;
    _screenPercentage = ScreenPercentage();
    DeviceType device = DeviceType.phone;
    bool isLandscape = orientation == Orientation.landscape;

    width = isLandscape ? constraints.maxHeight : constraints.maxWidth;
    height = isLandscape ? constraints.maxWidth : constraints.maxHeight;

    if (isLandscape && height > 600 || !isLandscape && width > 600)
      device = DeviceType.tablet;
    else if (isLandscape && height < 480 || !isLandscape && width < 480)
      device = DeviceType.phoneSmall;

    switch (device) {
      case DeviceType.phoneSmall:
        _scale(_screenPercentage.phoneSmall);
        break;
      case DeviceType.tablet:
        _scale(_screenPercentage.tablet);
        break;
      default:
        _scale(_screenPercentage.phone);
        break;
    }

    _information = SizingInformation(device, orientation);
    print(_information.toString());
  }

  _scale(double percentage) {
    blockWidth = (width / 100) * percentage;
    blockHeight = (height / 100) * percentage;
  }

  double size(double size, [Multiplier multiplier]) {
    if (multiplier != null) _multiplier = multiplier;
    return size *
        (_multiplier == Multiplier.blockHeight ? blockHeight : blockWidth);
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
  screenPercentage({ScreenPercentage screenPercentage}) =>
      _screenPercentage = screenPercentage;
}

enum DeviceType { phoneSmall, phone, tablet }

enum Multiplier { blockHeight, blockWidth }
