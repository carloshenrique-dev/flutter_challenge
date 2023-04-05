import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_challenge/core/models/user_data.dart';
import 'package:go_router/go_router.dart';
import 'package:github_challenge/core/services/dependency_injection.dart';
import 'package:github_challenge/core/utils/enums.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../core/services/routing.dart';
import 'cubit/home_cubit.dart';
import 'widgets/logged_user_profile.dart';
import '../../core/ui/widgets/repository_card.dart';
import 'widgets/user_profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<HomeCubit>(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Github Search',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state.starredRepositories.isNotEmpty &&
                    state.userData != UserData()) {
                  return IconButton(
                    onPressed: () => context.pushNamed(
                      AppRoutes.starredRep.name,
                      extra: {
                        'repositories': state.starredRepositories,
                        'user': state.userData,
                      },
                    ),
                    icon: const Icon(Icons.star_border),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state.savedRepositories.isNotEmpty &&
                    state.userData != UserData()) {
                  return IconButton(
                    onPressed: () => context.pushNamed(
                      AppRoutes.savedRep.name,
                      extra: {
                        'repositories': state.savedRepositories,
                        'user': state.userData,
                      },
                    ),
                    icon: const Icon(MdiIcons.database),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return LoggedUserProfile(
                    user: context.read<HomeCubit>().getUser(),
                  );
                },
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () =>
                        context.read<HomeCubit>().logout().whenComplete(
                              () => context
                                  .pushReplacementNamed(AppRoutes.login.name),
                            ),
                  );
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return TextFormField(
                          onFieldSubmitted: (value) =>
                              context.read<HomeCubit>().getData(),
                          onChanged: (value) =>
                              context.read<HomeCubit>().updateQuery(value),
                          decoration: InputDecoration(
                            hintText: 'Enter a username',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () =>
                                  context.read<HomeCubit>().getData(),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        switch (state.status) {
                          case Status.initial:
                            return const Center(
                                child: Text('Enter a username to search.'));
                          case Status.error:
                            return Center(
                              child: Column(
                                children: [
                                  const Text('Error searching user.'),
                                  ElevatedButton(
                                    onPressed: () =>
                                        context.read<HomeCubit>().reset(),
                                    child: const Text('Try again'),
                                  ),
                                ],
                              ),
                            );
                          case Status.loading:
                            return const Center(
                                child: CircularProgressIndicator());
                          case Status.completed:
                            return Column(
                              children: [
                                UserProfile(
                                  user: state.userData,
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.repositories.length,
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      color: Colors.grey[400],
                                      height: 2,
                                    );
                                  },
                                  itemBuilder: (context, index) =>
                                      RepositoryCard(
                                    user: state.userData,
                                    repositoryModel: state.repositories[index],
                                    saveRepositoryPressed: () => context
                                        .read<HomeCubit>()
                                        .saveRepository(
                                          state.repositories[index],
                                        ),
                                  ),
                                ),
                              ],
                            );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
