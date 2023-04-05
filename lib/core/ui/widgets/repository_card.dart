import 'package:flutter/material.dart';
import 'package:github_challenge/core/models/repository_model.dart';
import 'package:github_challenge/core/models/user_data.dart';

class RepositoryCard extends StatelessWidget {
  final RepositoryModel repositoryModel;
  final UserData user;
  final VoidCallback? saveRepositoryPressed;
  final bool isFromSavedRepositories;

  const RepositoryCard({
    super.key,
    required this.repositoryModel,
    required this.user,
    this.saveRepositoryPressed,
    this.isFromSavedRepositories = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            isFromSavedRepositories ? repositoryModel.htmlUrl : user.avatarUrl!,
            height: 56.0,
            width: 56.0,
            fit: BoxFit.cover,
          ),
        ),
        title: repositoryModel.name != ''
            ? Text(
                repositoryModel.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              )
            : null,
        minVerticalPadding: 0,
        contentPadding: repositoryModel.description != ''
            ? const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 10,
              )
            : const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (repositoryModel.description != '')
              _mediumText(
                context,
                repositoryModel.description,
              ),
            const SizedBox(
              height: 2,
            ),
            Row(
              children: [
                Icon(
                  Icons.star_border,
                  size: 16.0,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 4.0),
                _mediumText(
                  context,
                  repositoryModel.stargazersCount,
                ),
                const SizedBox(width: 8.0),
                Icon(
                  Icons.language,
                  size: 16.0,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 4.0),
                _mediumText(
                  context,
                  repositoryModel.language.isEmpty
                      ? 'Unknown'
                      : repositoryModel.language,
                ),
              ],
            ),
          ],
        ),
        trailing: saveRepositoryPressed != null
            ? IconButton(
                onPressed: saveRepositoryPressed,
                icon: Icon(
                  repositoryModel.isSaved! == 0
                      ? Icons.favorite_border
                      : Icons.favorite,
                  color: repositoryModel.isSaved! == 0 ? null : Colors.red,
                ),
              )
            : null,
      ),
    );
  }

  Widget _mediumText(BuildContext context, String text) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
    );
  }
}
