import 'package:blog_app/core/utils/format_date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatDateBydMMMYYYY', () {
    test('formats date as d MMM, yyyy', () {
      final date = DateTime(2025, 3, 5);

      final result = formatDateBydMMMYYYY(date);

      expect(result, '5 Mar, 2025');
    });
  });
}
