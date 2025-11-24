import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const CustomTextButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        minimumSize: WidgetStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppPallete.gradient2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
