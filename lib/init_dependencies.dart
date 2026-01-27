part of 'init_dependencies.main.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnnonKey,
  );

  await Hive.initFlutter();
  await Hive.openBox('blogs');

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => Hive.box('blogs'));

  _initCore();
  _initAuth();
  _initBlog();
}

void _initCore() {
  serviceLocator
    ..registerLazySingleton(
      () => AppUserCubit(blogLocalDataSource: serviceLocator()),
    )
    ..registerLazySingleton(() => InternetConnection())
    ..registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(internetConnection: serviceLocator()),
    );
}

void _initAuth() {
  // Data
  // Data - Data Source
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(supabaseClient: serviceLocator()),
    )
    // Domain
    // Domain - Repositories
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: serviceLocator(),
        connectionChecker: serviceLocator(),
      ),
    )
    // Domain - Use Cases
    ..registerFactory(() => UserSignUp(authRepository: serviceLocator()))
    ..registerFactory(() => UserLogin(authRepository: serviceLocator()))
    ..registerFactory(() => CurrentUser(authRepository: serviceLocator()))
    // Presentation
    // Presentation - Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  // Data
  // Data - Data Source
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(supabaseClient: serviceLocator()),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(box: serviceLocator()),
    )
    // Domain
    // Domain - Repositories
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        blogRemoteDataSource: serviceLocator(),
        blogLocalDataSource: serviceLocator(),
        connectionChecker: serviceLocator(),
      ),
    )
    // Domain - Use Cases
    ..registerFactory(() => UploadBlog(blogRepository: serviceLocator()))
    ..registerFactory(() => GetAllBlogs(blogRepository: serviceLocator()))
    ..registerFactory(
      () => GetCurrentUserBlogs(blogRepository: serviceLocator()),
    )
    ..registerFactory(() => DeleteBlog(blogRepository: serviceLocator()))
    // Presentation
    // Presentation - Bloc
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
        getCurrentUserBlogs: serviceLocator(),
        deleteBlog: serviceLocator(),
      ),
    );
}
