import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_challenge/core/models/user_data.dart';

import '../../core/services/dependency_injection.dart';
import '../../core/ui/widgets/repository_card.dart';
import 'cubit/saved_repositories_cubit.dart';

class SavedRepositoriesPage extends StatelessWidget {
  final UserData user;
  const SavedRepositoriesPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = locator<SavedRepositoriesCubit>();
        cubit.getSavedRepositories();
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            BlocBuilder<SavedRepositoriesCubit, SavedRepositoriesState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () => context
                      .read<SavedRepositoriesCubit>()
                      .getSavedRepositories(),
                  icon: const Icon(Icons.refresh),
                );
              },
            )
          ],
          title: Text(
            'Saved repositories',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<SavedRepositoriesCubit, SavedRepositoriesState>(
              builder: (context, state) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.repositories.length,
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey[400],
                      height: 2,
                    );
                  },
                  itemBuilder: (context, index) => RepositoryCard(
                    isFromSavedRepositories: true,
                    user: user,
                    repositoryModel: state.repositories[index],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
