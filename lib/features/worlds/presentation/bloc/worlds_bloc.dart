import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../domain/usecases/create_world.dart';

class WorldsBloc extends Bloc<WorldsEvent, WorldsState> {
  final CreateWorld _createWorld;

  WorldsBloc(this._createWorld) : super(WorldsInitial()) {
    on<CreateWorldEvent>(_onCreateWorld);
  }

  Future<void> _onCreateWorld(CreateWorldEvent event, Emitter<WorldsState> emit) async {
    emit(WorldsLoading());
    final result = await _createWorld(event.name);
    result.fold(
      (error) => emit(WorldsError(error)),
      (world) => emit(WorldsLoaded([world])),
    );
  }
}
