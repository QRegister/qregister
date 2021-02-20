import 'package:qreceipt/src/domain/entities/receipt.dart';

abstract class ReceiptRepository {
  void initializeRepository(
      List<dynamic> receipts, List<dynamic> archivedReceipts);
  Future<String> addReceiptToUser(Receipt receipt, String uid);
  Future<String> archiveReceiptOfUser(String receiptId, String uid);
  List<Receipt> getReceiptsOfUser();
  List<Receipt> getArchivedReceiptsOfUser();
}
