import 'package:bloc_test/bloc_test.dart';
import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/buttons/logout_button.dart';
import 'package:blog_app/core/constants/app_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppUserCubit extends MockCubit<AppUserState>
    implements AppUserCubit {}

void main() {
  late MockAppUserCubit mockAppUserCubit;

  setUp(() {
    mockAppUserCubit = MockAppUserCubit();
    when(() => mockAppUserCubit.logoutUser()).thenAnswer((_) async {});
  });

  group('LogoutButton', () {
    testWidgets('should call logoutUser when button is tapped', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AppUserCubit>.value(
            value: mockAppUserCubit,
            child: const LogoutButton(),
          ),
        ),
      );

      await tester.tap(find.byKey(AppKeys.logoutButton));
      await tester.pumpAndSettle();

      verify(() => mockAppUserCubit.logoutUser()).called(1);
    });
  });
}
