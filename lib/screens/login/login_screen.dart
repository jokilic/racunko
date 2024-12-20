import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watch_it/watch_it.dart';

import '../../dependencies.dart';
import '../../services/audio_service.dart';
import '../../services/firebase_service.dart';
import '../../services/logger_service.dart';
import '../../theme/icons.dart';
import '../../theme/theme.dart';
import '../../widgets/racunko_text_field.dart';
import 'login_controller.dart';

class LoginScreen extends WatchingStatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();

    registerIfNotInitialized<LoginController>(
      () => LoginController(
        logger: getIt.get<LoggerService>(),
        firebase: getIt.get<FirebaseService>(),
      ),
    );
  }

  @override
  void dispose() {
    getIt.unregister<LoginController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = getIt.get<LoginController>();

    final loginButtonState = watchIt<LoginController>().value;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///
              /// APP BAR
              ///
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Prijavi se.',
                            style: context.textStyles.title,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onLongPress: getIt.get<AudioService>().playAudio,
                          child: Image.asset(
                            RacunkoIcons.wave,
                            height: 48,
                            width: 48,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Danas je ${DateFormat(
                        'd. MMMM y.',
                        'hr',
                      ).format(DateTime.now())}',
                      style: context.textStyles.text,
                    ),
                  ),
                ],
              ),

              ///
              /// IMAGE
              ///
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Image.asset(
                      RacunkoIcons.illustration,
                    ),
                  ),
                ),
              ),

              ///
              /// TEXT FIELDS
              ///
              Column(
                children: [
                  RacunkoTextField(
                    textController: controller.emailController,
                    hintText: 'Email',
                    onChanged: (_) => controller.validateEmailAndPassword(),
                    isCurrency: false,
                    textInputType: TextInputType.emailAddress,
                    verticalPadding: 16,
                  ),
                  const SizedBox(height: 20),
                  RacunkoTextField(
                    textController: controller.passwordController,
                    hintText: 'Lozinka',
                    onChanged: (_) => controller.validateEmailAndPassword(),
                    isCurrency: false,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    obscureText: true,
                    verticalPadding: 16,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              ///
              /// BUTTON
              ///
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.paddingOf(context).bottom,
                ),
                child: ElevatedButton.icon(
                  onPressed: loginButtonState ? controller.loginUser : null,
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Image.asset(
                      RacunkoIcons.login,
                      height: 28,
                      width: 28,
                      color: context.colors.invertedText,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: context.colors.primary,
                    foregroundColor: context.colors.invertedText,
                    overlayColor: context.colors.background,
                    disabledBackgroundColor: context.colors.disabled,
                    disabledForegroundColor: context.colors.invertedText,
                    textStyle: context.textStyles.button,
                  ),
                  label: const Text('Prijavi se'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
