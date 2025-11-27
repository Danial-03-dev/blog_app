import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/models/user_modal.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.connectionChecker,
  });

  Future<Either<Failure, User>> _getUser(Future<User?> Function() fn) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(message: 'No internet connection!'));
      }

      final user = await fn();

      if (user == null) {
        return left(Failure(message: 'User is not logged in!'));
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () => remoteDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () => remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    if (!await (connectionChecker.isConnected)) {
      final session = remoteDataSource.currentUserSession;

      if (session == null) {
        return left(Failure(message: 'User is not logged in!'));
      }

      final user = session.user;

      return right(UserModal(id: user.id, name: "", email: user.email ?? ''));
    }

    return _getUser(() => remoteDataSource.getCurrentUserData());
  }
}
