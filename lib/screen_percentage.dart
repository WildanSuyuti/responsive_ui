class ScreenPercentage {
  final double phoneSmall;
  final double phone;
  final double tablet;

  ScreenPercentage({
    this.phoneSmall = 0.2,
    this.phone = 0.3,
    this.tablet = 0.2,
  })  : assert(phoneSmall <= 1),
        assert(phone <= 1),
        assert(tablet <= 1);
}
