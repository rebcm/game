import 'package:sqflite/sqflite.dart';

class WorldsTable {
  static const String tableName = 'worlds';

  static const String columnId = 'id';
  static const String columnNome = 'nome';
  static const String columnDescricao = 'descricao';
  static const String columnDataCriacao = 'data_criacao';
  static const String columnDataModificacao = 'data_modificacao';

  static void createTable(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY NOT NULL UNIQUE,
            $columnNome TEXT NOT NULL,
            $columnDescricao TEXT,
            $columnDataCriacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
            $columnDataModificacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
          );
        ''');
    await db.execute('CREATE UNIQUE INDEX idx_nome ON $tableName ($columnNome);');
  }
}
