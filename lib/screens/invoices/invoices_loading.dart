import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../theme/theme.dart';

class InvoicesLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Pozdrav. 👋🏼',
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
                  ],
                ),
                Column(
                  children: [
                    SpinKitPouringHourGlassRefined(
                      color: context.colors.darkBlue,
                      size: 48,
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Učitavanje...',
                          style: context.textStyles.subtitle,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.paddingOf(context).bottom + 80,
                ),
              ],
            ),
          ),
        ),
      );
}
