import 'package:equatable/equatable.dart';
import 'package:provider/provider.dart';
import 'state_model.dart';

class StateService with ChangeNotifier {
  final List<StateModel> _states = [];

  List<StateModel> get states => _states;

  void addState(StateModel state) {
    _states.add(state);
    notifyListeners();
  }

  void removeState(String id) {
    _states.removeWhere((state) => state.id == id);
    notifyListeners();
  }

  void updateState(StateModel state) {
    final index = _states.indexWhere((s) => s.id == state.id);
    if (index != -1) {
      _states[index] = state;
      notifyListeners();
    }
  }
}
