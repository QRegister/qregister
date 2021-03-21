import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qregister/src/data/mappers/receipt_mapper.dart';
import 'package:qregister/src/domain/entities/receipt.dart';
import 'package:qregister/src/domain/repositories/receipt_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataReceiptRepository implements ReceiptRepository {
  static final _instance = DataReceiptRepository._internal();

  DataReceiptRepository._internal();

  factory DataReceiptRepository() => _instance;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _fireAuth = FirebaseAuth.instance;

  List<Receipt> _receipts = [];
  List<Receipt> _archivedReceipts = [];

  @override
  Future<String> addReceiptToUser(Receipt receipt, String uid) async {
    // Firestore update
    await _firestore.collection('users').doc(uid).update({
      'receipts': FieldValue.arrayUnion([receipt.toMap()]),
    });

    // Local repository update
    _receipts.add(receipt);

    return receipt.id;
  }

  @override
  Future<String> archiveReceiptOfUser(String receiptId, String uid) async {
    int index = this._receipts.indexWhere((element) => element.id == receiptId);

    // Firestore update
    await _firestore.collection('users').doc(uid).update({
      'receipts':
          FieldValue.arrayRemove([this._receipts.elementAt(index).toMap()]),
    });

    await _firestore.collection('users').doc(uid).update({
      'archivedReceipts':
          FieldValue.arrayUnion([this._receipts.elementAt(index).toMap()]),
    });

    // Local repository update

    this._archivedReceipts.add(this._receipts.elementAt(index));
    this._receipts.removeAt(index);

    return receiptId;
  }

  @override
  Future<Receipt> getReceiptById(String receiptId) async {
    final snapshot =
        await _firestore.collection('receipts').doc(receiptId).get();

    Receipt receipt = ReceiptMapper.createReceiptFromMap(snapshot.data());
    receipt.id = receiptId;
    return receipt;
  }

  @override
  List<Receipt> getArchivedReceiptsOfUser() {
    _archivedReceipts.sort((b, a) => a.date.compareTo(b.date));
    return this._archivedReceipts;
  }

  @override
  List<Receipt> getReceiptsOfUser() {
    _receipts.sort((b, a) => a.date.compareTo(b.date));
    return this._receipts;
  }

  @override
  Future<bool> checkStorageForReceiptIdsAndUploadIfThereIsAny() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> receiptIdList = prefs.getStringList('receiptIds');
      if (receiptIdList == null || receiptIdList.length == 0) {
        return false;
      }

      List<Map<String, dynamic>> receiptMapList = [];

      await Future.forEach(receiptIdList, (id) async {
        final snapshot = await _firestore.collection('receipts').doc(id).get();
        if (snapshot.data() != null) receiptMapList.add(snapshot.data());
      });

      List<Map<String, dynamic>> sanitizedReceiptMapList = [];

      receiptMapList.forEach((receipt) {
        sanitizedReceiptMapList.add(ReceiptMapper.sanitizeReceiptMap(receipt));
      });

      // Firestore update

      await _firestore
          .collection('users')
          .doc(_fireAuth.currentUser.uid)
          .update({
        'receipts': FieldValue.arrayUnion(sanitizedReceiptMapList),
      });

      // Initialized repository update

      sanitizedReceiptMapList.forEach((map) {
        this._receipts.add(ReceiptMapper.createReceiptFromMap(map));
      });

      prefs.remove('receiptIds');

      return true;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  void initializeRepository(List<dynamic> receiptsOfUser,
      List<dynamic> archivedReceiptsOfUser) async {
    // Necessary for signOut event
    this._receipts = [];
    this._archivedReceipts = [];
    // Ends here
    if (receiptsOfUser != null && receiptsOfUser.isNotEmpty) {
      receiptsOfUser.forEach((element) {
        this._receipts.add(ReceiptMapper.createReceiptFromMap(element));
      });
    }
    _receipts.sort((b, a) => a.date.compareTo(b.date));

    if (archivedReceiptsOfUser != null && archivedReceiptsOfUser.isNotEmpty) {
      archivedReceiptsOfUser.forEach((element) {
        this._archivedReceipts.add(ReceiptMapper.createReceiptFromMap(element));
      });
    }
  }
}
