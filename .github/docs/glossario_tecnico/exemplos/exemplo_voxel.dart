/// Exemplo de utilização do conceito de voxel no código.
///
/// Este exemplo demonstra como um voxel pode ser representado e manipulado.
class Voxel {
  int x, y, z; // Coordenadas do voxel no espaço tridimensional.

  /// Construtor para inicializar as coordenadas do voxel.
  Voxel(this.x, this.y, this.z);

  /// Método para renderizar o voxel.
  void render() {
    // Implementação da lógica de renderização.
  }
}

void main() {
  // Criação de um voxel na posição (1, 2, 3).
  Voxel meuVoxel = Voxel(1, 2, 3);
  meuVoxel.render(); // Renderiza o voxel.
}

