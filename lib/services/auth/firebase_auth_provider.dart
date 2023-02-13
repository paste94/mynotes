import 'package:mynotes/services/auth/auth_user.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';

import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;

/// Implementazione del provider. Questa comunica direttamente con Firebase e
/// effettua tutti i controlli nel caso ci siano errori o null sparsi in giro.
class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser({
    required String username,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      }
      throw UserNotLoggedInAuthExcpetion();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthExcpetion();
      }
    } catch (_) {
      throw GenericAuthExcpetion();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    }
    return null;
  }

  @override
  Future<AuthUser> logIn({
    required String username,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      }
      throw UserNotLoggedInAuthExcpetion();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthExcpetion();
      }
    } catch (_) {
      throw GenericAuthExcpetion();
    }
  }

  @override
  Future<void> logOut() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseAuth.instance.signOut();
    }
    throw UserNotLoggedInAuthExcpetion();
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthExcpetion();
    }
  }
}
