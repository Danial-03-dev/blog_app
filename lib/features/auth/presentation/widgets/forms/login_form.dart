import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/button/custom_text_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/button/gradient_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/inputs/auth_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void handleSignIn() {}

  void handleSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupPage()),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: 24,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Login.', style: Theme.of(context).textTheme.displayMedium),
          Column(
            spacing: 16,
            children: [
              AuthField(hintText: 'Email', controller: emailController),
              AuthField(
                hintText: 'Password',
                controller: passwordController,
                obscureText: true,
              ),
            ],
          ),
          const GradientButton(text: 'Login'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account? ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              CustomTextButton(onPressed: handleSignUp, text: 'Sign Up'),
            ],
          ),
        ],
      ),
    );
  }
}
