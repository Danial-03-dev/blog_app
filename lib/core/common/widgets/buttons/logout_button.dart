import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> handleLogout() async {
      await context.read<AppUserCubit>().logoutUser();
    }

    return IconButton(onPressed: handleLogout, icon: Icon(Icons.logout));
  }
}
