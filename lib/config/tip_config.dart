enum TipDisplayStrategy { toast, overlay }

class TipConfig {
  static TipDisplayStrategy displayStrategy = TipDisplayStrategy.toast;

  static void setDisplayStrategy(TipDisplayStrategy strategy) {
    displayStrategy = strategy;
  }
}
