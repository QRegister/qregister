import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/repositories/inventory_repository.dart';

class ReadInventoryCsv extends UseCase<void, void> {
  final InventoryRepository _inventoryRepository;

  ReadInventoryCsv(this._inventoryRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(void params) async {
    StreamController<void> controller = StreamController();
    try {
      await _inventoryRepository.readInventoryCsv();
      controller.close();
      logger.finest('ReadInventoryCsv Successful');
    } catch (error) {
      print(error);
      logger.severe('ReadInventoryCsv Unsuccessful');
      controller.addError(error);
    }
    return controller.stream;
  }
}
