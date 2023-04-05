import 'package:flutter/material.dart';
import 'package:github_challenge/core/models/user_data.dart';

class UserProfile extends StatelessWidget {
  final UserData user;

  const UserProfile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 64,
          backgroundImage:
              NetworkImage(user.avatarUrl ?? 'https://picsum.photos/500/500'),
        ),
        const SizedBox(height: 16),
        Text(
          user.name ?? '',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          user.login ?? '',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  user.followers.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Followers',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  user.following.toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Following',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  '${user.publicRepos}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Public Repos',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
