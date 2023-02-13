import 'package:mynotes/services/auth/auth_user.dart';

/// Classe astratta che fornisce una interfaccia che tutti i provider devono
/// mantenere (nel caso in cui volessi usare google, facebook o altri dovrebbero
/// rispettare questa interfaccia)
abstract class AuthProvider {
  AuthUser? get currentUser;
  Future<AuthUser> logIn({
    required String username,
    required String password,
  });
  Future<AuthUser> createUser({
    required String username,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
}
