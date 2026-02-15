import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;
import 'package:bloc_test/bloc_test.dart';

class MockBlogLocalDataSource extends Mock implements BlogLocalDataSource {}

class MockSupabaseClient extends Mock implements sb.SupabaseClient {}

class MockGoTrueClient extends Mock implements sb.GoTrueClient {}

void main() {
  late AppUserCubit cubit;
  late MockBlogLocalDataSource mockBlogLocalDataSource;
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockGoTrueClient;

  group('AppUserCubit', () {
    setUp(() {
      mockBlogLocalDataSource = MockBlogLocalDataSource();
      mockSupabaseClient = MockSupabaseClient();
      mockGoTrueClient = MockGoTrueClient();

      when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);

      cubit = AppUserCubit(
        blogLocalDataSource: mockBlogLocalDataSource,
        supabaseClient: mockSupabaseClient,
      );
    });

    tearDown(() {
      cubit.close();
    });

    group('constructor', () {
      test('should emit AppUserInitialState when initialized', () {
        //Arrage
        //Act
        //Assert
        expect(cubit.state, isA<AppUserInitialState>());
      });
    });

    group('updateUser', () {
      blocTest<AppUserCubit, AppUserState>(
        'should emit AppUserInitialState when updateUser is called with null',
        build: () => cubit,
        act: (cubit) => cubit.updateUser(user: null),
        expect: () => [isA<AppUserInitialState>()],
      );

      blocTest<AppUserCubit, AppUserState>(
        'should emit AppUserLoggedInState when updateUser is called with a valid user',
        build: () => cubit,
        act: (cubit) => cubit.updateUser(
          user: User(id: '1', name: 'Test User', email: 'test@test.com'),
        ),
        expect: () => [isA<AppUserLoggedInState>()],
      );
    });

    group('logoutUser', () {
      blocTest<AppUserCubit, AppUserState>(
        'should clear local blogs, signs out user and emit AppUserInitialState when logoutUser is called',
        build: () {
          when(
            () => mockBlogLocalDataSource.clearLocalBlogs(),
          ).thenAnswer((_) async {});
          when(() => mockGoTrueClient.signOut()).thenAnswer((_) async {});
          return cubit;
        },
        act: (cubit) => cubit.logoutUser(),
        expect: () => [isA<AppUserInitialState>()],
        verify: (_) {
          verify(() => mockBlogLocalDataSource.clearLocalBlogs()).called(1);
          verify(() => mockGoTrueClient.signOut()).called(1);
        },
      );

      blocTest<AppUserCubit, AppUserState>(
        'should still emit AppUserInitialState when logoutUser throws exception',
        build: () {
          when(
            () => mockBlogLocalDataSource.clearLocalBlogs(),
          ).thenThrow(Exception());
          when(() => mockGoTrueClient.signOut()).thenThrow(Exception());
          return cubit;
        },
        act: (cubit) => cubit.logoutUser(),
        expect: () => [isA<AppUserInitialState>()],
      );
    });
  });
}
