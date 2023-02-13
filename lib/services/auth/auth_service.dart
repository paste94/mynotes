import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';

/// Questa classe ha come obiettivo quello di comunicare direttamente con
/// la UI. Questo significa che l'unica che deve essere chiamata dalla UI
/// è questa. Contiene un provider e semplicemente ne espone i metodi (ma in
/// casi più complessi può fare operazioni logiche prima di esporre i risultati,
/// magari anche integrando più provider diversi).
class AuthService implements AuthProvider {
  final AuthProvider provider;

  const AuthService(this.provider);

  @override
  Future<AuthUser> createUser({
    required String username,
    required String password,
  }) =>
      provider.createUser(username: username, password: password);

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({
    required String username,
    required String password,
  }) =>
      provider.logIn(
        username: username,
        password: password,
      );

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();
}
