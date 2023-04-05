import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:github_challenge/core/repositories/user_repository/user_repository.dart';
import 'package:github_challenge/core/repositories/user_repository/user_repository_impl.dart';
import 'package:github_challenge/modules/home/cubit/home_cubit.dart';
import 'package:github_challenge/modules/login/cubit/login_cubit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();

    GetIt.I.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
    GetIt.I.registerFactory<HomeCubit>(
        () => HomeCubit(userRepository: GetIt.I.get<UserRepository>()));
    GetIt.I.registerFactory<GoogleSignIn>(() => GoogleSignIn(scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ]));
    GetIt.I.registerFactory<LoginCubit>(() => LoginCubit());
  });
  group('Dependency Injection', () {
    //SQFLITE TESTS NOT IMPLEMENTED BECAUSE THE PACKAGE DONT SUPORT TESTS
    //FOLLOW THE LINK: https://github.com/tekartik/sqflite/blob/master/sqflite/doc/testing.md

    setUp(() {
      GetIt.instance.reset();
    });

    test('Registers UserRepository as singleton', () {
      final repository1 = GetIt.I.get<UserRepository>();
      final repository2 = GetIt.I.get<UserRepository>();
      expect(repository1, equals(repository2));
    });

    test('Registers HomeCubit as factory', () {
      final cubit1 = GetIt.I.get<HomeCubit>();
      final cubit2 = GetIt.I.get<HomeCubit>();
      expect(cubit1, isNot(equals(cubit2)));
    });

    test('Registers GoogleSignIn as factory', () {
      final signIn1 = GetIt.I.get<GoogleSignIn>();
      final signIn2 = GetIt.I.get<GoogleSignIn>();
      expect(signIn1, isNot(equals(signIn2)));
    });

    test('Registers LoginCubit as factory', () {
      final cubit1 = GetIt.I.get<LoginCubit>();
      final cubit2 = GetIt.I.get<LoginCubit>();
      expect(cubit1, isNot(equals(cubit2)));
    });
  });
}
