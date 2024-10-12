import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watch_it/watch_it.dart';

import '../../dependencies.dart';
import '../../routing.dart';
import '../../services/firebase_service.dart';
import '../../services/hive_service.dart';
import '../../services/logger_service.dart';
import '../../theme/icons.dart';
import '../../theme/theme.dart';
import 'invoices_controller.dart';
import 'widgets/invoice_delete_dialog.dart';
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
        firebase: getIt.get<FirebaseService>(),
        hive: getIt.get<HiveService>(),
      ),
      afterRegister: (controller) => controller
        ..listenInvoicesFromFirebase()
        ..getUserNameFromFirebase(),
    );
  }

  @override
  void dispose() {
    getIt.unregister<InvoicesController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = watchIt<InvoicesController>().value;

    return Scaffold(
      ///
      /// FAB
      ///
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async => openInvoice(
          context,
          lastInvoice: state?.invoices.firstOrNull,
        ),
        label: Text(
          'Novi račun',
          style: context.textStyles.fab,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: context.colors.success,
        splashColor: context.colors.success,
        foregroundColor: context.colors.invertedText,
        icon: Image.asset(
          RacunkoIcons.invoice,
          height: 28,
          width: 28,
          color: context.colors.invertedText,
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
            ///
            /// APP BAR
            ///
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      'Pozdrav${state?.username != null ? ', ${state!.username}' : ''}.',
                      style: context.textStyles.title,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onLongPress: getIt.get<FirebaseService>().auth.signOut,
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
            const SizedBox(height: 32),

            ///
            /// INVOICES
            ///
            Column(
              children: [
                if (state?.invoices.isEmpty ?? true) ...[
                  const SizedBox(height: 56),
                  Image.asset(
                    RacunkoIcons.illustration,
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
                    itemCount: state!.invoices.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      final invoice = state.invoices[index];

                      return InvoiceListTile(
                        invoice: invoice,
                        onPressed: () => openInvoice(
                          context,
                          invoiceToEdit: invoice,
                        ),
                        deletePressed: () => showDialog(
                          context: context,
                          builder: (context) => InvoiceDeleteDialog(
                            text: state.username != null
                                ? '${state.username![0].toUpperCase()}${state.username!.substring(1)}, jesi li siguran da želiš obrisati ovaj račun?'
                                : 'Jesi li siguran da želiš obrisati ovaj račun?',
                            cancelPressed: Navigator.of(context).pop,
                            deletePressed: () {
                              Navigator.of(context).pop();
                              getIt.get<FirebaseService>().deleteInvoice(invoice);
                            },
                          ),
                        ),
                        generatePdfPressed: () => getIt.get<InvoicesController>().pdfPressed(invoice),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
