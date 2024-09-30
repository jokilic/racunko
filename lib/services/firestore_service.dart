import 'firebase_service.dart';
import 'logger_service.dart';

class FirestoreService {
  final LoggerService logger;
  final FirebaseService firebase;

  FirestoreService({
    required this.logger,
    required this.firebase,
  });
}
