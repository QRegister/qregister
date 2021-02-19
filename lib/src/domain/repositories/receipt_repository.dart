import 'package:qreceipt/src/domain/entities/receipt.dart';

abstract class ReceiptRepository {
  Future<void> initializeRepository(String uid);
  Future<String> addReceiptToUser(Receipt receipt, String uid);
  Future<String> archiveReceiptOfUser(String receiptId, String uid);
  List<Receipt> getReceiptsOfUser();
  List<Receipt> getArchivedReceiptsOfUser();
}
