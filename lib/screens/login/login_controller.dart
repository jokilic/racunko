import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../services/firebase_service.dart';
import '../../services/logger_service.dart';
import '../../util/email.dart';

class LoginController extends ValueNotifier<bool> implements Disposable {
  final LoggerService logger;
  final FirebaseService firebase;

  LoginController({
    required this.logger,
    required this.firebase,
  }) : super(false);

  ///
  /// VARIABLES
  ///

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  ///
  /// DISPOSE
  ///

  @override
  void onDispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  ///
  /// METHODS
  ///

  /// Triggered when the user presses login button
  /// Logs user into [Firebase]
  Future<User?> loginUser() async {
    /// Parse values
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    return firebase.loginUser(
      email: email,
      password: password,
    );
  }

  /// Triggered on every [TextField] change
  /// Validates email & password
  /// Updates login button state
  bool validateEmailAndPassword() {
    /// Parse values
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    /// Validate values
    return value = isValidEmail(email) && password.length >= 8;
  }
}
