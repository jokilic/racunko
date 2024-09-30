import 'firebase_service.dart';
import 'logger_service.dart';

class StorageService {
  final LoggerService logger;
  final FirebaseService firebase;

  StorageService({
    required this.logger,
    required this.firebase,
  });
}
