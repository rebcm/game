import 'package:rebcm/models/block_metadata.dart';
import 'package:rebcm/blocos/block.dart';

class BlockMetadataExtractor {
  static List<BlockMetadata> extractMetadata() {
    List<BlockMetadata> metadataList = [];

    // Assuming Block classes are in ./lib/blocos directory
    // and they all extend the base Block class
    // This is a simplified example; actual implementation may vary based on the project structure

    // For demonstration, let's assume we have a list of block classes
    List<Type> blockClasses = [
      // Add block classes here, e.g., DirtBlock, StoneBlock, etc.
    ];

    for (var blockClass in blockClasses) {
      // Create an instance of the block class
      Block blockInstance = _createBlockInstance(blockClass);

      // Extract metadata from the block instance
      BlockMetadata metadata = BlockMetadata(
        name: blockInstance.name,
        description: blockInstance.description,
      );

      metadataList.add(metadata);
    }

    return metadataList;
  }

  static Block _createBlockInstance(Type blockClass) {
    // Implement a way to create an instance of the given block class
    // This could involve using reflection or a factory method
    // For simplicity, let's assume we have a factory method
    return BlockFactory.createBlock(blockClass);
  }
}
