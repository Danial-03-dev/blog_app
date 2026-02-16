import 'package:blog_app/core/network/connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetConnection extends Mock implements InternetConnection {}

void main() {
  late MockInternetConnection mockInternetConnection;
  late ConnectionCheckerImpl connectionChecker;

  setUp(() {
    mockInternetConnection = MockInternetConnection();
    connectionChecker = ConnectionCheckerImpl(
      internetConnection: mockInternetConnection,
    );
  });

  group('ConnectionCheckerImpl', () {
    group('isConnected', () {
      test('should return true when internet is available', () async {
        // Arrange
        when(
          () => mockInternetConnection.hasInternetAccess,
        ).thenAnswer((_) async => true);

        // Act
        final result = await connectionChecker.isConnected;

        // Assert
        verify(() => mockInternetConnection.hasInternetAccess).called(1);
        expect(result, true);
      });

      test('should return false when internet is not available', () async {
        // Arrange
        when(
          () => mockInternetConnection.hasInternetAccess,
        ).thenAnswer((_) async => false);

        // Act
        final result = await connectionChecker.isConnected;

        // Assert
        verify(() => mockInternetConnection.hasInternetAccess).called(1);
        expect(result, false);
      });
    });
  });
}
