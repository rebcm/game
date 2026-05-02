import 'package:construcao_criativa/features/persistence/persistence_manager.dart';

class PurgeManager {
  final PersistenceManager _persistenceManager;

  PurgeManager(this._persistenceManager);

  Future<void> purgeObsoleteArtifacts() async {
    await _persistenceManager.purgeObsoleteArtifacts();
  }
}
