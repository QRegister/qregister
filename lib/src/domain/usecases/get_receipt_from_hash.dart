import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/entities/receipt.dart';
import 'package:qregister/src/domain/repositories/inventory_repository.dart';

class GetReceiptFromHash extends UseCase<Receipt, GetReceiptFromHashParams> {
  final InventoryRepository _inventoryRepository;

  GetReceiptFromHash(this._inventoryRepository);
  @override
  Future<Stream<Receipt>> buildUseCaseStream(
      GetReceiptFromHashParams params) async {
    StreamController<Receipt> controller = StreamController();
    try {
      final receipt =
          await _inventoryRepository.getReceiptFromHash(params.hash);
      controller.add(receipt);
      controller.close();
      logger.finest('GetReceiptFromHash Successful');
    } catch (error) {
      print(error);
      controller.addError(error);
      logger.severe('GetReceiptFromHash Unsuccessful');
    }
    return controller.stream;
  }
}

class GetReceiptFromHashParams {
  final String hash;

  GetReceiptFromHashParams(this.hash);
}
