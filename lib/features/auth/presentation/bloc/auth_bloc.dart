import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passdriver/features/auth/domain/usecases/login_usecase.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _loginUsecase;

  AuthBloc(this._loginUsecase) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      final result = await _loginUsecase.execute(event.email, event.password);
      result.fold(
        (exception) => emit(AuthError(exception.toString())),
        (token) => emit(AuthSuccess(token)),
      );
    });
  }
}
