import 'package:flutter/material.dart';

import '../../services/firebase_service.dart';
import '../../services/logger_service.dart';

class InvoicesController extends ValueNotifier<String?> {
  final LoggerService logger;
  final FirebaseService firebase;

  InvoicesController({
    required this.logger,
    required this.firebase,
  }) : super(null);

  /// Gets username and updates state
  Future<void> getUserName() async {
    final userName = await firebase.getUserName();
    value = userName;
  }
}
