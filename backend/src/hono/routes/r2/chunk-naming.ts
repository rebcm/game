export const R2_CHUNK_PREFIX = 'chunk-';
export const R2_CHUNK_VERSION_SEPARATOR = '-v';
export const R2_CHUNK_EXTENSION = '.dat';

export function getChunkKey(version, chunkName) {
  return `${R2_CHUNK_PREFIX}${chunkName}${R2_CHUNK_VERSION_SEPARATOR}${version}${R2_CHUNK_EXTENSION}`;
}
