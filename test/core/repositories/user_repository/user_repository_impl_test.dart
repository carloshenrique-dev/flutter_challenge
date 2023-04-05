import 'dart:convert';
import 'dart:developer';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_challenge/core/repositories/user_repository/user_repository.dart';
import 'package:github_challenge/core/repositories/user_repository/user_repository_impl.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:github_challenge/core/models/user_data.dart';
import 'package:github_challenge/core/models/repository_model.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late UserRepository repository;
  late http.Client mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    repository = UserRepositoryImpl();
  });

  group('getUser', () {
    test('returns user data when http call is successful', () async {
      const mockResponse = '''
        {
          "login": "testUser",
          "name": "Test User",
          "avatar_url": "https://avatars.githubusercontent.com/u/12345?v=4",
          "bio": "Test bio"
        }
      ''';
      final expectedUserData = UserData(
        login: 'testUser',
        name: 'Test User',
        avatarUrl: 'https://avatars.githubusercontent.com/u/12345?v=4',
        bio: 'Test bio',
      );

      when(() => mockHttpClient
              .get(Uri.parse('https://api.github.com/users/testUser')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final userData = await repository.getUser('testUser');

      expect(userData, equals(expectedUserData));
      verify(() => mockHttpClient
          .get(Uri.parse('https://api.github.com/users/testUser'))).called(1);
    });

    test('returns empty user data when http call is unsuccessful', () async {
      when(() => mockHttpClient
              .get(Uri.parse('https://api.github.com/users/testUser')))
          .thenAnswer((_) async => http.Response('', 404));

      final userData = await repository.getUser('testUser');

      expect(userData, equals(UserData()));
      verify(() => mockHttpClient
          .get(Uri.parse('https://api.github.com/users/testUser'))).called(1);
    });
  });

  group('getStarredRepositories', () {
    test('returns a list of starred repositories when http call is successful',
        () async {
      const mockResponse = '''
        [
          {
            "id": 12345,
            "name": "testRepo",
            "html_url": "https://github.com/testUser/testRepo",
            "description": "Test repository"
          }
        ]
      ''';
      final expectedRepositories = [
        RepositoryModel(
          name: 'testRepo',
          htmlUrl: 'https://github.com/testUser/testRepo',
          description: 'Test repository',
        ),
      ];

      when(() => mockHttpClient
              .get(Uri.parse('https://api.github.com/users/testUser/starred')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final repositories = await repository.getStarredRepositories('testUser');

      expect(repositories, equals(expectedRepositories));
      verify(() => mockHttpClient
              .get(Uri.parse('https://api.github.com/users/testUser/starred')))
          .called(1);
    });

    test('returns an empty list when http call is unsuccessful', () async {
      when(() => mockHttpClient
              .get(Uri.parse('https://api.github.com/users/testUser/starred')))
          .thenAnswer((_) async => http.Response('', 404));

      final repositories = await repository.getStarredRepositories('testUser');

      expect(repositories, equals([]));
      verify(() => mockHttpClient
              .get(Uri.parse('https://api.github.com/users/testUser/starred')))
          .called(1);
    });
  });
}
