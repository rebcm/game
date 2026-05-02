class WorldPayloadValidator {
  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name is required';
    }
    if (name.length > 50) {
      return 'Name must be less than 50 characters';
    }
    return null;
  }

  static String? validateChunkData(List<int>? chunkData) {
    if (chunkData == null || chunkData.isEmpty) {
      return 'Chunk data is required';
    }
    if (chunkData.length > 10000) {
      return 'Chunk data must be less than 10000 bytes';
    }
    return null;
  }
}
