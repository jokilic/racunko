import 'firebase_service.dart';
import 'logger_service.dart';

class AuthService {
  final LoggerService logger;
  final FirebaseService firebase;

  AuthService({
    required this.logger,
    required this.firebase,
  });
}
