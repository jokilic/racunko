import 'package:flutter/material.dart';

import 'screens/invoices/invoices_screen.dart';
import 'util/navigation.dart';

/// Opens [InvoicesScreen]
void openInvoices(BuildContext context) => pushScreen(
      InvoicesScreen(),
      context: context,
    );
