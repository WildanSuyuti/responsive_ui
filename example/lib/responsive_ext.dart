import 'package:responsive_ui/responsive_ui.dart';

extension ResponsiveExt on ResponsiveUI {
  double get fontTitle => size(18);

  double get fontSubtitle => size(16);

  double get fontNormal => size(14);

  double get fontMedium => size(12);

  double get fontSmall => size(10);

  double get fontXtraSmall => size(8);
}

ResponsiveUI get responsive => ResponsiveUI.instance;
