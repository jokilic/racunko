import 'package:flutter/material.dart';

import '../../routing.dart';
import '../../theme/theme.dart';

class InvoicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => openCreateInvoice(context),
          label: Text(
            'Novi račun',
            style: context.textStyles.fab,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: context.colors.darkBlue,
          splashColor: context.colors.darkBlue,
          foregroundColor: context.colors.white,
          icon: const Icon(
            Icons.receipt_long,
            size: 28,
          ),
        ),
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
                  'Pozdrav, Milan. 👋🏼',
                  style: context.textStyles.title,
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Tvoji računi',
                    style: context.textStyles.subtitle,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                itemCount: 12,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.colors.grey,
                  ),
                ),
                separatorBuilder: (_, __) => Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 120),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
