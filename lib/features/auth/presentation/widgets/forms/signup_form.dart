import 'package:blog_app/features/auth/presentation/widgets/button/custom_text_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/button/gradient_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/inputs/auth_field.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void handleSignUp() {}

  void handleLogin() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    nameController.dispose();
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
          const Text(
            'Sign Up.',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          Column(
            spacing: 16,
            children: [
              AuthField(hintText: 'Name', controller: nameController),
              AuthField(hintText: 'Email', controller: emailController),
              AuthField(
                hintText: 'Password',
                controller: passwordController,
                obscureText: true,
              ),
            ],
          ),
          const GradientButton(text: 'Sign Up'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account? ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              CustomTextButton(text: 'Login', onPressed: handleLogin),
            ],
          ),
        ],
      ),
    );
  }
}
