class RebecaAnimation {
  bool _isAnimating = false;

  bool get isAnimating => _isAnimating;

  void animate() {
    _isAnimating = true;
    // animation logic here
  }

  void stop() {
    _isAnimating = false;
    // stop animation logic here
  }
}
