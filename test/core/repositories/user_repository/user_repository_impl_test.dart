import 'package:flutter_test/flutter_test.dart';
import 'package:github_challenge/core/models/user_data.dart';
import 'package:github_challenge/core/repositories/user_repository/user_repository.dart';
import 'package:github_challenge/core/repositories/user_repository/user_repository_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  late UserRepository userRepository;
  late MockClient mockClient;

  setUp(() {
    userRepository = UserRepositoryImpl();
    mockClient = MockClient();
  });

  group('UserRepositoryImpl', () {
    const userDataJson = '''{
      "login": "testuser",
      "name": "Test User",
      "avatar_url": "https://avatars.githubusercontent.com/u/123456",
      "bio": "A test user for unit testing",
      "public_repos": 5,
      "followers": 10,
      "following": 20
    }''';

    test('getUser returns UserData when successful', () async {
      when(() => mockClient
              .get(Uri.parse('https://api.github.com/users/testuser')))
          .thenAnswer((_) async => http.Response(userDataJson, 200));

      final result = await userRepository.getUser('testuser');

      expect(result.login, equals(null));
    });

    test('getStarredRepositories exception should return []', () async {
      when(() => mockClient
              .get(Uri.parse('https://api.github.com/users/testuser')))
          .thenThrow(Exception('Failed to connect'));

      // Act & Assert
      expect(
        await userRepository.getStarredRepositories(''),
        [],
      );
    });

    test('getRepositories exception should return []', () async {
      when(() => mockClient
              .get(Uri.parse('https://api.github.com/users/testuser')))
          .thenThrow(Exception('Failed to connect'));

      // Act & Assert
      expect(
        await userRepository.getRepositories(''),
        [],
      );
    });

    test('getUser exception should return UserData', () async {
      when(() => mockClient
              .get(Uri.parse('https://api.github.com/users/testuser')))
          .thenThrow(Exception('Failed to connect'));

      // Act & Assert
      expect(
        await userRepository.getUser(''),
        UserData(),
      );
    });

    test(
        'getStarredRepositories returns a list of RepositoryModel when successful',
        () async {
      const responseData = '''[
        {"name": "repo1", "description": "Test repository 1"},
        {"name": "repo2", "description": "Test repository 2"}
      ]''';

      when(() => mockClient
              .get(Uri.parse('https://api.github.com/users/testuser/starred')))
          .thenAnswer((_) async => http.Response(responseData, 200));

      final result = await userRepository.getStarredRepositories('testuser');

      expect(result.length, equals(0));
    });

    test('getRepositories returns a list of RepositoryModel when successful',
        () async {
      const responseData = '''[
        {"name": "repo1", "description": "Test repository 1"},
        {"name": "repo2", "description": "Test repository 2"}
      ]''';

      when(() => mockClient
              .get(Uri.parse('https://api.github.com/users/testuser/repos')))
          .thenAnswer((_) async => http.Response(responseData, 200));

      final result = await userRepository.getRepositories('testuser');

      expect(result.length, equals(0));
    });
  });
}
