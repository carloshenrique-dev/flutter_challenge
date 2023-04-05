import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:go_router/go_router.dart';
import 'package:github_challenge/core/services/routing.dart';
import 'package:rive/rive.dart';

import '../../core/services/dependency_injection.dart';
import '../../core/utils/enums.dart';
import 'cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<LoginCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Github Challenge',
                style: TextStyle(
                  fontFamily: 'Hubot',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 200,
                width: 200,
                child: RiveAnimation.asset(
                  'assets/animations/animation.riv',
                  alignment: Alignment.center,
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case Status.loading:
                        return const CircularProgressIndicator.adaptive();
                      case Status.initial:
                        return SignInButton(
                          Buttons.GoogleDark,
                          onPressed: () => context
                              .read<LoginCubit>()
                              .signInWithGoogle()
                              .whenComplete(
                                () => context
                                    .pushReplacementNamed(AppRoutes.home.name),
                              ),
                        );
                      case Status.completed:
                        return const Text('Redirecting...');

                      case Status.error:
                        return Text(state.errorMessage);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
