part of 'saved_repositories_cubit.dart';

class SavedRepositoriesState extends Equatable {
  final Status status;
  final String errorMessage;
  final List<RepositoryModel> repositories;

  const SavedRepositoriesState._({
    required this.errorMessage,
    required this.status,
    required this.repositories,
  });

  const SavedRepositoriesState.initial()
      : this._(
          status: Status.initial,
          errorMessage: '',
          repositories: const [],
        );

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        repositories,
      ];

  SavedRepositoriesState copyWith({
    Status? status,
    String? errorMessage,
    List<RepositoryModel>? repositories,
  }) {
    return SavedRepositoriesState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      repositories: repositories ?? this.repositories,
    );
  }
}
