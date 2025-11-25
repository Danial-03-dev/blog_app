import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;

  AuthBloc({required UserSignUp userSignUp, required UserLogin userLogin})
    : _userSignUp = userSignUp,
      _userLogin = userLogin,
      super(AuthInitialState()) {
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLoginEvent>(_onAuthLogin);
  }

  Future<void> _onAuth(
    AuthEvent event,
    Emitter<AuthState> emit,
    Future<Either<Failure, User>> Function() fn,
  ) async {
    emit(AuthLoadingState());

    final response = await fn();

    onFailure(Failure failure) {
      emit(AuthFailureState(message: failure.message));
    }

    onSuccess(User user) {
      emit(AuthSuccessState(user: user));
    }

    response.fold(onFailure, onSuccess);
  }

  void _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    await _onAuth(
      event,
      emit,
      () => _userSignUp(
        UserSignUpParams(
          name: event.name,
          email: event.email,
          password: event.password,
        ),
      ),
    );
  }

  void _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    await _onAuth(
      event,
      emit,
      () => _userLogin(
        UserLoginParams(email: event.email, password: event.password),
      ),
    );
  }
}
