import 'package:flutter/material.dart';

import 'screens/create_invoice/create_invoice_screen.dart';
import 'screens/invoices/invoices_screen.dart';
import 'util/navigation.dart';

/// Opens [InvoicesScreen]
void openInvoices(BuildContext context) => pushScreen(
      InvoicesScreen(),
      context: context,
    );

/// Opens [CreateInvoiceScreen]
void openCreateInvoice(BuildContext context) => pushScreen(
      CreateInvoiceScreen(),
      context: context,
    );
