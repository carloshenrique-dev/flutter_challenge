import 'package:github_challenge/core/models/repository_model.dart';
import 'package:github_challenge/core/models/user_data.dart';

abstract class UserRepository {
  Future<UserData> getUser(String user);
  Future<List<RepositoryModel>> getStarredRepositories(String user);
  Future<List<RepositoryModel>> getRepositories(String user);
}
