import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth_source.dart';
import 'package:flutter_clean_arc/core/error/failures.dart';
import 'package:flutter_clean_arc/core/params/login_param.dart';
import 'package:flutter_clean_arc/features/auth/data/models/access_token_model.dart';

@LazySingleton(as: AuthSource)
class FirebaseSourceImpl implements AuthSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<AccessTokenModel> auth(LoginParam param) async {
    try {
      final UserCredential user = await _auth.signInWithEmailAndPassword(
        email: param.email,
        password: param.password
      );

      final String token = await user.user!.getIdToken();

      return AccessTokenModel(token: token);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'invalid-email') {
        throw UnauthorizedFailure();
      } else if (e.code == 'user-not-found') {
        throw NotFoundFailure();
      }

      throw ServerFailure();
    }
  }
  
  @override
  Future<void> logout() async => await _auth.signOut();
}
