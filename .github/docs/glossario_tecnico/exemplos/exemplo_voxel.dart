/// Exemplo de uso do termo Voxel
class Voxel {
  int x, y, z; // Coordenadas do voxel
  int tipo;    // Tipo do voxel (e.g., terra, água, etc.)

  Voxel(this.x, this.y, this.z, this.tipo);

  /// Método para renderizar o voxel
  void render() {
    // Implementação da renderização do voxel
  }
}

void main() {
  Voxel meuVoxel = Voxel(0, 0, 0, 1); // Cria um voxel na origem do tipo 1
  meuVoxel.render(); // Renderiza o voxel
}
