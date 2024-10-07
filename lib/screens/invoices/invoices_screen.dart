import 'package:flutter/material.dart';
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
        onPressed: () => openCreateInvoice(
          context,
          invoiceToEdit: null,
        ),
        label: Text(
          'Novi račun',
          style: context.textStyles.fab,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: context.colors.green,
        splashColor: context.colors.green,
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
            const SizedBox(height: 32),
            if (invoices.isEmpty) ...[
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Nemaš računa',
                    style: context.textStyles.subtitle,
                  ),
                ),
              ),
              const SizedBox(height: 56),
              Image.asset(
                RacunkoIcons.illustration1,
                height: 256,
                width: 256,
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
                    onPressed: () => openCreateInvoice(
                      context,
                      invoiceToEdit: invoice,
                    ),
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
