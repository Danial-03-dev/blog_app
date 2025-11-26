import 'dart:typed_data';

String detectImageMimeType(Uint8List data) {
  if (data.length > 4 &&
      data[0] == 0x89 &&
      data[1] == 0x50 &&
      data[2] == 0x4E &&
      data[3] == 0x47) {
    return 'image/png';
  }
  return 'image/jpeg';
}
