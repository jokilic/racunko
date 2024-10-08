import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watch_it/watch_it.dart';

import '../../dependencies.dart';
import '../../routing.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../theme/icons.dart';
import '../../theme/theme.dart';
import 'invoices_controller.dart';
import 'widgets/invoice_list_tile.dart';

class InvoicesScreen extends WatchingStatefulWidget {
  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  final illustrations = [
    RacunkoIcons.illustration1,
    RacunkoIcons.illustration2,
  ];

  @override
  void initState() {
    super.initState();

    registerIfNotInitialized<InvoicesController>(
      () => InvoicesController(
        logger: getIt.get<LoggerService>(),
        hive: getIt.get<HiveService>(),
      ),
    );
  }

  @override
  void dispose() {
    getIt.unregister<InvoicesController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final invoices = watchIt<InvoicesController>().value;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => openInvoice(context),
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
            if (invoices.isEmpty) ...[
              const SizedBox(height: 56),
              Image.asset(
                illustrations[Random().nextInt(illustrations.length)],
                height: 256,
                width: 256,
              ),
              const SizedBox(height: 40),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Trenutno nemaš računa',
                    style: context.textStyles.subtitle,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "Stisni tipku 'Novi račun'",
                    style: context.textStyles.text,
                  ),
                ),
              ),
            ] else ...[
              ListView.separated(
                shrinkWrap: true,
                itemCount: invoices.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  final invoice = invoices[index];

                  return InvoiceListTile(
                    invoice: invoice,
                    onPressed: () => openInvoice(
                      context,
                      invoiceToEdit: invoice,
                    ),
                    deletePressed: () async {
                      await getIt.get<HiveService>().deleteInvoice(invoice);
                      getIt.get<InvoicesController>().updateState();
                    },
                    generatePdfPressed: () async {
                      print('Generate PDF pressed');
                    },
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
