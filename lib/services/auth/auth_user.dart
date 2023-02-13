import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final bool isEmailVerified;
  const AuthUser(this.isEmailVerified);

  // Questo permette di creare una sorta di override del costruttore. Prende
  // come parametro l'user e crea una istanza di AuthUser guardando la
  // emailVerified dello user passato come parametro
  factory AuthUser.fromFirebase(User user) => AuthUser(user.emailVerified);
}
