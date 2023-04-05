import 'package:github_challenge/core/models/repository_model.dart';

abstract class DatabaseRepository {
  Future<void> insertData(RepositoryModel repositoryModel);
  Future<List<RepositoryModel>> getData();
}
