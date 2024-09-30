import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dependencies.dart';
import 'firebase_options.dart';
import 'screens/invoices/invoices_screen.dart';
import 'theme/theme.dart';
import 'widgets/racunko_loader.dart';

Future<void> main() async {
  /// Initialize Flutter related tasks
  WidgetsFlutterBinding.ensureInitialized();

  /// Make sure the orientation is only `portrait`
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  /// Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Initialize services
  initializeServices();

  /// Wait for initialization to finish
  await getIt.allReady();

  /// Run [Racunko]
  runApp(RacunkoApp());
}

class RacunkoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: InvoicesScreen(),
        onGenerateTitle: (_) => 'Računko',
        theme: RacunkoTheme.light,
        builder: (_, child) => kDebugMode
            ? Banner(
                message: 'Računko'.toUpperCase(),
                color: Colors.indigo,
                location: BannerLocation.topEnd,
                layoutDirection: TextDirection.ltr,
                child: child ??
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

  // const MaterialApp(
  //       home: Scaffold(
  //         body: Center(
  //           child: Text('Hello World!'),
  //         ),
  //       ),
  //     );
}
