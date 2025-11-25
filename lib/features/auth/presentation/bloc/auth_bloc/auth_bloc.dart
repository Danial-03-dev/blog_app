import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
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
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  }) : _userSignUp = userSignUp,
       _userLogin = userLogin,
       _currentUser = currentUser,
       _appUserCubit = appUserCubit,
       super(AuthInitialState()) {
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthIsUserLoggedInEvent>(_isUserLoggedIn);
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

  void _isUserLoggedIn(
    AuthIsUserLoggedInEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _onAuth(event, emit, () => _currentUser(NoParams()));
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
      _emitAuthSuccess(user: user, emit: emit);
    }

    response.fold(onFailure, onSuccess);
  }

  void _emitAuthSuccess({
    required User user,
    required Emitter<AuthState> emit,
  }) {
    _appUserCubit.updateUser(user: user);
    emit(AuthSuccessState(user: user));
  }
}
