import 'dart:typed_data';

import 'package:blog_app/core/utils/detect_image_mime_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('detectImageMimeType', () {
    test('returns image/png when PNG signature is present', () {
      final data = Uint8List.fromList([0x89, 0x50, 0x4E, 0x47, 0x00]);

      final result = detectImageMimeType(data);

      expect(result, 'image/png');
    });

    test('returns image/jpeg for non-PNG data', () {
      final data = Uint8List.fromList([0xFF, 0xD8, 0xFF, 0xE0]);

      final result = detectImageMimeType(data);

      expect(result, 'image/jpeg');
    });

    test('returns image/jpeg when data length is less than 4', () {
      final data = Uint8List.fromList([0x89, 0x50]);

      final result = detectImageMimeType(data);

      expect(result, 'image/jpeg');
    });
  });
}
