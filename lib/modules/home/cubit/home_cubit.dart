import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_challenge/core/models/user_data.dart';
import 'package:github_challenge/core/repositories/database_repository/database_repository.dart';
import 'package:github_challenge/core/repositories/user_repository/user_repository.dart';
import 'package:github_challenge/core/services/database_service.dart';
import 'package:github_challenge/core/utils/enums.dart';

import '../../../core/models/repository_model.dart';
import '../../../core/services/dependency_injection.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final UserRepository _userRepository;

  HomeCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(HomeState.initial());

  void updateQuery(String value) {
    emit(state.copyWith(query: value));
  }

  Future<void> getData() async {
    try {
      emit(state.copyWith(status: Status.loading, errorMessage: ''));
      final result = await Future.wait([
        getUserData(),
        getRepositories(),
        getStarredRepositories(),
        getSavedRepositories()
      ]);
      if (!result.contains(false)) {
        compareLists();
        emit(state.copyWith(
          status: Status.completed,
        ));
      } else {
        emit(state.copyWith(
          status: Status.error,
          errorMessage: 'Error to get user data',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<bool> getUserData() async {
    try {
      final userData = await _userRepository.getUser(state.query);
      if (userData != UserData()) {
        emit(state.copyWith(
          userData: userData,
        ));
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getStarredRepositories() async {
    try {
      final starredRepositories =
          await _userRepository.getStarredRepositories(state.query);

      emit(state.copyWith(starredRepositories: starredRepositories));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getRepositories() async {
    try {
      final repositories = await _userRepository.getRepositories(state.query);

      emit(state.copyWith(repositories: repositories));
      return true;
    } catch (e) {
      return false;
    }
  }

  void reset() {
    emit(
      state.copyWith(
        status: Status.initial,
        errorMessage: '',
      ),
    );
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  UserData getUser() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return UserData(
          name: user.displayName!,
          avatarUrl: user.photoURL!,
          login: user.email,
        );
      }
      return UserData();
    } catch (e) {
      log(e.toString());
      return UserData();
    }
  }

  Future<void> saveRepository(RepositoryModel repositoryModel) async {
    try {
      emit(state.copyWith(saveRepositoryStatus: Status.loading));
      if (locator.isReadySync<DatabaseService>()) {
        //update photo
        final repository = repositoryModel.copyWith(
          htmlUrl: state.userData.avatarUrl,
        );

        await locator<DatabaseRepository>().insertData(repository);
        await getSavedRepositories();
        compareLists();
        emit(state.copyWith(saveRepositoryStatus: Status.completed));
      }
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(
        errorMessage: e.toString(),
        saveRepositoryStatus: Status.error,
      ));
    }
  }

  Future<bool> getSavedRepositories() async {
    try {
      final repositories = await locator<DatabaseRepository>().getData();
      emit(state.copyWith(
        savedRepositories: repositories,
      ));
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  void compareLists() {
    for (int i = 0; i < state.repositories.length; i++) {
      int index = state.savedRepositories
          .indexWhere((item) => item.name == state.repositories[i].name);
      if (index != -1) {
        state.repositories[i] = state.repositories[i].copyWith(isSaved: 1);
      }
    }
    emit(state.copyWith(repositories: state.repositories));
  }
}
