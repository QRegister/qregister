import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/repositories/receipt_repository.dart';

class CheckStorageForReceiptIdsAndUploadIfThereIsAny
    extends UseCase<bool, void> {
  final ReceiptRepository _receiptRepository;

  CheckStorageForReceiptIdsAndUploadIfThereIsAny(this._receiptRepository);

  @override
  Future<Stream<bool>> buildUseCaseStream(void params) async {
    StreamController<bool> controller = StreamController();
    try {
      final boolean = await _receiptRepository
          .checkStorageForReceiptIdsAndUploadIfThereIsAny();
      controller.add(boolean);
      controller.close();
      logger
          .finest('CheckStorageForReceiptIdsAndUploadIfThereIsAny Successful');
    } catch (error) {
      print(error);
      logger.severe(
          'CheckStorageForReceiptIdsAndUploadIfThereIsAny Unsuccessful');
      controller.addError(error);
    }
    return controller.stream;
  }
}
