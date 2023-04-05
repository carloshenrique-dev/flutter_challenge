import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_challenge/core/models/repository_model.dart';
import 'package:github_challenge/core/repositories/database_repository/database_repository.dart';

import '../../../core/utils/enums.dart';

part 'saved_repositories_state.dart';

class SavedRepositoriesCubit extends Cubit<SavedRepositoriesState> {
  final DatabaseRepository _databaseRepository;

  SavedRepositoriesCubit({
    required DatabaseRepository databaseRepository,
  })  : _databaseRepository = databaseRepository,
        super(const SavedRepositoriesState.initial());

  Future<void> getSavedRepositories() async {
    try {
      emit(state.copyWith(errorMessage: '', status: Status.loading));
      final repositories = await _databaseRepository.getData();
      if (repositories.isNotEmpty) {
        emit(state.copyWith(
          repositories: repositories,
          status: Status.completed,
        ));
      } else {
        emit(state.copyWith(
          repositories: [],
          status: Status.completed,
        ));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), status: Status.error));
      log(e.toString());
    }
  }
}
