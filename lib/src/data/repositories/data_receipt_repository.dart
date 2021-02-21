import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qreceipt/src/data/mappers/receipt_mapper.dart';
import 'package:qreceipt/src/domain/entities/receipt.dart';
import 'package:qreceipt/src/domain/repositories/receipt_repository.dart';

class DataReceiptRepository extends ReceiptRepository {
  static final _instance = DataReceiptRepository._internal();

  DataReceiptRepository._internal();

  factory DataReceiptRepository() => _instance;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
    this._archivedReceipts.removeAt(index);

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
    return this._archivedReceipts;
  }

  @override
  List<Receipt> getReceiptsOfUser() {
    return this._receipts;
  }

  @override
  void initializeRepository(List<dynamic> receiptsOfUser,
      List<dynamic> archivedReceiptsOfUser) async {
    if (receiptsOfUser != null && receiptsOfUser.isNotEmpty) {
      receiptsOfUser.forEach((element) {
        this._receipts.add(ReceiptMapper.createReceiptFromMap(element));
      });
    }
    if (archivedReceiptsOfUser != null && archivedReceiptsOfUser.isNotEmpty) {
      archivedReceiptsOfUser.forEach((element) {
        this._archivedReceipts.add(ReceiptMapper.createReceiptFromMap(element));
      });
    }
  }
}
