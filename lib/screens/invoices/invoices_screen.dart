import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:watch_it/watch_it.dart';

import '../../dependencies.dart';
import '../../models/invoice.dart';
import '../../routing.dart';
import '../../services/firebase_service.dart';
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
      ),
      afterRegister: (controller) => controller.getUserName(),
    );
  }

  @override
  void dispose() {
    getIt.unregister<InvoicesController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firebase = getIt.get<FirebaseService>();
    final userName = watchIt<InvoicesController>().value;

    return Scaffold(
      ///
      /// FAB
      ///
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final invoices = await firebase.getInvoices();

          openInvoice(
            context,
            lastInvoice: invoices?.firstOrNull,
          );
        },
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
        icon: Image.asset(
          RacunkoIcons.invoice,
          height: 28,
          width: 28,
          color: context.colors.white,
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
              child: Text(
                'Pozdrav${userName != null ? ', $userName' : ''}. 👋🏼',
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

            ///
            /// INVOICES
            ///
            StreamBuilder<List<Invoice>?>(
              stream: firebase.getInvoicesStream(),
              builder: (context, snapshot) {
                ///
                /// LOADING
                ///
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: [
                      const SizedBox(height: 64),
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
                  );
                }

                ///
                /// ERROR
                ///
                if (snapshot.hasError) {
                  return Column(
                    children: [
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
                            'Dogodila se greška',
                            style: context.textStyles.subtitle.copyWith(
                              color: context.colors.red,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            snapshot.error.toString(),
                            style: context.textStyles.text,
                          ),
                        ),
                      ),
                    ],
                  );
                }

                ///
                /// SUCCESS
                ///
                final invoices = snapshot.data ?? [];

                return Column(
                  children: [
                    if (invoices.isEmpty) ...[
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
                            deletePressed: () => showDialog(
                              context: context,
                              builder: (context) => InvoiceDeleteDialog(
                                text: userName != null
                                    ? '${userName[0].toUpperCase()}${userName.substring(1)}, jesi li siguran da želiš obrisati ovaj račun?'
                                    : 'Jesi li siguran da želiš obrisati ovaj račun?',
                                cancelPressed: Navigator.of(context).pop,
                                deletePressed: () {
                                  Navigator.of(context).pop();
                                  getIt.get<FirebaseService>().deleteInvoice(invoice);
                                },
                              ),
                            ),
                            generatePdfPressed: () => getIt.get<InvoicesController>().generatePDF(invoice),
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
