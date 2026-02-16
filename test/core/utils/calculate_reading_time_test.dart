import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('calculateReadingTime', () {
    test('returns 0 for empty string', () {
      final result = calculateReadingTime('');
      expect(result, 0);
    });

    test('returns 1 when words less than reading speed', () {
      final content = List.filled(100, 'word').join(' ');
      final result = calculateReadingTime(content);
      expect(result, 1);
    });

    test('returns 1 when words equal reading speed', () {
      final content = List.filled(225, 'word').join(' ');
      final result = calculateReadingTime(content);
      expect(result, 1);
    });

    test('rounds up reading time', () {
      final content = List.filled(226, 'word').join(' ');
      final result = calculateReadingTime(content);
      expect(result, 2);
    });

    test('ignores extra whitespace', () {
      final content = 'word   word\n\nword';
      final result = calculateReadingTime(content);
      expect(result, 1);
    });
  });
}
