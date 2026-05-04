class Volume {
  final double value;

  Volume(this.value) {
    if (value == null || value < 0.0 || value > 1.0) {
      throw ArgumentError('Volume must be between 0.0 and 1.0');
    }
  }
}
