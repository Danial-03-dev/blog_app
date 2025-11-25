part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class AuthSignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const AuthSignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

final class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginEvent({required this.email, required this.password});
}

final class AuthIsUserLoggedInEvent extends AuthEvent {
  const AuthIsUserLoggedInEvent();
}
