import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/domain/entities/receipt.dart';
import 'package:qreceipt/src/domain/repositories/receipt_repository.dart';

class GetReceiptById extends UseCase<Receipt, GetReceiptByIdParams> {
  final ReceiptRepository _receiptRepository;

  GetReceiptById(this._receiptRepository);

  @override
  Future<Stream<Receipt>> buildUseCaseStream(
      GetReceiptByIdParams params) async {
    StreamController<Receipt> controller = StreamController();
    try {
      Receipt receipt =
          await _receiptRepository.getReceiptById(params.receiptId);
      controller.add(receipt);
      controller.close();
      logger.finest('GetReceiptById Successful');
    } catch (error) {
      print(error);
      logger.severe('GetReceiptById Unsuccessful');
      controller.addError(error);
    }
    return controller.stream;
  }
}

class GetReceiptByIdParams {
  final String receiptId;

  GetReceiptByIdParams(this.receiptId);
}
