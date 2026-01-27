import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_local_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final BlogLocalDataSource blogLocalDataSource;

  AppUserCubit({required this.blogLocalDataSource})
    : super(AppUserInitialState());

  void updateUser({User? user}) {
    if (user == null) {
      emit(AppUserInitialState());
      return;
    }

    emit(AppUserLoggedInState(user: user));
  }

  void logoutUser() {
    emit(AppUserInitialState());
    blogLocalDataSource.clearLocalBlogs();
  }
}
