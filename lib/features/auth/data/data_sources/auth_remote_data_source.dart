import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_modal.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

abstract interface class AuthRemoteDataSource {
  sb.Session? get currentUserSession;

  Future<UserModal> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModal> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModal?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final sb.SupabaseClient supabaseClient;

  const AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  sb.Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModal> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUserModal(
      () => supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<UserModal> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUserModal(
      () => supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      ),
    );
  }

  Future<UserModal> _getUserModal(Future<sb.AuthResponse> Function() fn) async {
    try {
      final response = await fn();

      if (response.user == null) {
        throw const ServerException(message: 'User is null!');
      }
      return userWithExtraSessionInfo(
        UserModal.fromJson(response.user!.toJson()),
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModal?> getCurrentUserData() async {
    try {
      if (currentUserSession == null) return null;

      final userData = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', currentUserSession!.user.id);

      return userWithExtraSessionInfo(UserModal.fromJson(userData.first));
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  UserModal userWithExtraSessionInfo(UserModal userModal) {
    return userModal.copyWith(email: currentUserSession!.user.email);
  }
}
