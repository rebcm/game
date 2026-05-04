class ResolutionMatrix {
  static const List<Size> resolutions = [
    Size(320, 480),
    Size(375, 667),
    Size(414, 896),
  ];
}

class Size {
  final double width;
  final double height;

  const Size(this.width, this.height);
}
