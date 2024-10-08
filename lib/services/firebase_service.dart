// ignore_for_file: unnecessary_lambdas

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/invoice.dart';
import 'logger_service.dart';

class FirebaseService {
  final LoggerService logger;
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseService({
    required this.logger,
    required this.auth,
    required this.firestore,
  });

  late final invoicesCollection = firestore.collection('invoices');

  /// Fetch all invoices
  Future<List<Invoice>> getInvoices() async {
    final user = auth.currentUser;

    if (user == null) {
      throw Exception('User not authenticated');
    }

    final querySnapshot = await invoicesCollection.where('userId', isEqualTo: user.uid).orderBy('createdDate', descending: true).get();

    return querySnapshot.docs.map((doc) => Invoice.fromFirestore(doc)).toList();
  }

  Stream<List<Invoice>> getInvoicesStream() {
    final user = auth.currentUser;

    if (user == null) {
      throw Exception('User not authenticated');
    }

    return invoicesCollection
        .where('userId', isEqualTo: user.uid)
        .orderBy('createdDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Invoice.fromFirestore(doc)).toList());
  }

  /// Add new invoice
  Future<void> addNewInvoice(Invoice invoice) async {
    final user = auth.currentUser;

    if (user == null) {
      throw Exception('User not authenticated');
    }

    await invoicesCollection.doc(invoice.id).set({
      ...invoice.toMap(),
      'userId': user.uid,
    });
  }

  Future<void> replaceInvoice({
    required String editedInvoiceId,
    required Invoice newInvoice,
  }) async {
    final user = auth.currentUser;

    if (user == null) {
      throw Exception('User not authenticated');
    }

    /// Check if the invoice belongs to the current user
    final docSnapshot = await invoicesCollection.doc(editedInvoiceId).get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data();

      if (data?['userId'] != user.uid) {
        throw Exception('Not authorized to edit this invoice');
      }
    } else {
      throw Exception('Invoice not found');
    }

    /// If authorized, proceed with the update
    await invoicesCollection.doc(editedInvoiceId).set({
      ...newInvoice.toMap(),
      'userId': user.uid,
    });
  }

  Future<void> deleteInvoice(Invoice invoice) async {
    final user = auth.currentUser;

    if (user == null) {
      throw Exception('User not authenticated');
    }

    /// Check if the invoice belongs to the current user
    final docSnapshot = await invoicesCollection.doc(invoice.id).get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data();

      if (data?['userId'] != user.uid) {
        throw Exception('Not authorized to delete this invoice');
      }
    } else {
      throw Exception('Invoice not found');
    }

    /// If authorized, proceed with the deletion
    await invoicesCollection.doc(invoice.id).delete();
  }
}
