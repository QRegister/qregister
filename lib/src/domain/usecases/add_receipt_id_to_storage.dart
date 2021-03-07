import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/repositories/file_repository.dart';

class AddReceiptIdToStorage extends UseCase<void, AddReceiptIdToStorageParams> {
  final FileRepository _fileRepository;

  AddReceiptIdToStorage(this._fileRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(
      AddReceiptIdToStorageParams params) async {
    StreamController<void> controller = StreamController();
    try {
      await _fileRepository.addReceiptIdToStorage(params.receiptId);
      controller.close();
      logger.finest('AddReceiptIdToStorage Successful');
    } catch (error) {
      print(error);
      controller.addError(error);
      logger.severe('AddReceiptIdToStorage Unsuccessful');
    }
    return controller.stream;
  }
}

class AddReceiptIdToStorageParams {
  final String receiptId;

  AddReceiptIdToStorageParams(this.receiptId);
}
