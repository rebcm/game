import 'package:freezed/freezed.dart';

part 'player_state_machine.freezed.dart';

@freezed
class PlayerStateMachine with _$PlayerStateMachine {
  const factory PlayerStateMachine.idle() = _Idle;
  const factory PlayerStateMachine.walking() = _Walking;
  const factory PlayerStateMachine.stopping() = _Stopping;

  factory PlayerStateMachine.fromJson(Map<String, dynamic> json) => _$PlayerStateMachineFromJson(json);
}
