import 'dart:convert';

class UserData {
  String? login;
  int? id;
  String? nodeId;
  String? avatarUrl;
  String? gravatarId;
  String? url;
  String? htmlUrl;
  String? followersUrl;
  String? followingUrl;
  String? gistsUrl;
  String? starredUrl;
  String? subscriptionsUrl;
  String? organizationsUrl;
  String? reposUrl;
  String? eventsUrl;
  String? receivedEventsUrl;
  String? type;
  bool? siteAdmin;
  String? name;
  String? blog;
  String? location;
  String? bio;
  int? publicRepos;
  int? publicGists;
  int? followers;
  int? following;
  String? createdAt;
  String? updatedAt;

  UserData({
    this.login,
    this.id,
    this.nodeId,
    this.avatarUrl,
    this.gravatarId,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.starredUrl,
    this.subscriptionsUrl,
    this.organizationsUrl,
    this.reposUrl,
    this.eventsUrl,
    this.receivedEventsUrl,
    this.type,
    this.siteAdmin,
    this.name,
    this.blog,
    this.location,
    this.bio,
    this.publicRepos,
    this.publicGists,
    this.followers,
    this.following,
    this.createdAt,
    this.updatedAt,
  });

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  UserData copyWith({
    String? login,
    int? id,
    String? nodeId,
    String? avatarUrl,
    String? gravatarId,
    String? url,
    String? htmlUrl,
    String? followersUrl,
    String? followingUrl,
    String? gistsUrl,
    String? starredUrl,
    String? subscriptionsUrl,
    String? organizationsUrl,
    String? reposUrl,
    String? eventsUrl,
    String? receivedEventsUrl,
    String? type,
    bool? siteAdmin,
    String? name,
    String? blog,
    String? location,
    String? bio,
    int? publicRepos,
    int? publicGists,
    int? followers,
    int? following,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserData(
      login: login ?? this.login,
      id: id ?? this.id,
      nodeId: nodeId ?? this.nodeId,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      gravatarId: gravatarId ?? this.gravatarId,
      url: url ?? this.url,
      htmlUrl: htmlUrl ?? this.htmlUrl,
      followersUrl: followersUrl ?? this.followersUrl,
      followingUrl: followingUrl ?? this.followingUrl,
      gistsUrl: gistsUrl ?? this.gistsUrl,
      starredUrl: starredUrl ?? this.starredUrl,
      subscriptionsUrl: subscriptionsUrl ?? this.subscriptionsUrl,
      organizationsUrl: organizationsUrl ?? this.organizationsUrl,
      reposUrl: reposUrl ?? this.reposUrl,
      eventsUrl: eventsUrl ?? this.eventsUrl,
      receivedEventsUrl: receivedEventsUrl ?? this.receivedEventsUrl,
      type: type ?? this.type,
      siteAdmin: siteAdmin ?? this.siteAdmin,
      name: name ?? this.name,
      blog: blog ?? this.blog,
      location: location ?? this.location,
      bio: bio ?? this.bio,
      publicRepos: publicRepos ?? this.publicRepos,
      publicGists: publicGists ?? this.publicGists,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'login': login,
      'id': id,
      'nodeId': nodeId,
      'avatar_url': avatarUrl,
      'gravatarId': gravatarId,
      'url': url,
      'htmlUrl': htmlUrl,
      'followersUrl': followersUrl,
      'followingUrl': followingUrl,
      'gistsUrl': gistsUrl,
      'starredUrl': starredUrl,
      'subscriptionsUrl': subscriptionsUrl,
      'organizationsUrl': organizationsUrl,
      'reposUrl': reposUrl,
      'eventsUrl': eventsUrl,
      'receivedEventsUrl': receivedEventsUrl,
      'type': type,
      'siteAdmin': siteAdmin,
      'name': name,
      'blog': blog,
      'location': location,
      'bio': bio,
      'publicRepos': publicRepos,
      'publicGists': publicGists,
      'followers': followers,
      'following': following,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      login: map['login'] != null ? map['login'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
      nodeId: map['nodeId'] != null ? map['nodeId'] as String : null,
      avatarUrl: map['avatar_url'] != null ? map['avatar_url'] as String : null,
      gravatarId:
          map['gravatarId'] != null ? map['gravatarId'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      htmlUrl: map['htmlUrl'] != null ? map['htmlUrl'] as String : null,
      followersUrl:
          map['followersUrl'] != null ? map['followersUrl'] as String : null,
      followingUrl:
          map['followingUrl'] != null ? map['followingUrl'] as String : null,
      gistsUrl: map['gistsUrl'] != null ? map['gistsUrl'] as String : null,
      starredUrl:
          map['starredUrl'] != null ? map['starredUrl'] as String : null,
      subscriptionsUrl: map['subscriptionsUrl'] != null
          ? map['subscriptionsUrl'] as String
          : null,
      organizationsUrl: map['organizationsUrl'] != null
          ? map['organizationsUrl'] as String
          : null,
      reposUrl: map['reposUrl'] != null ? map['reposUrl'] as String : null,
      eventsUrl: map['eventsUrl'] != null ? map['eventsUrl'] as String : null,
      receivedEventsUrl: map['receivedEventsUrl'] != null
          ? map['receivedEventsUrl'] as String
          : null,
      type: map['type'] != null ? map['type'] as String : null,
      siteAdmin: map['siteAdmin'] != null ? map['siteAdmin'] as bool : null,
      name: map['name'] != null ? map['name'] as String : null,
      blog: map['blog'] != null ? map['blog'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      publicRepos:
          map['public_repos'] != null ? map['public_repos'] as int : null,
      publicGists:
          map['publicGists'] != null ? map['publicGists'] as int : null,
      followers: map['followers'] != null ? map['followers'] as int : null,
      following: map['following'] != null ? map['following'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  @override
  String toString() {
    return 'UserData(login: $login, id: $id, nodeId: $nodeId, avatarUrl: $avatarUrl, gravatarId: $gravatarId, url: $url, htmlUrl: $htmlUrl, followersUrl: $followersUrl, followingUrl: $followingUrl, gistsUrl: $gistsUrl, starredUrl: $starredUrl, subscriptionsUrl: $subscriptionsUrl, organizationsUrl: $organizationsUrl, reposUrl: $reposUrl, eventsUrl: $eventsUrl, receivedEventsUrl: $receivedEventsUrl, type: $type, siteAdmin: $siteAdmin, name: $name, blog: $blog, location: $location, bio: $bio, publicRepos: $publicRepos, publicGists: $publicGists, followers: $followers, following: $following, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant UserData other) {
    if (identical(this, other)) return true;

    return other.login == login &&
        other.id == id &&
        other.nodeId == nodeId &&
        other.avatarUrl == avatarUrl &&
        other.gravatarId == gravatarId &&
        other.url == url &&
        other.htmlUrl == htmlUrl &&
        other.followersUrl == followersUrl &&
        other.followingUrl == followingUrl &&
        other.gistsUrl == gistsUrl &&
        other.starredUrl == starredUrl &&
        other.subscriptionsUrl == subscriptionsUrl &&
        other.organizationsUrl == organizationsUrl &&
        other.reposUrl == reposUrl &&
        other.eventsUrl == eventsUrl &&
        other.receivedEventsUrl == receivedEventsUrl &&
        other.type == type &&
        other.siteAdmin == siteAdmin &&
        other.name == name &&
        other.blog == blog &&
        other.location == location &&
        other.bio == bio &&
        other.publicRepos == publicRepos &&
        other.publicGists == publicGists &&
        other.followers == followers &&
        other.following == following &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return login.hashCode ^
        id.hashCode ^
        nodeId.hashCode ^
        avatarUrl.hashCode ^
        gravatarId.hashCode ^
        url.hashCode ^
        htmlUrl.hashCode ^
        followersUrl.hashCode ^
        followingUrl.hashCode ^
        gistsUrl.hashCode ^
        starredUrl.hashCode ^
        subscriptionsUrl.hashCode ^
        organizationsUrl.hashCode ^
        reposUrl.hashCode ^
        eventsUrl.hashCode ^
        receivedEventsUrl.hashCode ^
        type.hashCode ^
        siteAdmin.hashCode ^
        name.hashCode ^
        blog.hashCode ^
        location.hashCode ^
        bio.hashCode ^
        publicRepos.hashCode ^
        publicGists.hashCode ^
        followers.hashCode ^
        following.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
