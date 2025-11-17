import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:watch_it/watch_it.dart';

import 'dependencies.dart';
import 'firebase_options.dart';
import 'screens/invoices/invoices_loading.dart';
import 'screens/invoices/invoices_screen.dart';
import 'screens/login/login_screen.dart';
import 'theme/theme.dart';
import 'util/display_mode.dart';
import 'widgets/racunko_loader.dart';

Future<void> main() async {
  /// Initialize [Flutter] related tasks
  WidgetsFlutterBinding.ensureInitialized();

  /// Make sure the orientation is only `portrait`
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  /// Use `edge-to-edge` display
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  /// Set refresh rate to high
  await setDisplayMode();

  /// Initialize [Firebase]
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Initialize services
  initializeServices();

  /// Date formatting
  await initializeDateFormatting('hr');

  /// Wait for initialization to finish
  await getIt.allReady();

  /// Run [Racunko]
  runApp(RacunkoApp());
}

class RacunkoApp extends WatchingWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    supportedLocales: const [Locale('hr')],
    debugShowCheckedModeBanner: false,
    home: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        ///
        /// LOADING
        ///
        if (snapshot.connectionState == ConnectionState.waiting) {
          return InvoicesLoading();
        }

        ///
        /// USER LOGGED IN
        ///
        if (snapshot.hasData) {
          return InvoicesScreen();
        }

        ///
        /// NO USER
        ///
        return LoginScreen();
      },
    ),
    onGenerateTitle: (_) => 'Računko',
    theme: RacunkoTheme.light,
    darkTheme: RacunkoTheme.dark,
    builder: (_, child) => kDebugMode
        ? Banner(
            message: 'Računko'.toUpperCase(),
            color: context.colors.primary,
            location: BannerLocation.topEnd,
            layoutDirection: TextDirection.ltr,
            child:
                child ??
                Scaffold(
                  body: Center(
                    child: RacunkoLoader(),
                  ),
                ),
          )
        : child ??
              Scaffold(
                body: Center(
                  child: RacunkoLoader(),
                ),
              ),
  );
}
