import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/utils/enums.dart';
import '../../../firebase_options.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState.initial());

  Future<UserCredential?> signInWithGoogle() async {
    try {
      emit(state.copyWith(status: Status.loading));
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
              clientId: DefaultFirebaseOptions.currentPlatform.iosClientId)
          .signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        // Once signed in, return the UserCredential
        emit(state.copyWith(status: Status.completed));

        return await FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        emit(state.copyWith(
          status: Status.error,
          errorMessage: 'Error to sign in, try again',
        ));
        return null;
      }
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: Status.error, errorMessage: e.toString()));
      return null;
    }
  }

  void reset() {
    emit(state.copyWith(errorMessage: '', status: Status.initial));
  }
}
