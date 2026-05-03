import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_state.freezed.dart';

@freezed
class PlayerState with _$PlayerState {
  const factory PlayerState.idle() = _Idle;
  const factory PlayerState.walking({required PlayerMovementTrigger direction}) = _Walking;
}
