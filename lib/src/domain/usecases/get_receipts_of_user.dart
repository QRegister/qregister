import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/entities/receipt.dart';
import 'package:qregister/src/domain/repositories/receipt_repository.dart';

class GetReceiptsOfUser extends UseCase<List<Receipt>, void> {
  final ReceiptRepository _receiptRepository;

  GetReceiptsOfUser(this._receiptRepository);

  @override
  Future<Stream<List<Receipt>>> buildUseCaseStream(void params) async {
    StreamController<List<Receipt>> controller = StreamController();
    try {
      List<Receipt> receipts = _receiptRepository.getReceiptsOfUser();
      logger.finest('GetReceiptsOfUser Successful');
      controller.add(receipts);
      controller.close();
    } catch (error) {
      print(error);
      logger.severe('GetReceiptsOfUser Unsuccessful');
      controller.addError(error);
    }
    return controller.stream;
  }
}
