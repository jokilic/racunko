import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watch_it/watch_it.dart';

import '../../dependencies.dart';
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
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            16,
            24,
            16,
            MediaQuery.paddingOf(context).bottom + 56,
          ),
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Pozdrav, Milane. 👋🏼',
                style: context.textStyles.title,
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
            const SizedBox(height: 32),
            Image.asset(
              RacunkoIcons.illustrations[Random().nextInt(
                RacunkoIcons.illustrations.length,
              )],
              height: 256,
              width: 256,
            ),
            const SizedBox(height: 40),
            RacunkoTextField(
              textController: controller.emailController,
              hintText: 'Email',
              onChanged: (_) => controller.validateEmailAndPassword(),
              isCurrency: false,
            ),
            RacunkoTextField(
              textController: controller.passwordController,
              hintText: 'Password',
              onChanged: (_) => controller.validateEmailAndPassword(),
              isCurrency: false,
              textInputAction: TextInputAction.done,
            ),
            ElevatedButton.icon(
              onPressed: loginButtonState ? controller.loginUser : null,
              icon: const Icon(
                Icons.login,
                size: 28,
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: context.colors.darkBlue,
                foregroundColor: context.colors.white,
                overlayColor: context.colors.white,
                disabledBackgroundColor: context.colors.grey,
                disabledForegroundColor: context.colors.white,
                textStyle: context.textStyles.button,
              ),
              label: const Text('Prijavi se'),
            ),
          ],
        ),
      ),
    );
  }
}
