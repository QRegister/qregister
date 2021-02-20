import 'package:qreceipt/src/domain/entities/receipt.dart';
import 'package:qreceipt/src/domain/repositories/receipt_repository.dart';

class DataReceiptRepository extends ReceiptRepository {
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
    // TODO: implement getArchivedReceiptsOfUser
    throw UnimplementedError();
  }

  @override
  List<Receipt> getReceiptsOfUser() {
    // TODO: implement getReceiptsOfUser
    throw UnimplementedError();
  }

  @override
  Future<void> initializeRepository(String uid) async {
    print('Receipt repo initialized');
  }
}
