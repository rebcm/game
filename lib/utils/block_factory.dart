class BlockFactory {
  static Block createBlock(Type blockClass) {
    // Implement logic to create block instances based on the type
    // For demonstration, let's assume we have a simple implementation
    if (blockClass == DirtBlock) return DirtBlock();
    // Add more conditions for other block classes
    throw UnsupportedError('Unsupported block class: $blockClass');
  }
}
