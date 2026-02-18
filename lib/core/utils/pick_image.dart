import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

Future<Uint8List?> pickImage() async {
  return pickImageHelper(ImagePicker());
}

Future<Uint8List?> pickImageHelper(ImagePicker picker) async {
  try {
    final xfile = await picker.pickImage(source: ImageSource.gallery);

    if (xfile == null) return null;

    return await xfile.readAsBytes();
  } catch (_) {
    return null;
  }
}
