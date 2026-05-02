class MaterialProperties {
  static const Map<String, MaterialProperty> properties = {
    'terra': MaterialProperty(friction: 0.8, bounce: 0.1),
    'agua': MaterialProperty(friction: 0.2, bounce: 0.7),
    'gelo': MaterialProperty(friction: 0.1, bounce: 0.9),
    'madeira': MaterialProperty(friction: 0.6, bounce: 0.3),
    'metal': MaterialProperty(friction: 0.4, bounce: 0.5),
  };
}

class MaterialProperty {
  final double friction;
  final double bounce;

  const MaterialProperty({required this.friction, required this.bounce});
}
