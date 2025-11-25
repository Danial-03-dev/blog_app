import 'dart:typed_data';

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class SelectImgBox extends StatelessWidget {
  final VoidCallback? onTap;
  final Uint8List? image;

  const SelectImgBox({super.key, this.onTap, this.image});

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 12;

    return Semantics(
      button: true,
      label: 'Select your image',
      child: InkWell(
        onTap: onTap,
        child: DottedBorder(
          options: RoundedRectDottedBorderOptions(
            color: AppPallete.borderColor,
            dashPattern: [12, 4],
            radius: Radius.circular(borderRadius),
            strokeCap: StrokeCap.round,
          ),
          child: SizedBox(
            height: 156,
            width: double.infinity,
            child: image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Image.memory(image!, fit: BoxFit.cover),
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      Icon(Icons.folder_open, size: 40),
                      Text('Select your image', style: TextStyle(fontSize: 16)),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
