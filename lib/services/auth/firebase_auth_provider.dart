import 'package:firebase_core/firebase_core.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;

import '../../firebase_options.dart';

/// Implementazione del provider. Questa comunica direttamente con Firebase e
/// effettua tutti i controlli nel caso ci siano errori o null sparsi in giro.
class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((_) => currentUser ?? (throw UserNotLoggedInAuthExcpetion));

  @override
  AuthUser? get currentUser => FirebaseAuth.instance.currentUser != null
      ? AuthUser.fromFirebase(FirebaseAuth.instance.currentUser!)
      : null;

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((_) => currentUser ?? (throw UserNotLoggedInAuthExcpetion));

  @override
  Future<void> logOut() => FirebaseAuth.instance.currentUser != null
      ? FirebaseAuth.instance.signOut()
      : throw UserNotLoggedInAuthExcpetion();

  @override
  Future<void> sendEmailVerification() =>
      FirebaseAuth.instance.currentUser != null
          ? FirebaseAuth.instance.currentUser!.sendEmailVerification()
          : throw UserNotLoggedInAuthExcpetion();

  @override
  Future<void> initialize() =>
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
