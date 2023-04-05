import 'dart:developer';

import 'package:github_challenge/core/models/repository_model.dart';
import 'package:github_challenge/core/services/database_service.dart';

import 'database_repository.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  final DatabaseService _databaseService;

  DatabaseRepositoryImpl({
    required DatabaseService databaseService,
  }) : _databaseService = databaseService;

  @override
  Future<List<RepositoryModel>> getData() async {
    try {
      final repositories =
          await _databaseService.query('favorite_repositories');
      if (repositories.isNotEmpty) {
        return repositories
            .map((repoData) => RepositoryModel.fromJson(repoData))
            .toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> insertData(RepositoryModel repositoryModel) async {
    try {
      await _databaseService.insert(
        'favorite_repositories',
        repositoryModel,
      );
    } catch (e) {
      log(e.toString());
      throw Exception();
    }
  }
}
