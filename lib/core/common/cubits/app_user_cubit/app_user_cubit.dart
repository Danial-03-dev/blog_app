import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_local_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final BlogLocalDataSource blogLocalDataSource;
  final sb.SupabaseClient supabaseClient;

  AppUserCubit({
    required this.blogLocalDataSource,
    required this.supabaseClient,
  }) : super(AppUserInitialState());

  void updateUser({User? user}) {
    if (user == null) {
      emit(AppUserInitialState());
      return;
    }

    emit(AppUserLoggedInState(user: user));
  }

  Future<void> logoutUser() async {
    try {
      await blogLocalDataSource.clearLocalBlogs();
      await supabaseClient.auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
    emit(AppUserInitialState());
  }
}
