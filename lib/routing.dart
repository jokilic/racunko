import 'package:flutter/material.dart';

import 'models/invoice.dart';
import 'screens/invoice/invoice_screen.dart';
import 'screens/invoices/invoices_screen.dart';
import 'util/navigation.dart';

/// Opens [InvoicesScreen]
void openInvoices(BuildContext context) => pushScreen(
      InvoicesScreen(),
      context: context,
    );

/// Opens [InvoiceScreen]
void openInvoice(
  BuildContext context, {
  Invoice? lastInvoice,
  Invoice? invoiceToEdit,
}) =>
    pushScreen(
      InvoiceScreen(
        lastInvoice: lastInvoice,
        invoiceToEdit: invoiceToEdit,
      ),
      context: context,
    );
