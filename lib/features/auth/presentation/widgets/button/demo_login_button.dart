import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/widgets/button/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DemoLoginButton extends StatelessWidget {
  const DemoLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    void handleDemoLogin() async {
      context.read<AuthBloc>().add(
        AuthLoginEvent(email: 'ron@ron.com', password: 'ronron'),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Login using ', style: Theme.of(context).textTheme.bodyLarge),
        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailureState) {
              showSnackbar(context: context, text: state.message);
            }
          },
          builder: (context, state) {
            return CustomTextButton(
              text: 'Demo Account',
              onPressed: state is AuthLoadingState ? null : handleDemoLogin,
            );
          },
        ),
      ],
    );
  }
}
