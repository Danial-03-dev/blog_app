import 'package:bloc_test/bloc_test.dart';
import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/blog/presentation/blocs/blog_bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppUserCubit extends MockCubit<AppUserState>
    implements AppUserCubit {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockBlogBloc extends MockBloc<BlogEvent, BlogState> implements BlogBloc {}

void main() {
  group('MyApp', () {
    late MockAppUserCubit mockAppUserCubit;
    late MockAuthBloc mockAuthBloc;
    late MockBlogBloc mockBlogBloc;

    setUp(() {
      mockAppUserCubit = MockAppUserCubit();
      mockAuthBloc = MockAuthBloc();
      mockBlogBloc = MockBlogBloc();

      when(() => mockAuthBloc.state).thenReturn(AuthInitialState());
      when(() => mockBlogBloc.state).thenReturn(BlogInitialState());
      when(() => mockAppUserCubit.state).thenReturn(AppUserInitialState());
    });

    testWidgets('shows LoginPage when logged out', (tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AppUserCubit>.value(value: mockAppUserCubit),
            BlocProvider<AuthBloc>.value(value: mockAuthBloc),
            BlocProvider<BlogBloc>.value(value: mockBlogBloc),
          ],
          child: const MyApp(),
        ),
      );

      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('shows BlogPage when user is logged in', (tester) async {
      final User fakeUser = User(id: '1', name: 'test', email: 'test@test.com');

      when(
        () => mockAppUserCubit.state,
      ).thenReturn(AppUserLoggedInState(user: fakeUser));

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AppUserCubit>.value(value: mockAppUserCubit),
            BlocProvider<AuthBloc>.value(value: mockAuthBloc),
            BlocProvider<BlogBloc>.value(value: mockBlogBloc),
          ],
          child: const MyApp(),
        ),
      );

      expect(find.byType(BlogPage), findsOneWidget);
    });
  });
}
