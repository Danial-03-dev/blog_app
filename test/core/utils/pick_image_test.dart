import 'package:blog_app/core/utils/pick_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockImagePicker extends Mock implements ImagePicker {}

class MockXFile extends Mock implements XFile {}

void main() {
  group('pickImageHelper', () {
    late MockImagePicker mockImagePicker;
    late MockXFile mockXFile;

    setUp(() {
      mockImagePicker = MockImagePicker();
      mockXFile = MockXFile();
    });

    test('returns null when no image is picked', () async {
      when(
        () => mockImagePicker.pickImage(source: ImageSource.gallery),
      ).thenAnswer((_) async => null);

      final result = await pickImageHelper(mockImagePicker);

      expect(result, null);
    });

    test('returns bytes when image is picked successfully', () async {
      final expectedBytes = Uint8List.fromList([1, 2, 3, 4]);

      // Mock picking image
      when(
        () => mockImagePicker.pickImage(source: ImageSource.gallery),
      ).thenAnswer((_) async => mockXFile);

      // Mock reading bytes
      when(
        () => mockXFile.readAsBytes(),
      ).thenAnswer((_) async => expectedBytes);

      final result = await pickImageHelper(mockImagePicker);

      expect(result, expectedBytes);

      verify(
        () => mockImagePicker.pickImage(source: ImageSource.gallery),
      ).called(1);
      verify(() => mockXFile.readAsBytes()).called(1);
    });

    test('returns null when picker throws exception', () async {
      when(
        () => mockImagePicker.pickImage(source: ImageSource.gallery),
      ).thenThrow(Exception());

      final result = await pickImageHelper(mockImagePicker);

      expect(result, null);
    });

    test('returns null when readAsBytes throws exception', () async {
      // Mock picking image
      when(
        () => mockImagePicker.pickImage(source: ImageSource.gallery),
      ).thenAnswer((_) async => mockXFile);

      // Mock reading bytes
      when(() => mockXFile.readAsBytes()).thenThrow(Exception());

      final result = await pickImageHelper(mockImagePicker);

      expect(result, null);
    });
  });
}
