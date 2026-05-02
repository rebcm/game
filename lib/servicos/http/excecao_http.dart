class ExcecaoHttp implements Exception {
  final int codigo;
  final String mensagem;

  ExcecaoHttp(this.codigo, this.mensagem);

  factory ExcecaoHttp.fromJson(Map<String, dynamic> json) {
    return ExcecaoHttp(json['codigo'], json['mensagem']);
  }
}
