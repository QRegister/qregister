import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/domain/entities/receipt.dart';
import 'package:qreceipt/src/domain/repositories/receipt_repository.dart';

class GetArchivedReceiptsOfUser extends UseCase<List<Receipt>, void> {
  final ReceiptRepository _receiptRepository;

  GetArchivedReceiptsOfUser(this._receiptRepository);

  @override
  Future<Stream<List<Receipt>>> buildUseCaseStream(void params) async {
    StreamController<List<Receipt>> controller = StreamController();
    try {
      List<Receipt> receipts = _receiptRepository.getArchivedReceiptsOfUser();
      logger.finest('GetArchivedReceiptsOfUser Successful');
      controller.add(receipts);
      controller.close();
    } catch (error) {
      print(error);
      logger.severe('GetArchivedReceiptsOfUser Unsuccessful');
      controller.addError(error);
    }
    return controller.stream;
  }
}
