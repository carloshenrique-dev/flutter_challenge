import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:github_challenge/core/models/user_data.dart';

import 'user_repository.dart';
import '../../models/repository_model.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserData> getUser(String user) async {
    try {
      final url = Uri.parse('https://api.github.com/users/$user');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return UserData.fromJson(response.body);
      }
      return UserData();
    } catch (e) {
      log(e.toString());
      return UserData();
    }
  }

  @override
  Future<List<RepositoryModel>> getStarredRepositories(String user) async {
    try {
      final url = Uri.parse('https://api.github.com/users/$user/starred');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List responseData = json.decode(response.body);
        if (responseData.isNotEmpty) {
          return responseData
              .map((repoData) => RepositoryModel.fromJson(repoData))
              .toList();
        }
      }
      return [];
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  @override
  Future<List<RepositoryModel>> getRepositories(String user) async {
    try {
      final url = Uri.parse('https://api.github.com/users/$user/repos');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List responseData = json.decode(response.body);
        if (responseData.isNotEmpty) {
          return responseData
              .map((repoData) => RepositoryModel.fromJson(repoData))
              .toList();
        }
      }
      return [];
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
