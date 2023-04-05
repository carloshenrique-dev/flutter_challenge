class RepositoryModel {
  String name;
  String description;
  String language;
  String htmlUrl;
  String stargazersCount;
  int? isSaved;

  RepositoryModel({
    this.name = '',
    this.description = '',
    this.language = '',
    this.htmlUrl = '',
    this.stargazersCount = '',
    this.isSaved = 0,
  });

  RepositoryModel copyWith({
    String? name,
    String? description,
    String? language,
    String? htmlUrl,
    String? stargazersCount,
    int? isSaved,
  }) {
    return RepositoryModel(
      name: name ?? this.name,
      description: description ?? this.description,
      language: language ?? this.language,
      htmlUrl: htmlUrl ?? this.htmlUrl,
      stargazersCount: stargazersCount ?? this.stargazersCount,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      language: json['language'] ?? '',
      htmlUrl: json['htmlUrl'] ?? '',
      isSaved: json['isSaved'] ?? 0,
      stargazersCount: json['stargazers_count'].toString(),
    );
  }

  @override
  String toString() {
    return 'RepositoryModel(name: $name, description: $description, language: $language, htmlUrl: $htmlUrl, stargazersCount: $stargazersCount, isSaved: $isSaved)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepositoryModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          language == other.language &&
          htmlUrl == other.htmlUrl &&
          stargazersCount == other.stargazersCount &&
          isSaved == other.isSaved;

  @override
  int get hashCode =>
      name.hashCode ^
      description.hashCode ^
      language.hashCode ^
      htmlUrl.hashCode ^
      stargazersCount.hashCode ^
      isSaved.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'language': language,
      'htmlUrl': htmlUrl,
      'stargazers_count': stargazersCount,
    };
  }
}
