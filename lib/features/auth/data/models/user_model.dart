import 'package:freezed/freezed.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _ {
  const factory UserModel({
    required String id,
    required String email,
    required String token,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _(json);
}
