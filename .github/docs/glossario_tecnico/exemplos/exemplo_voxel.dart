/// Exemplo de utilização de voxel
class Voxel {
  int x, y, z; // Posição do voxel
  int tipo;    // Tipo de bloco representado pelo voxel

  Voxel(this.x, this.y, this.z, this.tipo);

  /// Renderiza o voxel na posição especificada
  void renderizar() {
    // Implementação da lógica de renderização
  }
}

void main() {
  Voxel meuVoxel = Voxel(0, 0, 0, 1); // Cria um voxel na origem do tipo 1
  meuVoxel.renderizar();               // Renderiza o voxel
}

