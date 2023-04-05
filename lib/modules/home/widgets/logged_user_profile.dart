import 'package:flutter/material.dart';
import 'package:github_challenge/core/models/user_data.dart';

class LoggedUserProfile extends StatelessWidget {
  final UserData? user;

  const LoggedUserProfile({
    super.key,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return UserAccountsDrawerHeader(
        accountName: Text(user!.name!),
        accountEmail: Text(user!.login!),
        currentAccountPicture: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            user!.avatarUrl!,
            loadingBuilder: (context, widget, loadingProgress) {
              if (loadingProgress == null) return widget;
              return const CircularProgressIndicator.adaptive();
            },
          ),
        ),
      );
    } else {
      return UserAccountsDrawerHeader(
        accountName: const Text('Github search'),
        accountEmail: const Text('Github search user'),
        currentAccountPicture: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            'https://picsum.photos/500/500',
            loadingBuilder: (context, widget, loadingProgress) {
              if (loadingProgress == null) return widget;
              return const CircularProgressIndicator.adaptive();
            },
          ),
        ),
      );
    }
  }
}
