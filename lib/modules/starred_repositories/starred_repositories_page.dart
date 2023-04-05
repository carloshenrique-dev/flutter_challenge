import 'package:flutter/material.dart';
import 'package:github_challenge/core/models/repository_model.dart';
import 'package:github_challenge/core/models/user_data.dart';
import 'package:github_challenge/core/ui/widgets/repository_card.dart';

class StarredRepositoriesPage extends StatelessWidget {
  final List<RepositoryModel> starredRepositories;
  final UserData user;

  const StarredRepositoriesPage({
    super.key,
    required this.starredRepositories,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Starred repositories',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: starredRepositories.length,
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey[400],
                height: 2,
              );
            },
            itemBuilder: (context, index) => RepositoryCard(
              user: user,
              repositoryModel: starredRepositories[index],
            ),
          ),
        ),
      ),
    );
  }
}
