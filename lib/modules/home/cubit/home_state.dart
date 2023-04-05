part of 'home_cubit.dart';

class HomeState extends Equatable {
  final Status status;
  final Status saveRepositoryStatus;
  final String errorMessage;
  final String query;
  final UserData userData;
  final List<RepositoryModel> repositories;
  final List<RepositoryModel> starredRepositories;
  final List<RepositoryModel> savedRepositories;

  const HomeState._({
    required this.errorMessage,
    required this.userData,
    required this.status,
    required this.saveRepositoryStatus,
    required this.query,
    required this.repositories,
    required this.starredRepositories,
    required this.savedRepositories,
  });

  HomeState.initial()
      : this._(
          status: Status.initial,
          saveRepositoryStatus: Status.initial,
          errorMessage: '',
          userData: UserData(),
          repositories: [],
          starredRepositories: [],
          savedRepositories: [],
          query: '',
        );

  @override
  List<Object?> get props => [
        status,
        saveRepositoryStatus,
        errorMessage,
        userData,
        repositories,
        starredRepositories,
        savedRepositories,
        query,
      ];

  HomeState copyWith({
    Status? status,
    Status? saveRepositoryStatus,
    String? errorMessage,
    String? query,
    UserData? userData,
    List<RepositoryModel>? repositories,
    List<RepositoryModel>? starredRepositories,
    List<RepositoryModel>? savedRepositories,
  }) {
    return HomeState._(
      status: status ?? this.status,
      saveRepositoryStatus: saveRepositoryStatus ?? this.saveRepositoryStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      query: query ?? this.query,
      userData: userData ?? this.userData,
      repositories: repositories ?? this.repositories,
      starredRepositories: starredRepositories ?? this.starredRepositories,
      savedRepositories: savedRepositories ?? this.savedRepositories,
    );
  }
}
