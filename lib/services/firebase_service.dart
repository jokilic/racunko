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

  /// Login user
  Future<User?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final user = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return user.user;
    } catch (e) {
      logger.e('FirebaseService -> loginUser() -> $e');
      return null;
    }
  }

  Future<String?> getUserName() async {
    try {
      final user = auth.currentUser;

      if (user == null) {
        throw Exception('User not authenticated');
      }

      final docSnapshot = await firestore.collection('users').doc(user.uid).get();

      if (docSnapshot.exists) {
        return docSnapshot.data()?['userName'];
      }

      return null;
    } catch (e) {
      logger.e('FirebaseService -> getUserName() -> $e');
      return null;
    }
  }

  /// Fetch all invoices
  Future<List<Invoice>?> getInvoices() async {
    try {
      final user = auth.currentUser;

      if (user == null) {
        throw Exception('User not authenticated');
      }

      final userCollection = firestore.collection('users').doc(user.uid).collection('invoices');

      final querySnapshot = await userCollection.orderBy('createdDate', descending: true).get();

      return querySnapshot.docs.map((doc) => Invoice.fromFirestore(doc)).toList();
    } catch (e) {
      logger.e('FirebaseService -> getInvoices() -> $e');
      return null;
    }
  }

  Stream<List<Invoice>?> getInvoicesStream() {
    try {
      final user = auth.currentUser;

      if (user == null) {
        throw Exception('User not authenticated');
      }

      final userCollection = firestore.collection('users').doc(user.uid).collection('invoices');

      return userCollection.orderBy('createdDate', descending: true).snapshots().map((snapshot) => snapshot.docs.map((doc) => Invoice.fromFirestore(doc)).toList());
    } catch (e) {
      logger.e('FirebaseService -> getInvoicesStream() -> $e');
      return Stream.value(null);
    }
  }

  /// Add new invoice
  Future<bool> addNewInvoice(Invoice invoice) async {
    try {
      final user = auth.currentUser;

      if (user == null) {
        throw Exception('User not authenticated');
      }

      final userCollection = firestore.collection('users').doc(user.uid).collection('invoices');

      await userCollection.doc(invoice.id).set(invoice.toMap());

      return true;
    } catch (e) {
      logger.e('FirebaseService -> addNewInvoice() -> $e');
      return false;
    }
  }

  Future<bool> replaceInvoice({
    required String editedInvoiceId,
    required Invoice newInvoice,
  }) async {
    try {
      final user = auth.currentUser;

      if (user == null) {
        throw Exception('User not authenticated');
      }

      final userCollection = firestore.collection('users').doc(user.uid).collection('invoices');

      /// If authorized, proceed with the update
      await userCollection.doc(editedInvoiceId).set(newInvoice.toMap());

      return true;
    } catch (e) {
      logger.e('FirebaseService -> replaceInvoice() -> $e');
      return false;
    }
  }

  Future<bool> deleteInvoice(Invoice invoice) async {
    try {
      final user = auth.currentUser;

      if (user == null) {
        throw Exception('User not authenticated');
      }

      final userCollection = firestore.collection('users').doc(user.uid).collection('invoices');

      /// If authorized, proceed with the deletion
      await userCollection.doc(invoice.id).delete();

      return true;
    } catch (e) {
      logger.e('FirebaseService -> deleteInvoice() -> $e');
      return false;
    }
  }
}
