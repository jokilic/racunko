import 'package:get_it/get_it.dart';

import 'services/auth_service.dart';
import 'services/firebase_service.dart';
import 'services/firestore_service.dart';
import 'services/logger_service.dart';
import 'services/storage_service.dart';

final getIt = GetIt.instance;

/// Registers a class if it's not already initialized
/// Optionally runs a function with newly registered class
void registerIfNotInitialized<T extends Object>(
  T Function() factoryFunc, {
  required String instanceName,
  void Function(T controller)? afterRegister,
}) {
  if (!getIt.isRegistered<T>(instanceName: instanceName)) {
    getIt.registerLazySingleton<T>(
      factoryFunc,
      instanceName: instanceName,
    );

    if (afterRegister != null) {
      final instance = getIt.get<T>(instanceName: instanceName);
      afterRegister(instance);
    }
  }
}

void initializeServices() => getIt
  ..registerSingletonAsync(
    () async => LoggerService(),
  )
  ..registerSingletonAsync(
    () async => FirebaseService(
      logger: getIt.get<LoggerService>(),
    ),
    dependsOn: [LoggerService],
  )
  ..registerSingletonAsync(
    () async => AuthService(
      logger: getIt.get<LoggerService>(),
      firebase: getIt.get<FirebaseService>(),
    ),
    dependsOn: [LoggerService, FirebaseService],
  )
  ..registerSingletonAsync(
    () async => FirestoreService(
      logger: getIt.get<LoggerService>(),
      firebase: getIt.get<FirebaseService>(),
    ),
    dependsOn: [LoggerService, FirebaseService],
  )
  ..registerSingletonAsync(
    () async => StorageService(
      logger: getIt.get<LoggerService>(),
      firebase: getIt.get<FirebaseService>(),
    ),
    dependsOn: [LoggerService, FirebaseService],
  );
