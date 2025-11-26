import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class BlogCategoryChip extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isActive;

  const BlogCategoryChip({
    super.key,
    required this.label,
    this.onPressed,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final chipColor = isActive
        ? AppPallete.gradient1
        : AppPallete.backgroundColor;

    final chipBorderColor = isActive
        ? AppPallete.transparentColor
        : AppPallete.borderColor;

    if (onPressed == null) {
      return Chip(
        label: Text(label),
        side: BorderSide(color: chipBorderColor),
        color: WidgetStatePropertyAll(chipColor),
      );
    }

    return ActionChip(
      label: Text(label),
      side: BorderSide(color: chipBorderColor),
      color: WidgetStatePropertyAll(chipColor),
      onPressed: onPressed,
    );
  }
}
