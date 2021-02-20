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
  Future<String> addReceiptToUser(Receipt receipt, String uid) {
    // TODO: implement addReceiptToUser
    throw UnimplementedError();
  }

  @override
  Future<String> archiveReceiptOfUser(String receiptId, String uid) {
    // TODO: implement archiveReceiptOfUser
    throw UnimplementedError();
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
    if (receiptsOfUser != null && archivedReceiptsOfUser.isNotEmpty) {
      archivedReceiptsOfUser.forEach((element) {
        this._archivedReceipts.add(ReceiptMapper.createReceiptFromMap(element));
      });
    }
  }
}
